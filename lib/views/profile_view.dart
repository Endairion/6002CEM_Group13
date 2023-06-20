import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app_development_cw2/views/settings_view.dart';
import 'package:mobile_app_development_cw2/views/login_view.dart';

import 'package:mobile_app_development_cw2/views/edit_profile.dart';
import 'package:mobile_app_development_cw2/views/my_profile_view.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

import 'package:mobile_app_development_cw2/viewmodels/profile_viewmodel.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final ProfileViewModel _model;
  final ImagePicker picker = ImagePicker();
  late ImageProvider? profileImage = const AssetImage('assets/logo.png');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;


    return BaseView<ProfileViewModel>(onModelReady: (model) {
      _model = model;
      model.onModelReady();
      _model.fetchUserProfile().then((_) {
        setState(() {
          // Update the image URL in the widget state
          profileImage = _model.url.isNotEmpty
              ? Image.network(_model.url).image
              : const AssetImage('assets/logo.png');
        });
      });
    }, builder: (context, model, child) {
      return Scaffold(
          body: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/vector_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4.0,
                    ),
                  ),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: profileImage,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // Handle edit profile picture action
                            _model.handleImageUpload().then((value) async{
                              await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(value),
                                duration: const Duration(seconds:1),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: value.contains(
                                        'Profile picture successfully uploaded')
                                    ? Colors.green[900]
                                    : Colors.red[900],
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                              ));

                              if(value.contains('Profile picture successfully uploaded')){
                                _model.fetchUserProfile().then((_) {
                                  setState(() {
                                    // Update the image URL in the widget state
                                    profileImage = _model.url.isNotEmpty
                                        ? Image.network(_model.url).image
                                        : const AssetImage('assets/logo.png');
                                  });
                                });
                              }
                            });


                          },
                          child: Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 20.0,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  _model.name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyProfile()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(320, 45), // set minimumSize
                  ),
                  icon: const Icon(Icons.person),
                  label: const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton.icon(
                  onPressed: () async{
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()),
                    );

                    if(result){
                      _model.fetchUserProfile();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(320, 45), // set minimumSize
                  ),
                  icon: const Icon(Icons.edit),
                  label: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Settings()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(320, 45), // set minimumSize
                  ),
                  icon: const Icon(Icons.settings),
                  label: const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton.icon(
                  onPressed: () async {
                    await model.signOut();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.red[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(320, 45), // set minimumSize
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
    });
  }
}
