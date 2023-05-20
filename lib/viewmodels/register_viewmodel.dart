import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

import 'package:flutter/material.dart';

class RegisterViewModel extends BaseViewModel {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _dobController;
  late final TextEditingController _icNoController;
  late final TextEditingController _contactNoController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  bool _isHidden = true;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();


  // Getters
  bool get isHidden => _isHidden;

  TextEditingController get nameController => _nameController;

  TextEditingController get emailController => _emailController;

  TextEditingController get dobController => _dobController;

  TextEditingController get icNoController => _icNoController;

  TextEditingController get contactNoController => _contactNoController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  String? Function(String? name) get nameValidator => Validators.nameValidator;

  String? Function(String? email) get emailValidator =>
      Validators.emailValidator;

  String? Function(String? dob) get dobValidator => Validators.dobValidator;

  String? Function(String? icNo) get icNoValidator => Validators.icNoValidator;

  String? Function(String? contactNo) get contactValidator => Validators.contactValidator;

  String? Function(String? password) get passwordValidator =>
      Validators.passwordValidator;

  String? Function(String? confirmPassword) get confirmPasswordValidator =>
          (confirmPassword) {
        return Validators.confirmPasswordValidator(
            confirmPassword, passwordController.text.trim());
      };

  // Setters
  set isHidden(bool val) {
    _isHidden = val;
    notifyListeners();
  }

  void onModelReady() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _dobController = TextEditingController();
    _icNoController = TextEditingController();
    _contactNoController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void onModelDestroy() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _icNoController.dispose();
    _contactNoController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future<bool> register() async {
    var res = await _firebaseService.signUp(
      _nameController.text,
      _emailController.text.trim(),
      _dobController.text,
      _icNoController.text,
      _contactNoController.text,
      _passwordController.text,
    );
    return res!= null;
  }
}