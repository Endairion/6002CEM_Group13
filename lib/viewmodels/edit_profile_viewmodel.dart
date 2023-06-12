import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/locator.dart';

class EditProfileViewModel extends BaseViewModel{
  final FirebaseService _service = locator<FirebaseService>();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController dobController = TextEditingController();
  late TextEditingController icNoController = TextEditingController();
  late TextEditingController contactController = TextEditingController();


  void onModelReady(){
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      var userProfile = await _service.fetchUserProfile();
      nameController = TextEditingController(text: userProfile['name'] as String);
      emailController = TextEditingController(text: userProfile['email'] as String);
      dobController = TextEditingController(text: userProfile['dob'] as String);
      icNoController = TextEditingController(text: userProfile['ic_no'] as String);
      contactController = TextEditingController(text: userProfile['contact'] as String);
      notifyListeners();
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    icNoController.dispose();
    contactController.dispose();
    super.dispose();
  }

  void updateUserProfile() async {
    try {
      var userProfile = {
        'name': nameController.text,
        'email': emailController.text,
        'dob': dobController.text,
        'ic_no': icNoController.text,
        'contact': contactController.text,
      };
      await _service.updateUserProfile(userProfile);
      // Optionally, you can fetch the updated user profile again if needed
      // fetchUserProfile();
      // notifyListeners(); // Notify listeners if necessary
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

}