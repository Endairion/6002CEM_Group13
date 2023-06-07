import 'package:mobile_app_development_cw2/PointsEarn.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/earn_point_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:geocoding/geocoding.dart' as geo;
import 'package:mobile_app_development_cw2/viewmodels/map_navigation_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

class MapNavigationViewModel extends BaseViewModel {
  String _tripId = "";
  String _startLocationAddress="";
  String _destinationAddress="";

  List<geo.Location> _sourceLocationList = [];
  List<geo.Location> _destinationLocationList = [];

  Completer<GoogleMapController> _controller = Completer();

  LatLng _sourceLocation = LatLng(0,0);
  LatLng _destination = LatLng(0,0);

  LocationData? currentLocation;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String tripId) {
    _tripId = tripId;
    setupMap(tripId);
  }

  void onModelDestroy() {}

  Future<void> setupMap(String tripId) async {
    await setCustomMarkerIcon();
    await getTrip(tripId);
    await getAddressLatLng();
    await getPolyPoints();
    await getCurrentLocation();
    notifyListeners();
  }

  Future<void> getTrip(String tripId) async {
    Trip trip = await _firebaseService.getTrip(tripId);
    _startLocationAddress = trip.startLocation;
    _destinationAddress = trip.destination;
    notifyListeners();
  }

  Future<void> getAddressLatLng() async {
    _sourceLocationList = await geo.locationFromAddress(_startLocationAddress);
    _destinationLocationList = await geo.locationFromAddress(_destinationAddress);
    print(_sourceLocationList[0].toString());
    print(_destinationLocationList[0].toString());

    _sourceLocation = LatLng(_sourceLocationList[0].latitude, _sourceLocationList[0].longitude);
    _destination = LatLng(_destinationLocationList[0].latitude, _destinationLocationList[0].longitude);
    notifyListeners();
  }

  List<LatLng> polylineCoordinates = [];

  Future<void> getPolyPoints() async {
    String API_KEY = "AIzaSyA36o5GXvW4Kauogfmfgqnas7oBMzUqmkU";
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      API_KEY, // Your Google Map Key
      PointLatLng(_sourceLocation.latitude, _sourceLocation.longitude),
      PointLatLng(_destination.latitude, _destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      notifyListeners();
    }
  }

  BitmapDescriptor _sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor _currentLocationIcon = BitmapDescriptor.defaultMarker;

  Future<void> setCustomMarkerIcon() async {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, 'assets/source_pin.png')
        .then(
      (icon) {
        _sourceIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/destination_pin.png")
        .then(
      (icon) {
        _destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/avatar_pin.png")
        .then(
      (icon) {
        _currentLocationIcon = icon;
      },
    );
    notifyListeners();
  }

  Future <void> getCurrentLocation() async {
    Location location = Location();
    currentLocation = await location.getLocation();
    notifyListeners();

    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
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
        print("5");
        print(currentLocation.toString());
        notifyListeners();
      },
    );
  }

  Future<void> completeTrip() async {
    await _firebaseService.completeTrip(_tripId);
    EarnPoint ep = EarnPoint(tripId: _tripId, userId: "", points: 150, role: "Driver");
    await _firebaseService.createPointsEarn(ep);
    notifyListeners();
  }

  Future<bool> showConfirmationDialog(BuildContext context) async {
    // Show the error message dialog
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
              completeTrip();
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return showConfirm ?? false; // Return false if the dialog is dismissed
  }

  LatLng get sourceLocation => _sourceLocation;

  set sourceLocation(LatLng value) {
    _sourceLocation = value;
  }

  Completer<GoogleMapController> get controller => _controller;

  set controller(Completer<GoogleMapController> value) {
    _controller = value;
  }

  LatLng get destination => _destination;

  set destination(LatLng value) {
    _destination = value;
  }

  List<geo.Location> get destinationLocationList => _destinationLocationList;

  set destinationLocationList(List<geo.Location> value) {
    _destinationLocationList = value;
  }

  List<geo.Location> get sourceLocationList => _sourceLocationList;

  set sourceLocationList(List<geo.Location> value) {
    _sourceLocationList = value;
  }

  String get destinationAddress => _destinationAddress;

  set destinationAddress(String value) {
    _destinationAddress = value;
  }

  String get startLocationAddress => _startLocationAddress;

  set startLocationAddress(String value) {
    _startLocationAddress = value;
  }

  BitmapDescriptor get currentLocationIcon => _currentLocationIcon;

  set currentLocationIcon(BitmapDescriptor value) {
    _currentLocationIcon = value;
  }

  BitmapDescriptor get destinationIcon => _destinationIcon;

  set destinationIcon(BitmapDescriptor value) {
    _destinationIcon = value;
  }

  BitmapDescriptor get sourceIcon => _sourceIcon;

  set sourceIcon(BitmapDescriptor value) {
    _sourceIcon = value;
  }

  String get tripId => _tripId;

  set tripId(String value) {
    _tripId = value;
  }
}
