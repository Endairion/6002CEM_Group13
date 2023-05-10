import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mobile_app_development_cw2/ForgotPassword.dart';
import 'package:mobile_app_development_cw2/Homepage.dart';
import 'package:mobile_app_development_cw2/Register.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();

  //runApp(const MyApp());

  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
                height: 480,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(50),
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
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      child: Text(
                          'Welcome to VTumpang',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                          textAlign: TextAlign.left),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        child: Text(
                          'Login to Continue',
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
                      height: 10,
                    ),

                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      cursorColor: Colors.lightGreen,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),

                    Container(
                        alignment: Alignment.centerRight,
                        child:
                        TextButton(
                          onPressed:(){
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

                    ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          primary: Colors.green[900],
                          minimumSize: Size(320, 40)
                        ),
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Homepage()),
                            );
                          },
                          child: Text('Login'),
                    ),

                    Container(
                        margin: EdgeInsets.fromLTRB(120, 5, 0, 5),
                        child: Text(
                            'Or',
                            style: TextStyle(fontSize: 12, color: Colors.grey[900]),
                            textAlign: TextAlign.center)
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(320, 40)
                      ),
                      onPressed: (){},
                      child:Row(
                        children: [
                          Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                            height:40,
                            width: 40),
                          SizedBox(width: 10,),
                          Text('Sign in with Google',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey)),

                        ],
                      )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Text(
                                'Not a Member?',
                                style: TextStyle(fontSize: 12, color: Colors.grey[900]),
                                textAlign: TextAlign.center)
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                                child: Text('Register Now',
                                    style: TextStyle(fontSize: 12, color: Colors.green[900]),
                                    textAlign: TextAlign.center),
                                onPressed: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Register()),
                                );
                              },

                                )
                        ),
                      ],
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
