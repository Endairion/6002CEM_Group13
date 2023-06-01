import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/utils/error_codes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_app_development_cw2/locator.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;
  String get userId => _firebaseAuth.currentUser!.uid;

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
  Future<UserCredential?> signUp(String name, String email, String dob,
      String icNo, String contactNo, String password) async {
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
    try {
      var snapshot = await _firebaseFirestore
          .collection('Users')
          .doc(currentUser.uid)
          .get();
      return snapshot.data() as Map<String, dynamic>;
    } on FirebaseAuthException catch (e) {
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }
  
  Future<QuerySnapshot> fetchRewardsData(){
    return FirebaseFirestore.instance.collection('Rewards').get();
  }

  // Reference to Trips collection
  CollectionReference trips = FirebaseFirestore.instance.collection('Trips');

  Future<void> createTrip(Trip trip) {
    // Call the Trip's CollectionReference to add a new user
    return trips
        .doc(trip.id)
        .set({
          'id': trip.id,
          'userId': trip.userId,
          'startLocation': trip.startLocation,
          'destination': trip.destination,
          'date': trip.date,
          'time': trip.time,
          'status': trip.status,
          'stops': trip.stops,
          'seats': trip.seats.toString(),
          'enablePickupNotification': trip.enablePickupNotification,
        })
        .then((value) => print("Trip Created"))
        .catchError((error) => print("Failed to create trip: $error"));
  }

  Future<List<Trip>> getTripList() async {
    // Get docs from trips collection reference
    QuerySnapshot querySnapshot = await trips.where('userId', isEqualTo: userId).get();

    // List<Trip> _tripsList;

    // Get data from docs and convert map to List
    final tripsList = querySnapshot.docs.map<Trip>((doc) {
      return Trip(
          id: doc['id'],
          userId: doc['userId'],
          startLocation: doc['startLocation'],
          destination: doc['destination'],
          date: doc['date'],
          time: doc['time'],
          status: doc['status'],
          stops: doc['stops'],
          seats: int.parse(doc['seats']),
          enablePickupNotification: doc['enablePickupNotification']);
    }).toList();

    return tripsList;
  }

  Future<void> getTrip(String tripId) async {
    // Get docs from trips collection reference
    var snapshot = await trips.doc(tripId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });

    return snapshot.data();
    // List<Trip> _tripsList;

    // Get data from docs and convert map to List
    // final tripsList = documentSnapshot.docs.map<Trip>((doc) {
    //   return Trip(
    //       id: doc['id'],
    //       userId: doc['userId'],
    //       startLocation: doc['startLocation'],
    //       destination: doc['destination'],
    //       date: doc['date'],
    //       time: doc['time'],
    //       status: doc['status'],
    //       stops: doc['stops'],
    //       seats: int.parse(doc['seats']),
    //       enablePickupNotification: doc['enablePickupNotification']);
    // }).toList();
    //
    // return tripsList;
  }
}
