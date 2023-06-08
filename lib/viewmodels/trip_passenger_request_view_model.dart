import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/trip_details_view.dart';
import 'package:mobile_app_development_cw2/views/trip_passenger_request_card.dart';

class TripPassengerRequestViewModel extends BaseViewModel {

  String _requestId = "";
  String _tripId = "";

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String requestId, String tripId) {
    _requestId = requestId;
    _tripId = tripId;
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

  Future<void> acceptRequestClicked(BuildContext context) async {
    showAcceptConfirmationDialog(context);
    notifyListeners();
  }

  Future<void> rejectRequestClicked(BuildContext context) async {
    showDeclineConfirmationDialog(context);
    notifyListeners();
  }

  Future<bool> showAcceptConfirmationDialog(BuildContext context) async {
    // Show the error message dialog
    bool? showConfirm = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (context) => AlertDialog(
        title: Text("Accept Passenger Carpool Request"),
        content: Text("Are you sure you want to accept the request?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel confirmation
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              acceptRequest();
              Navigator.of(context).pop(true); // Confirm accept request
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => TripDetails(tripId: _tripId)));
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return showConfirm ?? false; // Return false if the dialog is dismissed
  }

  Future<bool> showDeclineConfirmationDialog(BuildContext context) async {
    // Show the error message dialog
    bool? showConfirm = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (context) => AlertDialog(
        title: Text("Decline Passenger Carpool Request"),
        content: Text("Are you sure you want to decline the request?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Cancel confirmation
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              rejectRequest();
              Navigator.of(context).pop(true); // Confirm decline request
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => TripDetails(tripId: _tripId)));
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return showConfirm ?? false; // Return false if the dialog is dismissed
  }
}
