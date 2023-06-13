import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class DriverVerificationViewModel extends BaseViewModel {
  late final TextEditingController _licensePlateController;
  late final TextEditingController _carModelController;
  late final TextEditingController _carBrandController;
  late File _licensePlateImage;
  late File _carImage;
  late String licensePlateImageUrl;
  late String carImageUrl;

  final FirebaseService _firebaseService = locator<FirebaseService>();

  TextEditingController get licensePlateController => _licensePlateController;
  TextEditingController get carModelController => _carModelController;
  TextEditingController get carBrandController => _carBrandController;
  File get licensePlateImage => _licensePlateImage;
  File get carImage => _carImage;

  set licensePlateImage(File image) {
    _licensePlateImage = image;
  }

  set carImage(File image) {
    _carImage = image;
  }

  String? Function(String? val) get licensePlateValidator =>
      Validators.validateTextField;
  String? Function(String? val) get carModelValidator =>
      Validators.validateTextField;
  String? Function(String? val) get carBrandValidator =>
      Validators.validateTextField;

  void onModelReady() {
    _licensePlateController = TextEditingController(text: "");
    _carModelController = TextEditingController(text: "");
    _carBrandController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _licensePlateController.dispose();
    _carModelController.dispose();
    _carBrandController.dispose();
    super.dispose();
  }

  Future<String> submitVerification() async {
    carImageUrl = await handleImageUpload(_carImage) ?? '';
    licensePlateImageUrl =
        await handleImageUpload(_licensePlateImage) ?? '';
    try {
      await _firebaseService.submitVerification(
        _carBrandController.text.trim(),
        _carModelController.text.trim(),
        _licensePlateController.text.trim(),
        carImageUrl,
        licensePlateImageUrl,
      );
    } catch (e) {
      return e.toString();
    }
    await _firebaseService.updateDriverStatus();

    return 'Driver verification successfully submitted';
  }

  Future<String?> handleImageUpload(File file) async {
    try {
      return await _firebaseService.uploadImageToFirebaseStorage(
        file,
        'Driver',
      ); // Specify the folder name for Driver images
    } catch (e) {
      debugPrint('Error handling license plate image upload: $e');
    }
    return null;
  }
}
