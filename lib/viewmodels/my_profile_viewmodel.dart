import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/locator.dart';

class MyProfileViewModel extends BaseViewModel {
  final FirebaseService _service = locator<FirebaseService>();
  late String name = '';
  late String email = '';
  late String dob = '';
  late String icNo = '';
  late String contact = '';

  void onModelReady() {
    fetchUserProfile(); // Call the method to fetch the user profile
  }

  void fetchUserProfile() async {
    try {
      var userProfile = await _service.fetchUserProfile();
      name = userProfile['name'] as String;
      email = userProfile['email'] as String;
      dob = userProfile['dob'] as String;
      icNo = userProfile['ic_no'] as String;
      contact = userProfile['contact'] as String;
      notifyListeners();
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  void onModelDestroy() {}
}