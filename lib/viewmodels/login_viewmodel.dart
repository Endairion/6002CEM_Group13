import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/main.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isHidden = true;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();


  // Getters
  bool get isHidden => _isHidden;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  String? Function(String? password) get passwordValidator =>
      Validators.passwordValidator;

  String? Function(String? email) get emailValidator =>
      Validators.emailValidator;

  // Setters
  set isHidden(bool val) {
    _isHidden = val;
    notifyListeners();
  }

  void onModelReady() {

    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  void onModelDestroy() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<String> login() async {
    try{
      await _firebaseService.signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );
      return "Login Successfully";
    }catch(e){
      return "Either email or password is wrong";
    }
  }

  Future<bool> checkLoggedIn(BuildContext context) async {
    return await _firebaseService.isLoggedIn();
  }

  Future<bool> showErrorDialog(BuildContext context, String value) async{
    // Show the error message dialog
    bool? showError = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error Message'),
        content: Text(value),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cancel logout
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
    return showError ?? false; // Return false if the dialog is dismissed
  }

}