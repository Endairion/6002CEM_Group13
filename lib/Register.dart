import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/common/theme_helper.dart';
import 'package:mobile_app_development_cw2/viewmodels/register_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/Login.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

import 'NavigationMenu.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool? isChecked1 = false, isChecked2 = false;
  final _formkey = GlobalKey<FormState>();
  late final RegisterViewModel _model;
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BaseView<RegisterViewModel>(
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/login_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Form(
                      key: _formkey,
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
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                foregroundColor: Colors.black,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Register a new account",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Fill in your personal details",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _model.emailController,
                              validator: _model.emailValidator,
                              decoration: ThemeHelper()
                                  .textInputDecoration("Email", "Email"),
                              cursorColor: Colors.lightGreen,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _model.nameController,
                              validator: _model.nameValidator,
                              decoration: ThemeHelper()
                                  .textInputDecoration("Full Name", "Full Name"),
                              cursorColor: Colors.lightGreen,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _model.dobController,
                              validator: _model.dobValidator,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Date of Birth", "Date of Birth (DD/MM/YYYY)"),
                              cursorColor: Colors.lightGreen,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _model.icNoController,
                              validator: _model.icNoValidator,
                              decoration: ThemeHelper().textInputDecoration(
                                  "IC No", "IC Number (No space or dash)"),
                              cursorColor: Colors.lightGreen,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _model.contactNoController,
                              validator: _model.contactValidator,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Contact No", "Contact No (No space or dash)"),
                              cursorColor: Colors.lightGreen,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _model.passwordController,
                              validator: _model.passwordValidator,
                              decoration: ThemeHelper()
                                  .textInputDecoration("Password", "Password"),
                              cursorColor: Colors.lightGreen,
                              obscureText: true,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _model.confirmPasswordController,
                              validator: _model.confirmPasswordValidator,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Confirm Password", "Confirm Password"),
                              cursorColor: Colors.lightGreen,
                              obscureText: true,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked1,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked1 = value;
                                    });
                                  },
                                  checkColor: Colors.black,
                                  activeColor: Colors.grey[400],
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                Expanded(
                                    child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'I agree to the ',
                                      ),
                                      TextSpan(
                                        text: 'terms and conditions',
                                        style: TextStyle(
                                          color: Colors.green,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Navigate to terms and conditions page
                                          },
                                      ),
                                      TextSpan(
                                        text: ' & ',
                                      ),
                                      TextSpan(
                                        text: 'privacy policy',
                                        style: TextStyle(
                                          color: Colors.green,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Navigate to privacy policy page
                                          },
                                      ),
                                      TextSpan(
                                        text: ' stated.',
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked2,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked1 = value;
                                    });
                                  },
                                  checkColor: Colors.black,
                                  activeColor: Colors.grey[400],
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                Expanded(
                                  child: Text(
                                    'Subscribe to our latest newsfeed for upcoming updates.',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[900],
                                  minimumSize: Size(320, 40)),
                              onPressed: () => _formkey.currentState!.validate()
                                  ? _model.register().then((value) {
                                if (!value) return;
                                Navigator.of(_context).pushReplacementNamed('package:mobile_app_development_cw2/views/Login.dart');
                                //testing
                              })
                                  : null,
                              child: Text('Register'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
    );
  }
}
