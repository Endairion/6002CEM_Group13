import 'package:dart_mailgun/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class ChangePasswordViewModel extends BaseViewModel {
  late final TextEditingController _emailController;

  final FirebaseService _firebaseService = locator<FirebaseService>();

    TextEditingController get emailController => _emailController;

  String? Function(String? email) get emailValidator => Validators.emailValidator;

  void onModelReady(){
    _emailController = TextEditingController(text: "");
  }


  Future<String> sendResetCodeEmail() async {
    var email = _emailController.text.trim();
    var code;
    try {
      code = await _firebaseService.getResetCode(email);
      // Continue with sending the reset code email
      // ...
      final client = MailgunClient(
        dotenv.env['MAILGUN_DOMAIN']??'', dotenv.env['MAILGUN_API_KEY']??'',
      );

      final messageClient = client.message;

      final message = MessageParams(
        'vtumpangapp@gmail.com',
        [email],
        'Password Reset',
        MessageContent.html(
            '''
             <html>
              <body>
                <p>Your password reset code is: <strong>$code</strong></p>
              </body>
             </html>
           '''
        ),
      );

      await messageClient.send(message);

      return 'Reset code email sent to $email';


    } catch (e) {
      String errorMessage = e.toString();
      return errorMessage;
    }
  }


}