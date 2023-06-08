import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/trip_passenger_request_card.dart';

class TripPassengerRequestViewModel extends BaseViewModel {

  String _requestId = "";

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String requestId) {
    _requestId = requestId;
  }

  void onModelDestroy() {
  }

  Future<void> acceptRequest() async {
    await _firebaseService.acceptCarpoolRequest(_requestId);
    notifyListeners();
  }

  Future<void> rejectRequest() async {
    await _firebaseService.rejectCarpoolRequest(_requestId);
    notifyListeners();
  }

}
