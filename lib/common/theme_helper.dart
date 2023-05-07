import 'package:flutter/material.dart';

class ThemeHelper{
  InputDecoration textInputDecoration([String labelText="",String hintText=""]){
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 12.0),
      fillColor: Colors.white,
      labelStyle: TextStyle(color: Colors.grey,fontSize: 12),
      floatingLabelStyle: TextStyle(color: Colors.black),
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.grey)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.grey)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Colors.grey)),
    );
  }
}