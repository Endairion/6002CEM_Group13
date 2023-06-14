import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_development_cw2/models/custom_request_model.dart';
import 'package:mobile_app_development_cw2/models/earn_point_model.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class HomepageViewModel extends BaseViewModel {
  String _name = "";
  int _points = 0;
  List<CustomRequest> _customRequestList = [];

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
    OneSignal.shared.setAppId('a6320cd1-6a71-4fbd-a95b-29002704f34b');
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    getUser();
    getCustomCarpoolRequest();
    print(_customRequestList.toList());
  }

  void onModelDestroy() {}

  Future<void> getUser() async {
    Users user = await _firebaseService.getUserData(_firebaseService.userId);
    _name = user.name;
    _points = user.points;
    notifyListeners();
  }

  Future<void> getCustomCarpoolRequest() async {
    _customRequestList = await _firebaseService
        .getCustomCarpoolRequestList(_firebaseService.userId);
    notifyListeners();
  }

  int get points => _points;

  List<CustomRequest> get customRequestList => _customRequestList;

  set points(int value) {
    _points = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
