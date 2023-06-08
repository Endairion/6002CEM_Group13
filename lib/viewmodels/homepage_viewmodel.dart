import 'package:cloud_firestore/cloud_firestore.dart';
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
    getUser();
  }

  void onModelDestroy() {
  }

  Future<void> getUser() async {
    Users user = await _firebaseService.getUserData(_firebaseService.userId);
    _name = user.name;
    _points = int.parse(user.points);
    notifyListeners();
  }

  int get points => _points;

  set points(int value) {
    _points = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}