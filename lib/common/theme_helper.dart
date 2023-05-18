import 'package:flutter/material.dart';

class ThemeHelper{
  InputDecoration textInputDecoration([String labelText="",String hintText=""]){
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 12.0),
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.grey,fontSize: 12),
      floatingLabelStyle: const TextStyle(color: Colors.black),
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Colors.grey)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Colors.grey)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: const BorderSide(color: Colors.grey)),
    );
  }

  InputDecoration editProfileInput() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
        gapPadding: 0.0,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none,
      ),
    );
  }
}