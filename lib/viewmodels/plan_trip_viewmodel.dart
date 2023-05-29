import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

import 'package:flutter/material.dart';

class PlanTripViewModel extends BaseViewModel {
  late final TextEditingController _startLocationController;
  late final TextEditingController _destinationController;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  // Getters
  TextEditingController get startLocationController => _startLocationController;
  TextEditingController get destinationController => _destinationController;

  void onModelReady() {
    _startLocationController = TextEditingController();
    _destinationController = TextEditingController();
  }

  void onModelDestroy() {
    _startLocationController.dispose();
    _destinationController.dispose();
  }
}