import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/locator.dart';

class ProfileViewModel extends BaseViewModel {
  final FirebaseService _service = locator<FirebaseService>();
  late String name = ''; // Add the 'name' property
  late String url = '';
  late File _profileImage;
  late String profileImageUrl= '';
  final ImagePicker picker = ImagePicker();

  File get profileImage => _profileImage;

  set profileImage(File image){
    _profileImage = image;
  }

  void onModelReady() {
    fetchUserProfile();
    notifyListeners();
    // Call the method to fetch the user profile
  }

  Future<void> fetchUserProfile() async {
    try {
      var userProfile = await _service.fetchUserProfile();
      name = userProfile['name'] as String;
      url = userProfile['url'] as String;
      notifyListeners();
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }


  void onModelDestroy() {}

  Future<void> signOut() async{
    await _service.signOut();
  }

  Future<String?> uploadImage(File file) async{
    try{
      if (url.isNotEmpty) {
        // Delete the existing profile image if the 'url' has a value
        await _service.deleteImageFromFirebaseStorage(url);
      }

      return await _service.uploadImageToFirebaseStorage(file, "Users");
    } catch (e){
      debugPrint('Error handling license plate image upload: $e');
    }
    return null;
  }

  Future<String> handleImageUpload() async{
    await pickUploadImage(ImageSource.gallery);
    profileImageUrl = await uploadImage(_profileImage) ?? '';
    try{
      await _service.updateProfileImageUrl(profileImageUrl);
    } catch (e){
      return e.toString();
    }
    return 'Profile picture successfully uploaded';
  }

  Future<void> pickUploadImage(ImageSource media) async{
    final image = await picker.pickImage(source: media);

    _profileImage = File(image!.path);
  }
}