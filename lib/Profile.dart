import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/Settings.dart';
import 'package:mobile_app_development_cw2/views/Login.dart';

import 'EditProfile.dart';
import 'MyProfile.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
              child: const CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'John Doe',
              style: TextStyle(
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
              label: const Text('My Profile',
              style: TextStyle(
                fontSize: 16,
              ),),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfile()),
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
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile',
                style: TextStyle(
                  fontSize: 16,
                ),),
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
              label: const Text('Settings',
                style: TextStyle(
                  fontSize: 16,
                ),),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
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
              label: const Text('Logout',
                style: TextStyle(
                  fontSize: 16,
                ),),
            ),
          ],
        ),
      ),
    );
  }
}