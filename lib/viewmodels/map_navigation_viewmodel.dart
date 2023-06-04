import 'package:mobile_app_development_cw2/locator.dart';
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
    setupMap(tripId);
  }

  void onModelDestroy() {}

  Future<void> setupMap(String tripId) async {
    await getTrip(tripId);
    await getAddressLatLng();
    await getPolyPoints();
    await getCurrentLocation();
    // setCustomMarkerIcon();
    notifyListeners();
  }

  Future<void> getTrip(String tripId) async {
    Trip trip = await _firebaseService.getTrip(tripId);
    _startLocationAddress = trip.startLocation;
    _destinationAddress = trip.destination;
    print("1");
    notifyListeners();
  }

  Future<void> getAddressLatLng() async {
    _sourceLocationList = await geo.locationFromAddress(_startLocationAddress);
    _destinationLocationList = await geo.locationFromAddress(_destinationAddress);
    print(_sourceLocationList[0].toString());
    print(_destinationLocationList[0].toString());

    _sourceLocation = LatLng(_sourceLocationList[0].latitude, _sourceLocationList[0].longitude);
    _destination = LatLng(_destinationLocationList[0].latitude, _destinationLocationList[0].longitude);
    print("2");
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
      print("3");
      notifyListeners();
    }
  }

  // BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  // void setCustomMarkerIcon() {
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration.empty, "assets/app_logo.png")
  //       .then(
  //     (icon) {
  //       sourceIcon = icon;
  //     },
  //   );
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration.empty, "assets/app_logo.png")
  //       .then(
  //     (icon) {
  //       destinationIcon = icon;
  //     },
  //   );
  //   BitmapDescriptor.fromAssetImage(
  //           ImageConfiguration.empty, "assets/app_logo.png")
  //       .then(
  //     (icon) {
  //       currentLocationIcon = icon;
  //     },
  //   );
  // }

  Future <void> getCurrentLocation() async {
    print("4");
    Location location = Location();
    currentLocation = await location.getLocation();
    notifyListeners();

    GoogleMapController googleMapController = await _controller.future;
    print("4b");
    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
        print("4c");
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
}
