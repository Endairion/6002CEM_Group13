import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class DriverVerificationViewModel extends BaseViewModel {
  late final TextEditingController _licensePlateController;
  late final TextEditingController _carModelController;
  late final TextEditingController _carBrandController;
  late File _lPImage;
  late File _carImage;
  String licensePlateImageUrl = '';
  String carImageUrl = '';
  String _uploadedCarImageName = '';
  String _uploadedlPImageName = '';
  bool _showlPButton = true;
  bool _showCarButton = true;
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final ImagePicker _imagePicker = ImagePicker();

  TextEditingController get licensePlateController => _licensePlateController;
  TextEditingController get carModelController => _carModelController;
  TextEditingController get carBrandController => _carBrandController;
  String get uploadedCarImageName => _uploadedCarImageName;
  String get uploadedlPImageName => _uploadedlPImageName;
  bool get showlPButton => _showlPButton;
  bool get showCarButton => _showCarButton;


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
    if (_carBrandController.text.trim().isEmpty ||
        _carModelController.text.trim().isEmpty ||
        _licensePlateController.text.trim().isEmpty) {
      return 'Please fill in all fields before submitting!';
    }
    try{
      licensePlateImageUrl = await handleImageUpload(_lPImage) ?? '';
      carImageUrl = await handleImageUpload(_carImage) ?? '';
    } catch (e){
      return 'Please upload both image before submitting!';
    }

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
      debugPrint('Error handling image upload: $e');
    }
    return null;
  }

  Future<XFile?> getImage(ImageSource media) async {
    final image = await _imagePicker.pickImage(source: media);

    return image;
  }

  void handleCancel(String imgType) {
    switch (imgType) {
      case 'License Plate':
        _uploadedlPImageName = "";
        _showlPButton = true;
        break;
      case 'Car':
        _uploadedCarImageName = "";
        _showCarButton = true;
        break;
    }
    notifyListeners();
  }

  void uploadMenu(BuildContext context, String imgType) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text('Please choose media to select'),
          content: Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    var image = await getImage(ImageSource.camera);
                    switch (imgType) {
                      case 'License Plate':
                        _lPImage = File(image!.path);
                        _uploadedlPImageName = image.name;
                        _showlPButton = false;
                        notifyListeners();
                        break;
                      case 'Car':
                        _carImage = File(image!.path);
                        _uploadedCarImageName = image.name;
                        _showCarButton = false;
                        notifyListeners();
                        break;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(200, 40),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      Text('From Camera'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



}
