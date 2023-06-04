import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class MapNavigationViewModel extends BaseViewModel {
  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
  }

  void onModelDestroy() {}
}
