import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/pickup_address_card_view.dart';
import 'package:mobile_app_development_cw2/views/trip_passenger_request_card.dart';

class CarpoolDetailsViewModel extends BaseViewModel {

  String _date = "";
  String _time = "";
  String _startLocation = "";
  String _destination = "";
  String _pickupLocation = "";
  String _remarks = "";
  String _driverName = "";

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String requestId) {
    getCarpoolRequest(requestId);

  }

  void onModelDestroy() {
  }

  Future<void> getCarpoolRequest(String requestId) async {
    CarpoolRequest request = await _firebaseService.getCarpoolRequest(requestId);
    _pickupLocation = request.pickupLocation;
    _remarks = request.remarks;

    Trip trip = await _firebaseService.getTrip(request.tripId);
    _date = trip.date;
    _time = trip.time;
    _startLocation = trip.startLocation;
    _destination = trip.destination;

    Users user = await _firebaseService.getUserData(request.driverId);
    _driverName = user.name;
    notifyListeners();
  }

  String get destination => _destination;

  set destination(String value) {
    _destination = value;
  }

  String get startLocation => _startLocation;

  set startLocation(String value) {
    _startLocation = value;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get pickupLocation => _pickupLocation;

  set pickupLocation(String value) {
    _pickupLocation = value;
  }

  String get remarks => _remarks;

  set remarks(String value) {
    _remarks = value;
  }

  String get driverName => _driverName;

  set driverName(String value) {
    _driverName = value;
  }
}
