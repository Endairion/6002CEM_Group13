import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class OngoingTripDetailsViewModel extends BaseViewModel {
  String _startLocation = "";
  String _destination = "";
  String _departureTime = "";
  String _arrivalTime = "";
  String _distance = "";
  String _duration = "";
  int _durationValue = 0;
  int _seats = 0;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String tripId) {
    getTrip(tripId);
  }

  void onModelDestroy() {}

  Future<void> getTrip(String tripId) async {
    Trip trip = await _firebaseService.getTrip(tripId);
    _startLocation = trip.startLocation;
    _destination = trip.destination;
    _seats = trip.seats;

    await getDistanceMatrix();
    calculateArrivalTime();
    notifyListeners();
  }

  Future<void> getDistanceMatrix() async {
    String API_KEY = "AIzaSyA36o5GXvW4Kauogfmfgqnas7oBMzUqmkU";
    try {
      var response = await Dio().get(
          'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$_destination&origins=$_startLocation&mode=driving&key=$API_KEY');
      if (response.statusCode == 200) {
        print(response);

        // Extract the duration from the response
        _distance = response.data['rows'][0]['elements'][0]['distance']['text'];
        _duration = response.data['rows'][0]['elements'][0]['duration']['text'];
        _durationValue = response.data['rows'][0]['elements'][0]['duration']['value'];

        notifyListeners();
      } else {
        print('Failed to retrieve distance matrix');
      }
    } catch (e) {
      print(e);
    }
  }

  void calculateArrivalTime() async {
    // Calculate arrival time based on departure time and duration
    DateTime departureDateTime = DateTime.now();
    _departureTime = DateFormat.jm().format(departureDateTime);

    Duration duration = Duration(minutes: _durationValue);
    DateTime arrivalDateTime = departureDateTime.add(duration);
    _arrivalTime = DateFormat.jm().format(arrivalDateTime);

    notifyListeners();
  }

  // Getters
  String get startLocation => _startLocation;
  String get destination => _destination;
  String get arrivalTime => _arrivalTime;
  String get departureTime => _departureTime;
  String get duration => _duration;
  String get distance => _distance;

  // Setters
  set destination(String value) {
    _destination = value;
  }

  set startLocation(String value) {
    _startLocation = value;
  }

  set arrivalTime(String value) {
    _arrivalTime = value;
  }

  set departureTime(String value) {
    _departureTime = value;
  }

  set duration(String value) {
    _duration = value;
  }

  set distance(String value) {
    _distance = value;
  }

  int get seats => _seats;

  set seats(int value) {
    _seats = value;
  }

  int get durationValue => _durationValue;

  set durationValue(int value) {
    _durationValue = value;
  }
}
