import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_development_cw2/models/earn_point_model.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class HomepageViewModel extends BaseViewModel {
  String _name = "";
  int _points = 0;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
    // get current user
    getUser();
  }

  void onModelDestroy() {}

  Future<void> getUser() async {
    // get current user
    Users user = await _firebaseService.getUserData(_firebaseService.userId);

    // set user details text
    _name = user.name;
    _points = user.points;

    notifyListeners();
  }

  // getters
  int get points => _points;
  String get name => _name;

  // setters
  set points(int value) {
    _points = value;
  }

  set name(String value) {
    _name = value;
  }
}
