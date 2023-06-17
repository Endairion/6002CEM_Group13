import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/locator.dart';

class EditProfileViewModel extends BaseViewModel{
  final FirebaseService _service = locator<FirebaseService>();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _dobController = TextEditingController();
  late TextEditingController _icNoController = TextEditingController();
  late TextEditingController _contactController= TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get dobController => _dobController;
  TextEditingController get icNoController => _icNoController;
  TextEditingController get contactController => _contactController;

  String? Function(String? name) get nameValidator => Validators.nameValidator;
  String? Function(String? email) get emailValidator => Validators.emailValidator;
  String? Function(String? dob) get dobValidator => Validators.dobValidator;
  String? Function(String? icNo) get icNoValidator => Validators.icNoValidator;
  String? Function(String? contact) get contactValidator => Validators.contactValidator;


  void onModelReady(){
    fetchUserProfile();
    notifyListeners();
  }

  void fetchUserProfile() async {
    try {
      var userProfile = await _service.fetchUserProfile();
      _nameController = TextEditingController(text: userProfile['name'] as String);
      _emailController = TextEditingController(text: userProfile['email'] as String);
      _dobController = TextEditingController(text: userProfile['dob'] as String);
      _icNoController = TextEditingController(text: userProfile['ic_no'] as String);
      _contactController = TextEditingController(text: userProfile['contact'] as String);
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
      throw 'Error updating user profile: $e';
    }
  }

}