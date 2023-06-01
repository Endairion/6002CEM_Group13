import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class TripDetailsViewModel extends BaseViewModel {

  late String _tripId = "";

  String get tripId => _tripId;

  set tripId(String value) {
    _tripId = value;
  }

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
  }

  void onModelDestroy() {
  }

  Future<void> getTrip() async {
    //List<Trip> trip = await _firebaseService.getTrip(tripId);
    _firebaseService.getTrip(tripId);
    notifyListeners();
    // print(trip);
  }
}
