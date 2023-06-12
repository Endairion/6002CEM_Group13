import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/viewmodels/new_password_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/login_view.dart';

class NewPassword extends StatefulWidget {
  final String email;
  NewPassword({Key? key,required this.email}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  late final NewPasswordViewModel _model;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BaseView<NewPasswordViewModel>(
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
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 5),
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
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text('New Password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: Text(
                            'Enter your curent and new password here to change your password!',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.left,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _model.currentPasswordController,
                        validator: _model.currentPasswordValidator,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.lightGreen,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'Current Password',
                            hintText: 'Current Password',
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
                        controller: _model.newPasswordController,
                        validator: _model.newPasswordValidator,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.lightGreen,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                            labelText: 'New Password',
                            hintText: 'New Password',
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
                            ? _model.updatePassword().then((value) {


                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Password Succesfully Changed!"),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                backgroundColor: Colors.green[900],
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                              ),
                            );
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
