import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class NewPasswordViewModel extends BaseViewModel{
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;


  final FirebaseService _firebaseService = locator<FirebaseService>();

  TextEditingController get currentPasswordController => _currentPasswordController;
  TextEditingController get newPasswordController => _newPasswordController;


  String? Function(String? password) get currentPasswordValidator => Validators.passwordValidator;
  String? Function(String? password) get newPasswordValidator => Validators.passwordValidator;


  void onModelReady(){
    _currentPasswordController = TextEditingController(text: "");
    _newPasswordController = TextEditingController(text: "");
  }

  Future<bool> updatePassword() async{
    try {
      await _firebaseService.updatePassword(_currentPasswordController.text, _newPasswordController.text);
      return true;
    } catch (e){
      return false;
    }
  }
}