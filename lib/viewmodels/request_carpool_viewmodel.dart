import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:uuid/uuid.dart';

import '../locator.dart';
import '../models/trip_model.dart';
import '../services/firebase_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class RequestCarpoolViewmodel extends BaseViewModel {
  String _tripId = "";
  String _startLocation = "";
  String _destination = "";
  String _driver = "";
  String _date = "";
  String _time = "";
  int _seats = 0;
  var uuid = new Uuid();
  String _sessionToken = "";
  List<dynamic> _placeList = [];
  late final TextEditingController _pickUpLocationController;
  late final TextEditingController _remarksController;
  String _errorMessage = "";

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  TextEditingController get pickUpLocationController =>
      _pickUpLocationController;

  TextEditingController get remarksController => _remarksController;

  List<dynamic> get placeList => _placeList;

  set pickUpLocationController(TextEditingController value) {
    _pickUpLocationController = value;
  }

  set remarksController(TextEditingController value) {
    _remarksController = value;
  }

  set placeList(List<dynamic> value) {
    _placeList = value;
  }

  void onModelReady(String tripId) {
    getTrip(tripId);
    _pickUpLocationController = TextEditingController();
    _remarksController = TextEditingController();
    _pickUpLocationController.addListener(() {
      _onChanged();
    });
  }

  void onModelDestroy() {
    _pickUpLocationController.dispose();
    _remarksController.dispose();
  }

  _onChanged() {
    if (_sessionToken == null) {
      _sessionToken = uuid.v4();
    }
    getSuggestion(pickUpLocationController.text);
    notifyListeners();
  }

  void getSuggestion(String input) async {
    String request = getApiRequestUrl(input);
    http.Response response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      _placeList = json.decode(response.body)['predictions'];
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  String getApiRequestUrl(input) {
    String kPLACES_API_KEY = "AIzaSyA36o5GXvW4Kauogfmfgqnas7oBMzUqmkU";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&region=my&sessiontoken=$_sessionToken';
    return request;
  }

  Future<void> getTrip(String tripId) async {
    Trip trip = await _firebaseService.getTrip(tripId);
    Users user = await _firebaseService.getUserData(trip.userId);
    _startLocation = trip.startLocation;
    _destination = trip.destination;
    _date = trip.date;
    _time = trip.time;
    _seats = trip.seats;
    _driver = user.name;
    _tripId = tripId;

    notifyListeners();
  }

  // Getters
  int get seats => _seats;

  String get time => _time;

  String get date => _date;

  String get driver => _driver;

  String get destination => _destination;

  String get startLocation => _startLocation;

  String get tripId => _tripId;

  // Setters
  set seats(int value) {
    _seats = value;
  }

  set time(String value) {
    _time = value;
  }

  set date(String value) {
    _date = value;
  }

  set driver(String value) {
    _driver = value;
  }

  set destination(String value) {
    _destination = value;
  }

  set startLocation(String value) {
    _startLocation = value;
  }

  set tripId(String value) {
    _tripId = value;
  }

  Future<void> createCarpoolRequest(BuildContext context) async {
    _errorMessage = "";
    bool notComplete = false;
    Trip trip = await _firebaseService.getTrip(tripId);

    if (_pickUpLocationController.text.isEmpty) {
      _errorMessage = "Please fill in your starting location\n";
      notComplete = true;
    }

    if (notComplete == true) {
      showErrorDialog(context);
    } else {
      CarpoolRequest carpoolRequest = CarpoolRequest(
          id: uuid.v4().toString(),
          requesterId: _firebaseService.userId,
          tripId: trip.id,
          driverId: trip.userId,
          pickupLocation: pickUpLocationController.text,
          remarks: remarksController.text,
          status: "Pending");

      print('TripId: ' + tripId);

      await _firebaseService.createCarpoolRequest(carpoolRequest);

      showSuccessDialog(context);
    }
  }

  Future<bool> showErrorDialog(BuildContext context) async {
    // Show the error message dialog
    bool? showError = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error Message'),
        content: Text(_errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cancel logout
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
    return showError ?? false; // Return false if the dialog is dismissed
  }

  Future<bool> showSuccessDialog(BuildContext context) async {
    Navigator.of(context).pop();

    // Show the error message dialog
    bool? showSuccess = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Succesfully Created Request'),
        content: Text("Check it out in Activity tab"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cancel logout
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
    return showSuccess ?? false; // Return false if the dialog is dismissed
  }
}
