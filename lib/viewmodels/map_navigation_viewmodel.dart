import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/earn_point_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:geocoding/geocoding.dart' as geo;

class MapNavigationViewModel extends BaseViewModel {
  String _tripId = "";
  String _startLocationAddress = "";
  String _destinationAddress = "";

  List<CarpoolRequest> _acceptedCarpoolRequestList = [];

  List<geo.Location> _sourceLocationList = [];
  List<geo.Location> _destinationLocationList = [];

  Completer<GoogleMapController> _controller = Completer();

  LatLng _sourceLocation = LatLng(0, 0);
  LatLng _destination = LatLng(0, 0);

  LocationData? currentLocation;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String tripId) {
    // set trip Id
    _tripId = tripId;

    // setup map navigation
    setupMap(tripId);
  }

  void onModelDestroy() {}

  Future<void> setupMap(String tripId) async {
    // set custom marker in map for user location, start location and destination
    await setCustomMarkerIcon();
    // get trip details
    await getTrip(tripId);
    // get coordinates of source and destination address
    await getAddressLatLng();
    // get routes between coordinates and draw polyline points
    await getPolyPoints();
    // track user live location and animate google map camera
    await getCurrentLocation();
    notifyListeners();
  }

  Future<void> getTrip(String tripId) async {
    // get trip details
    Trip trip = await _firebaseService.getTrip(tripId);

    // set start location and destination address
    _startLocationAddress = trip.startLocation;
    _destinationAddress = trip.destination;

    notifyListeners();
  }

  Future<void> getAddressLatLng() async {
    // get coordinates from address
    _sourceLocationList = await geo.locationFromAddress(_startLocationAddress);
    _destinationLocationList =
        await geo.locationFromAddress(_destinationAddress);
    print(_sourceLocationList[0].toString());
    print(_destinationLocationList[0].toString());

    // get latitude and longitude from the coordinates and save as LatLng object
    _sourceLocation = LatLng(
        _sourceLocationList[0].latitude, _sourceLocationList[0].longitude);
    _destination = LatLng(_destinationLocationList[0].latitude,
        _destinationLocationList[0].longitude);

    notifyListeners();
  }

  List<LatLng> polylineCoordinates = [];

  Future<void> getPolyPoints() async {
    // set Google Map API key
    String API_KEY = dotenv.env['GOOGLE_API_KEY']??'';

    // initialize polypoints
    PolylinePoints polylinePoints = PolylinePoints();

    // use Directions API to get routes between coordinates and draw polyline
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      API_KEY, // Google Map API Key
      PointLatLng(_sourceLocation.latitude,
          _sourceLocation.longitude), // coordinates of source location
      PointLatLng(_destination.latitude,
          _destination.longitude), // coordinates of destination location
    );

    // add polyline coordinates for each points in the result
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      notifyListeners();
    }
  }

  // initialize bitmap descriptor for map marker
  BitmapDescriptor _sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _currentLocationIcon = BitmapDescriptor.defaultMarker;

  Future<void> setCustomMarkerIcon() async {
    // set custom marker for user current location
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/source_pin.png')
        .then(
      (icon) {
        _sourceIcon = icon;
      },
    );

    // set custom marker for destination location
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/destination_pin.png")
        .then(
      (icon) {
        _destinationIcon = icon;
      },
    );

    // set custom marker for source location
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/avatar_pin.png")
        .then(
      (icon) {
        _currentLocationIcon = icon;
      },
    );
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    // get user current location
    Location location = Location();
    currentLocation = await location.getLocation();
    notifyListeners();

    // get the controller for the google map
    GoogleMapController googleMapController = await _controller.future;

    // track user live location
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;

        // animate google map camera position to user new current location
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );

        print(currentLocation.toString());
        notifyListeners();
      },
    );
  }

  Future<void> completeTrip() async {
    // update trip status to Completed
    await _firebaseService.completeTrip(_tripId);

    // create points earned record for driver
    EarnPoint ep = EarnPoint(
        tripId: _tripId,
        userId: _firebaseService.userId,
        points: 150,
        role: "Driver");
    await _firebaseService.createPointsEarn(ep);

    // get current user
    Users currentUser =
        await _firebaseService.getUserData(_firebaseService.userId);
    // add driver points
    int driverPoints = currentUser.points + 150;
    // update user points to database
    await _firebaseService.updateUserPoints(
        _firebaseService.userId, driverPoints);

    // get list of passengers of the trip
    _acceptedCarpoolRequestList =
        await _firebaseService.getAcceptedCarpoolRequestList(_tripId);

    for (var i = 0; i < _acceptedCarpoolRequestList.length; i++) {
      // get user data for each passenger
      Users passenger = await _firebaseService
          .getUserData(_acceptedCarpoolRequestList[i].requesterId);

      // create points earned record for passenger
      EarnPoint passengerEp = EarnPoint(
          tripId: _tripId,
          userId: _acceptedCarpoolRequestList[i].requesterId,
          points: 50,
          role: "Passenger");
      await _firebaseService.createPointsEarn(passengerEp);

      // add passenger points
      int passengerPoints = passenger.points + 50;
      // update user points to database
      await _firebaseService.updateUserPoints(
          _acceptedCarpoolRequestList[i].requesterId, passengerPoints);
    }

    notifyListeners();
  }

  Future<bool> showConfirmationDialog(BuildContext context) async {
    // Show the confirmation message dialog when floating button is clicked
    bool? showConfirm = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (context) => AlertDialog(
        title: Text('Complete Trip'),
        content: Text("Are you sure you want to complete the trip?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel confirmation
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Confirm complete trip
              completeTrip(); // function to update trip status and add user points
              showSuccessDialog(context); // show successful update dialog
              Navigator.of(context).pop(); // return to previous page
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return showConfirm ?? false; // Return false if the dialog is dismissed
  }

  Future<bool> showSuccessDialog(BuildContext context) async {
    Navigator.of(context).pop();

    // Show the success message
    bool? showSuccess = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('You have earned 150 points'),
        content: Text("Check it out in Activity tab"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
    return showSuccess ?? false; // Return false if the dialog is dismissed
  }

  // getters
  LatLng get sourceLocation => _sourceLocation;
  LatLng get destination => _destination;
  Completer<GoogleMapController> get controller => _controller;
  List<geo.Location> get destinationLocationList => _destinationLocationList;
  List<geo.Location> get sourceLocationList => _sourceLocationList;
  String get destinationAddress => _destinationAddress;
  String get startLocationAddress => _startLocationAddress;
  BitmapDescriptor get currentLocationIcon => _currentLocationIcon;
  BitmapDescriptor get destinationIcon => _destinationIcon;
  BitmapDescriptor get sourceIcon => _sourceIcon;
  String get tripId => _tripId;

  // setters
  set sourceLocation(LatLng value) {
    _sourceLocation = value;
  }

  set controller(Completer<GoogleMapController> value) {
    _controller = value;
  }

  set destination(LatLng value) {
    _destination = value;
  }

  set destinationLocationList(List<geo.Location> value) {
    _destinationLocationList = value;
  }

  set sourceLocationList(List<geo.Location> value) {
    _sourceLocationList = value;
  }

  set destinationAddress(String value) {
    _destinationAddress = value;
  }

  set startLocationAddress(String value) {
    _startLocationAddress = value;
  }

  set currentLocationIcon(BitmapDescriptor value) {
    _currentLocationIcon = value;
  }

  set destinationIcon(BitmapDescriptor value) {
    _destinationIcon = value;
  }

  set sourceIcon(BitmapDescriptor value) {
    _sourceIcon = value;
  }

  set tripId(String value) {
    _tripId = value;
  }
}
