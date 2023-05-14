import 'package:flutter/material.dart';
import 'ForgotPassword.dart';
import 'Profile.dart';
import 'common/theme_helper.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _showOldPassword = true;
  bool _oldPasswordEntered = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              width: 390,
              height: 290,
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
                    offset: const Offset(0,3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Profile()),
                      );
                    },
                    icon: const Icon(Icons.chevron_left),
                    label: const Text('Back to Login'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      foregroundColor: Colors.black,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: _showOldPassword,
                    child: const Text(
                      "Enter your old password to change to a new password ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _oldPasswordEntered,
                    child: const Text(
                      "Enter your new password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: _showOldPassword,
                    child: TextField(
                      decoration: ThemeHelper().textInputDecoration("Old Password", "Old Password"),
                      cursorColor: Colors.lightGreen,
                      obscureText: true,
                    ),
                  ),
                  Visibility(
                      visible: _oldPasswordEntered,
                      child: TextField(
                        decoration: ThemeHelper().textInputDecoration("New Password", "New Password"),
                        cursorColor: Colors.lightGreen,
                        obscureText: true,
                      ),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: _oldPasswordEntered,
                    child: TextField(
                      decoration: ThemeHelper().textInputDecoration("Confirm Password", "Confirm Password"),
                      cursorColor: Colors.lightGreen,
                      obscureText: true,
                    ),
                  ),
                  Visibility(
                    visible: _showOldPassword,
                    child: Container(
                        alignment: Alignment.centerRight,
                        child:
                        TextButton(
                            onPressed:(){
                              setState(() {

                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ForgotPassword()),
                              );
                            },
                            child:Text(
                                'Forgot Password?',
                                style: TextStyle(fontSize: 12, color: Colors.green[900]),
                                textAlign: TextAlign.right)
                        )
                    ),
                  ),
                  const SizedBox(height: 6),
                  Visibility(
                    visible: _showOldPassword,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[900],
                          minimumSize: const Size(320, 40)
                      ),
                      onPressed: (){
                        setState(() {
                          _showOldPassword = false;
                          _oldPasswordEntered = true;
                        });
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                  Visibility(
                    visible: _oldPasswordEntered,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[900],
                          minimumSize: const Size(320, 40)
                      ),
                      onPressed: () async {
                        await ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Password changed successfully'),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.green[900],
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Profile()),
                        );
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
