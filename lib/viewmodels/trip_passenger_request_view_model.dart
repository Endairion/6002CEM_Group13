import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/trip_details_view.dart';

class TripPassengerRequestViewModel extends BaseViewModel {
  String _requestId = "";
  String _tripId = "";

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String requestId, String tripId) {
    // set request Id and tripId
    _requestId = requestId;
    _tripId = tripId;
  }

  void onModelDestroy() {}

  Future<void> acceptRequest() async {
    // accept passenger carpool request
    await _firebaseService.acceptCarpoolRequest(_requestId);
    // decrement remaining carpool seats
    await decrementCarpoolSeats();
    notifyListeners();
  }

  Future<void> decrementCarpoolSeats() async {
    // decrement remaining carpool seats based on tripId
    await _firebaseService.decrementCarpoolSeats(_tripId);
    notifyListeners();
  }

  Future<void> rejectRequest() async {
    // reject passenger carpool request
    await _firebaseService.rejectCarpoolRequest(_requestId);
    notifyListeners();
  }

  Future<void> acceptRequestClicked(BuildContext context) async {
    // show confirmation dialog when user click on accept request
    showAcceptConfirmationDialog(context);
    notifyListeners();
  }

  Future<void> rejectRequestClicked(BuildContext context) async {
    // show confirmation dialog when user click on decline request
    showDeclineConfirmationDialog(context);
    notifyListeners();
  }

  Future<bool> showAcceptConfirmationDialog(BuildContext context) async {
    // Show the confirmation message dialog
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
              // accept passenger carpool request
              acceptRequest();
              Navigator.of(context).pop(true); // Confirm accept request
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          TripDetails(tripId: _tripId)));
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return showConfirm ?? false; // Return false if the dialog is dismissed
  }

  Future<bool> showDeclineConfirmationDialog(BuildContext context) async {
    // Show the confirmation message dialog
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
              // reject passenger carpool request
              rejectRequest();
              Navigator.of(context).pop(true); // Confirm decline request
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          TripDetails(tripId: _tripId)));
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return showConfirm ?? false; // Return false if the dialog is dismissed
  }
}
