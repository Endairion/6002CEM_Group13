import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              width: 390,
              height: 320,
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
                    offset: Offset(0, 3),
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
                      alignment: Alignment.centerLeft,
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                        textAlign: TextAlign.left),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                      child: Text(
                        'Enter your email here to receive a password reset link',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.left,)
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.lightGreen,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        )
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green[900],
                        minimumSize: Size(320, 40)
                    ),
                    onPressed: (){},
                    child: Text('Submit'),
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
