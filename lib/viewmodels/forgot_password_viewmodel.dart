import 'package:dart_mailgun/client.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  late final TextEditingController _emailController;

  final FirebaseService _firebaseService = locator<FirebaseService>();

  TextEditingController get emailController => _emailController;

  String? Function(String? email) get emailValidator => Validators.emailValidator;

  void onModelReady(){
    _emailController = TextEditingController(text: "");
  }


  Future<String> sendResetCodeEmail() async {
    var email = _emailController.text.trim();
    try {
      await _firebaseService.sendResetEmail(email);

      return 'Reset link email sent to $email';


    } catch (e) {
      String errorMessage = e.toString();
      return errorMessage;
    }
  }


}