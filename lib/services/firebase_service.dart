import 'package:mobile_app_development_cw2/utils/error_codes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_app_development_cw2/locator.dart';


class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;

  // Sign In with email and password
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );


    } on FirebaseAuthException catch (e) {
      throw signInErrorCodes[e.code] ?? 'Database Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  // Sign Up using email address
  Future<UserCredential?> signUp(
      String name, String email, String dob, String icNo, String contactNo, String password) async {
    try {
      var _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseFirestore
          .collection('Users')
          .doc(_user.user!.uid)
          .set({
        'name': name,
        'email': email,
        'dob': dob,
        'ic_no': icNo,
        'contact': contactNo,
        'points': '0',
        'driver': '0',
      })
          .then((value) => debugPrint('User Created : ${_user.user!.email}'))
          .catchError((e) => debugPrint('Database Error!'));
      return _user;
    } on FirebaseAuthException catch (e) {
      debugPrint(
          signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!');
    } catch (e) {
      debugPrint('${e.toString()} Error Occured!');
    }
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    try{
      var snapshot = await _firebaseFirestore
          .collection('Users')
          .doc(currentUser.uid)
          .get();
      return snapshot.data() as Map<String, dynamic>;
    } on FirebaseAuthException catch (e){
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e){
      throw '${e.toString()} Error Occured!';
    }
  }


}