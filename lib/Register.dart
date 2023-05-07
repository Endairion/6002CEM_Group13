import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/common/theme_helper.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
            margin: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('Back to Login'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    alignment: Alignment.topLeft,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Register a new account",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Fill in your personal details",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: ThemeHelper().textInputDecoration("Email","Email"),
                  cursorColor: Colors.lightGreen,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: ThemeHelper().textInputDecoration("Full Name", "Full Name"),
                  cursorColor: Colors.lightGreen,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: ThemeHelper().textInputDecoration("Date of Birth", "Date of Birth (DD/MM/YYYY"),
                  cursorColor: Colors.lightGreen,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: ThemeHelper().textInputDecoration("IC No", "IC Number (No space or dash)"),
                  cursorColor: Colors.lightGreen,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: ThemeHelper().textInputDecoration("Contact No", "IC Number (No space or dash)"),
                  cursorColor: Colors.lightGreen,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: ThemeHelper().textInputDecoration("Password", "Password"),
                  cursorColor: Colors.lightGreen,
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: ThemeHelper().textInputDecoration("Confirm Password", "Confirm Password"),
                  cursorColor: Colors.lightGreen,
                  obscureText: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
