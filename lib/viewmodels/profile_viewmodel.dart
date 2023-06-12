import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/locator.dart';

class ProfileViewModel extends BaseViewModel {
  final FirebaseService _service = locator<FirebaseService>();
  late String name = ''; // Add the 'name' property

  void onModelReady() {
    fetchUserProfile(); // Call the method to fetch the user profile
  }

  void fetchUserProfile() async {
    try {
      var userProfile = await _service.fetchUserProfile();
      name = userProfile['name'] as String;
      notifyListeners();
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  void onModelDestroy() {}

  Future<void> signOut() async{
    await _service.signOut();
  }
}