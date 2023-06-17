import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/views/new_password_view.dart';

import '../viewmodels/code_verification_viewmodel.dart';
import 'base_view.dart';

class CodeVerification extends StatefulWidget {
  final String email;

  CodeVerification({Key? key, required this.email}) : super(key: key);

  @override
  State<CodeVerification> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerification> {
  final _formKey = GlobalKey<FormState>();
  late final CodeVerificationViewModel _model;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BaseView<CodeVerificationViewModel>(
      onModelReady: (model){
        _model = model;
        model.onModelReady();
      },
      builder: (context,model,child)=> Scaffold(
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
                key: _formKey,
                child: Container(
                  width: 390,
                  height: 300,
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: const Text(
                            'Code Verification',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                            textAlign: TextAlign.left),
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: const Text(
                            'Enter your reset code here to reset your password',
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.left,)
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        controller: _model.codeController,
                        validator: _model.codeValidator,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.lightGreen,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.numbers),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                            filled: true,
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(),
                            labelText: 'Verification Code',
                            hintText: 'Verification Code',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            minimumSize: const Size(320, 40)
                        ),
                        onPressed: () => _formKey.currentState!.validate()
                            ? _model.verifyCode(widget.email).then((message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: message
                                  .contains('Valid code!')
                                  ? Colors.green[900]
                                  : Colors.red[900],
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                            ),
                          );
                          if(message.contains('Valid code!')) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewPassword(email: widget.email),
                              ),
                            );
                          }
                        })
                            : null,
                        child: const Text('Submit'),
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
