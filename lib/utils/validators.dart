import 'dart:core';

class Validators {
  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name field is empty';
    } else {
      return null;
    }
  }

  static String? emailValidator(String? email) {
    final RegExp regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email == null || email.isEmpty) {
      return 'Email field is required';
    } else if (!regExp.hasMatch(email.trim())) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  static String? dobValidator(String? dob){
    final RegExp dobPattern = RegExp(
        r"^(0[1-9]|1\d|2\d|3[01])/(0[1-9]|1[0-2])/\d{4}$");
    if (dob == null || dob.isEmpty){
      return 'Date of Birth field is required';
    }else if (!dobPattern.hasMatch(dob)){
      return 'Enter a valid Date of Birth';
    }else{
      return null;
    }
  }

  static String? icNoValidator(String? icNo) {
    final RegExp icnoPattern = RegExp(r"^\d{12}$");
    if (icNo == null || icNo.isEmpty){
      return 'IC No field is required ';
    }else if (!icnoPattern.hasMatch(icNo)){
      return 'Enter a valid IC No ';
    }else{
      return null;
    }
  }

  static String? contactValidator(String? contactNo){
    final RegExp contactnoPattern = RegExp(r"^01\d{8,9}$");
    if (contactNo == null || contactNo.isEmpty){
      return 'Contact No field is required ';
    }else if (!contactnoPattern.hasMatch(contactNo)){
      return 'Enter a valid contact No ';
    }else {
      return null;
    }
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password field is required';
    } else if (password.length < 6) {
      return "Password can't be lesser than 6 characters";
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(
      String? confirmPassword, String password) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password field is required';
    } else if (confirmPassword != password) {
      return "It doesn't matches with password";
    } else {
      return null;
    }
  }

  static String? validateTextField(String? val) {
    if (val == null || val.isEmpty) {
      return 'Required Field';
    }
    return null;
  }

  static String? codeValidator(String? code) {
    if (code == null || code.isEmpty) {
      return 'Code is required';
    }

    if (code.length != 6) {
      return 'Code must have 6 digits';
    }

    if (!RegExp(r'^\d{6}$').hasMatch(code)) {
      return 'Invalid code format';
    }

    return null;
  }
}