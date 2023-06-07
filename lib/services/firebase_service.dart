import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/earn_point_model.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
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

  Future<List<Rewards>> getRewardsLists() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Rewards').get();

    // Get data from docs and convert map to List
    final rewardsList = querySnapshot.docs.map<Rewards>((doc) {
      return Rewards(
        desc: doc['desc'],
        discount: doc['discount'],
        points: doc['points'],
        remaining: doc['remaining'],
        store: doc['store'],
        url: doc['url'],
      );
    }).toList();

    return rewardsList;
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
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Trips').where('userId', isEqualTo: userId).get();

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

  Future<Trip> getTrip(String tripId) async {
    try {
      final DocumentReference<Map<String, dynamic>> documentRef =
          FirebaseFirestore.instance.collection('Trips').doc(tripId);
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await documentRef.get();

      if (snapshot.exists) {
        // Retrieve document data
        Map<String, dynamic> data = snapshot.data()!;

        // Create a Trip object from the retrieved data
        Trip trip = Trip(
            id: data['id'],
            userId: data['userId'],
            startLocation: data['startLocation'],
            destination: data['destination'],
            date: data['date'],
            time: data['time'],
            status: data['status'],
            stops: data['stops'],
            seats: int.parse(data['seats']),
            enablePickupNotification: data['enablePickupNotification']);

        return trip;
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      throw Exception('Failed to retrieve trip: $e');
    }
  }

  Future<Users> getUserData(String userId) async {
    try {
      final DocumentReference<Map<String, dynamic>> documentRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await documentRef.get();

      if (snapshot.exists) {
        // Retrieve document data
        Map<String, dynamic> data = snapshot.data()!;

        // Create a User object from the retrieved data
        Users user = Users(
            name: data['name'],
            email: data['email'],
            contact: data['contact'],
            dob: data['dob'],
            ic_no: data['ic_no'],
            points: data['points']);
        return user;
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      throw Exception('Failed to retrieve trip: $e');
    }
  }

  Future<List<Trip>> getAvailableTripList() async {
    // Get docs from trips collection reference
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Trips').get();

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

  Future<void> completeTrip(String tripId) async {
    // print(tripId);
    var collection = FirebaseFirestore.instance.collection('Trips');
    collection
        .doc(tripId)
        .update({'status' : 'Completed'}) // <-- Updated data
        .then((_) {
          print('Update trip status success');
        })
        .catchError((error) {
          print('Failed: $error');
        });
  }

  Future<void> createPointsEarn(EarnPoint earnPoint) async {
    // Reference to PointsEarned collection
    CollectionReference pointsEarned = FirebaseFirestore.instance.collection('PointsEarned');

    earnPoint.userId = userId;

    // Call the PointsEarned CollectionReference to add a new record
    return pointsEarned
        .doc()
        .set({
      'tripId': earnPoint.tripId,
      'userId': earnPoint.userId,
      'points': earnPoint.points,
      'role': earnPoint.role,
    })
        .then((value) => print("Points earned history created"))
        .catchError((error) => print("Failed to create points earned history: $error"));
  }
}
