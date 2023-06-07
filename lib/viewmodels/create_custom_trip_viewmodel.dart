import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/custom_request_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CreateCustomTripViewmodel extends BaseViewModel {
  late final TextEditingController _startLocationController;
  late final TextEditingController _destinationController;
  late final TextEditingController _remarksController;
  var uuid = new Uuid();
  String _sessionToken = "";
  List<dynamic> _placeList = [];
  List<dynamic> _placeList2 = [];
  String _errorMessage = "";
  bool notComplete = false;

  final FirebaseService _firebaseService = locator<FirebaseService>();

  TextEditingController get startLocationController => _startLocationController;

  TextEditingController get destinationController => _destinationController;

  TextEditingController get remarksController => _remarksController;

  List<dynamic> get placeList => _placeList;

  List<dynamic> get placeList2 => _placeList2;

  set destinationController(TextEditingController value) {
    _destinationController = value;
  }

  set startLocationController(TextEditingController value) {
    _startLocationController = value;
  }

  set remarksController(TextEditingController value) {
    _remarksController = value;
  }

  void onModelReady() {
    _startLocationController = TextEditingController();
    _destinationController = TextEditingController();
    _remarksController = TextEditingController();
    startLocationController.addListener(() {
      _onChanged();
    });
    destinationController.addListener(() {
      _onChanged2();
    });
  }

  void onModelDestroy() {
    _startLocationController.dispose();
    _destinationController.dispose();
    _remarksController.dispose();
  }

  _onChanged() {
    if (_sessionToken == null) {
      _sessionToken = uuid.v4();
    }
    getSuggestion(startLocationController.text);
    notifyListeners();
  }

  _onChanged2() {
    if (_sessionToken == null) {
      _sessionToken = uuid.v4();
    }
    getSuggestion2(destinationController.text);
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

  void getSuggestion2(String input) async {
    String request = getApiRequestUrl(input);
    http.Response response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      _placeList2 = json.decode(response.body)['predictions'];
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  String getApiRequestUrl(String input) {
    String kPLACES_API_KEY = "AIzaSyA36o5GXvW4Kauogfmfgqnas7oBMzUqmkU";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&region=my&sessiontoken=$_sessionToken';
    return request;
  }

  Future<void> planTrip(BuildContext context) async {
    _errorMessage = "";
    String date = "", time = "";
    bool notComplete = false;

    if (_startLocationController.text.isEmpty ||
        _destinationController.text.isEmpty) {
      if (_startLocationController.text.isEmpty) {
        _errorMessage = "Please fill in your starting location\n";
      }
      if (_destinationController.text.isEmpty) {
        _errorMessage =
            _errorMessage + "Please fill in your destination location\n";
      }
      notComplete = true;
    }

    //value 2 for future
    // if (_departureValue == 2) {
    //   if (_selectedDateText == 'Set future date') {
    //     _errorMessage = _errorMessage + "Please set future date\n";
    //     notComplete = true;
    //   }
    //   if (_timeDropDownValue == 'Select future time') {
    //     _errorMessage = _errorMessage + "Please set future time\n";
    //     notComplete = true;
    //   }
    // }

    if (notComplete == true) {
      showErrorDialog(context);
    } else {
      date = DateFormat("dd-MM-yyyy").format(DateTime.now());
      time = DateFormat.jm().format(DateTime.now());
      // if (_departureValue == 1) {
      //
      // } else if (_departureValue == 2) {
      //   date = _selectedDateText;
      //   time = _timeDropDownValue;
      // }

      // Trip trip = Trip(
      //     id: uuid.v4().toString(),
      //     userId: _firebaseService.userId,
      //     startLocation: _startLocationController.text,
      //     destination: _destinationController.text,
      //     date: date,
      //     time: time,
      //     stops: "",
      //     status: "Ongoing",
      //     seats: int.parse(_dropDownValue),
      //     enablePickupNotification: _pickupNotificationIsChecked);

      // await _firebaseService.createTrip(trip);
      print("Date: " + date);
      print("Time: " + time);
      print("Remarks: " + _remarksController.text);

      CustomRequest customRequest = CustomRequest(
          id: uuid.v4().toString(),
          userId: _firebaseService.userId,
          startLocation: _startLocationController.text,
          destination: _destinationController.text,
          date: date,
          time: time,
          status: "Pending",
          remarks: _remarksController.text
      );

      await _firebaseService.createCustomRequest(customRequest);

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
