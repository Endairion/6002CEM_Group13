import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class CodeVerificationViewModel extends BaseViewModel{
  late final TextEditingController _codeController;

  final FirebaseService _firebaseService = locator<FirebaseService>();

  TextEditingController get codeController => _codeController;

  String? Function(String? code) get codeValidator => Validators.codeValidator;

  void onModelReady() {
    _codeController = TextEditingController(text: "");
  }

  Future<String> verifyCode(String email) async {
    return await _firebaseService.verifyCode(codeController.text.trim(), email);
  }
}