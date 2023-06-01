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

class ActivityPageViewModel extends BaseViewModel {

  double _singleListViewHeight = 150;
  double _listViewHeight = 400;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
    // _startLocationController = TextEditingController();
    // _destinationController = TextEditingController();
    //
    // startLocationController.addListener(() {
    //   _onChanged();
    // });
    // destinationController.addListener(() {
    //   _onChanged2();
    // });
  }

  void onModelDestroy() {
    // _startLocationController.dispose();
    // _destinationController.dispose();
  }
}
