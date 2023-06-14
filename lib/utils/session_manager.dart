import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _userLoggedInKey = 'userLoggedIn';

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userLoggedIn = prefs.getBool(_userLoggedInKey) ?? false;
    return userLoggedIn;
  }

  static Future<void> saveLoggedIn(bool loggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userLoggedInKey, loggedIn);
  }

  static Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await saveLoggedIn(true);
      }
    } catch (e) {
      print('Error logging in: $e');
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await saveLoggedIn(false);
  }
}
