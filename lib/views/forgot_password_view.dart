import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/viewmodels/forgot_password_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/code_verification_view.dart';
import 'package:mobile_app_development_cw2/views/login_view.dart';
import 'package:mobile_app_development_cw2/views/new_password_view.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  late final ForgotPasswordViewModel _model;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BaseView<ForgotPasswordViewModel>(
      onModelReady: (model) {
        _model = model;
        model.onModelReady();
      },
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
                key: _formKey,
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
                        child: Text('Forgot Password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Text(
                            'Enter your email here to reset your password',
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
                        height: 40,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            minimumSize: Size(320, 40)),
                        onPressed: () => _formKey.currentState!.validate()
                            ? _model.sendResetCodeEmail().then((message) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    backgroundColor: message
                                            .contains('Reset link email sent to')
                                        ? Colors.green[900]
                                        : Colors.red[900],
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                  ),
                                );

                                if (message.contains('Reset link email sent to')) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginView(),
                                    ),
                                  );
                                }
                              })
                            : null,
                        child: Text('Submit'),
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
