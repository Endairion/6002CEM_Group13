import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class PlanTripViewModel extends BaseViewModel {
  late final TextEditingController _startLocationController;
  late final TextEditingController _destinationController;
  var uuid = new Uuid();
  String _sessionToken = "";
  List<dynamic> _placeList = [];
  List<dynamic> _placeList2 = [];
  DateTime _selectedDate = DateTime.now();
  String _selectedDateText = 'Set future date';


  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  // Getters
  TextEditingController get startLocationController => _startLocationController;
  TextEditingController get destinationController => _destinationController;
  String get sessionToken => _sessionToken;
  List<dynamic> get placeList => _placeList;
  List<dynamic> get placeList2 => _placeList2;
  DateTime get selectedDate => _selectedDate;
  String get selectedDateText => _selectedDateText;

  void onModelReady() {
    _startLocationController = TextEditingController();
    _destinationController = TextEditingController();

    startLocationController.addListener(() {
      _onChanged();
    });
    destinationController.addListener(() {
      _onChanged2();
    });

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

  String getApiRequestUrl(String input) {
    String kPLACES_API_KEY = "AIzaSyA36o5GXvW4Kauogfmfgqnas7oBMzUqmkU";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&region=my&sessiontoken=$_sessionToken';
    return request;
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

  void onModelDestroy() {
    _startLocationController.dispose();
    _destinationController.dispose();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      _selectedDate = picked;
      _selectedDateText = DateFormat("dd-MM-yyyy").format(selectedDate);
    }
    notifyListeners();
  }


}