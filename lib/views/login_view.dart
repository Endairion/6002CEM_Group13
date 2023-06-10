import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/ForgotPassword.dart';
import 'package:mobile_app_development_cw2/views/navigation_menu_view.dart';
import 'package:mobile_app_development_cw2/viewmodels/login_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/register_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formkey = GlobalKey<FormState>();
  late final LoginViewModel _model;
  late final BuildContext _context;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BaseView<LoginViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady();
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Scaffold(
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
              child: Form(
                key: _formkey,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text('Welcome to VTumpang',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Text(
                            'Login to Continue',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.left,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _model.emailController,
                        validator: _model.emailValidator,
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
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _model.passwordController,
                        validator: _model.passwordValidator,
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
                            )),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword()),
                                );
                              },
                              child: Text('Forgot Password?',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green[900]),
                                  textAlign: TextAlign.right))),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            minimumSize: Size(320, 40)),
                        onPressed: () => _formkey.currentState!.validate()
                            ? _model.login().then((value) {
                                if (!value) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavigationMenu()),
                                );
                              })
                            : null,
                        child: Text('Login'),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(120, 5, 0, 5),
                          child: Text('Or',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[900]),
                              textAlign: TextAlign.center)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: Size(320, 40)),
                          onPressed: () {},
                          child: Row(
                            children: [
                              SizedBox(width: 20,),
                               Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/google_icon.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              SizedBox(
                                  width: 20,
                                ),
                              Text('Sign in with Google',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey)),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                              child: Text('Not a Member?',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[900]),
                                  textAlign: TextAlign.center)),
                          Container(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                child: Text('Register Now',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green[900]),
                                    textAlign: TextAlign.center),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterView()),
                                  );
                                },
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
