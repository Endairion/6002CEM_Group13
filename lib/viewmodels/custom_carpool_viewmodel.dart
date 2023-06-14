import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/custom_request_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class CustomCarpoolViewmodel extends BaseViewModel {
  List<CustomRequest> _customRequestList = [];

  List<CustomRequest> get customRequestList => _customRequestList;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
    getCustomCarpoolRequest();
  }

  void onModelDestroy() {
    _customRequestList.clear();
  }

  Future<void> getCustomCarpoolRequest() async {
    _customRequestList = await _firebaseService
        .getCustomCarpoolRequestList(_firebaseService.userId);
    notifyListeners();
  }

  Future<void> acceptCustomRequest(CustomRequest customRequest) async {
    await _firebaseService.updateCustomCarpoolRequestStatus(customRequest.id);
    await _sendNotificationToRequester(customRequest);
  }

  Future<void> _sendNotificationToRequester(CustomRequest customRequest) async {
    String userId =
        customRequest.userId; // Replace with your actual user ID from Firestore
    String title = "Custom Request Accepted";
    String body = "You can go and pickup your passenger now";

    sendNotification(userId, title, body);
  }

  Future<void> sendNotification(
      String userId, String title, String body) async {
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserId = status?.userId;

    var request = OSCreateNotification(
      content: body,
      heading: title,
      playerIds: [osUserId!],
    );

    var response = await OneSignal.shared.postNotification(request);
    print('Notification sent with response: ${response}');
  }
}
