import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/driver_model.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_development_cw2/models/earn_point_model.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/custom_request_model.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';
import 'package:mobile_app_development_cw2/models/rewards_redemption_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/utils/error_codes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:mobile_app_development_cw2/locator.dart';

import 'package:path/path.dart' as path;

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
            'points': 0,
            'driver': '0',
            'url': ' ',
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
        id: doc['id'],
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
          'seats': trip.seats,
          'enablePickupNotification': trip.enablePickupNotification,
        })
        .then((value) => print("Trip Created"))
        .catchError((error) => print("Failed to create trip: $error"));
  }

  Future<List<Trip>> getTripList() async {
    // Get docs from trips collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Trips')
        .where('userId', isEqualTo: userId)
        .get();

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
          seats: doc['seats'],
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
            seats: data['seats'],
            enablePickupNotification: data['enablePickupNotification']);

        return trip;
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      throw Exception('Failed to retrieve trip: $e');
    }
  }

  Future<CarpoolRequest> getCarpoolRequest(String requestId) async {
    try {
      final DocumentReference<Map<String, dynamic>> documentRef =
          FirebaseFirestore.instance
              .collection('CarpoolRequests')
              .doc(requestId);
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await documentRef.get();

      if (snapshot.exists) {
        // Retrieve document data
        Map<String, dynamic> data = snapshot.data()!;

        // Create a CarpoolRequest object from the retrieved data
        CarpoolRequest carpoolRequest = CarpoolRequest(
            requestId: data['requestId'],
            requesterId: data['requesterId'],
            tripId: data['tripId'],
            driverId: data['driverId'],
            pickupLocation: data['pickupLocation'],
            remarks: data['remarks'],
            status: data['status']);
        return carpoolRequest;
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
            points: data['points'],
            url: data['url'],
        );
        return user;
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      throw Exception('Failed to retrieve trip: $e');
    }
  }

  Future<Driver> getDriverData(String userId) async{
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection('Driver')
        .where('userid', isEqualTo: userId)
        .get();

    List<Driver> driverList = querySnapshot.docs.map<Driver>((doc) {
      return Driver(
        carBrand: doc['carBrand'],
        carModel: doc['carModel'],
        licensePlate: doc['licensePlate'],
        carImageUrl: doc['carImageUrl'],
        licensePlateImgUrl: doc['licensePlateImgUrl'],
        userId: doc['userid'],
      );
    }).toList();

    return driverList[0];
  }

  Future<List<Trip>> getAvailableTripList() async {
    // Get docs from trips collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Trips')
        .where('status', isEqualTo: 'Ongoing')
        .where('seats', isNotEqualTo: 0)
        .get();

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
          seats: doc['seats'],
          enablePickupNotification: doc['enablePickupNotification']);
    }).toList();

    return tripsList;
  }

  Future<void> completeTrip(String tripId) async {
    var collection = FirebaseFirestore.instance.collection('Trips');
    collection.doc(tripId).update({'status': 'Completed'}) // <-- Updated data
        .then((_) {
      print('Update trip status success');
    }).catchError((error) {
      print('Failed: $error');
    });
  }

  Future<void> updateTripExpiry(String tripId) async {
    var collection = FirebaseFirestore.instance.collection('Trips');
    collection.doc(tripId).update({'status': 'Expired'}) // <-- Updated data
        .then((_) {
      print('Update trip expire status success');
    }).catchError((error) {
      print('Failed: $error');
    });
  }

  Future<void> createPointsEarn(EarnPoint earnPoint) async {
    // Reference to PointsEarned collection
    CollectionReference pointsEarned =
        FirebaseFirestore.instance.collection('PointsEarned');

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
        .catchError(
            (error) => print("Failed to create points earned history: $error"));
  }

  Future<List<EarnPoint>> getPointsEarnedList() async {
    // Get docs from trips collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('PointsEarned')
        .where('userId', isEqualTo: userId)
        .get();

    // Get data from docs and convert map to List
    final pointsEarnedList = querySnapshot.docs.map<EarnPoint>((doc) {
      return EarnPoint(
          tripId: doc['tripId'],
          userId: doc['userId'],
          points: doc['points'],
          role: doc['role']);
    }).toList();

    return pointsEarnedList;
  }

  createCustomRequest(CustomRequest customRequest) {
    CollectionReference customRequests =
        FirebaseFirestore.instance.collection('CustomRequests');

    return customRequests
        .doc(customRequest.id)
        .set({
          'id': customRequest.id,
          'userId': customRequest.userId,
          'startLocation': customRequest.startLocation,
          'destination': customRequest.destination,
          'date': customRequest.date,
          'time': customRequest.time,
          'status': customRequest.status,
          'remarks': customRequest.remarks,
        })
        .then((value) => print("Custom Request Created"))
        .catchError(
            (error) => print("Failed to create custom request: $error"));
  }

  createCarpoolRequest(CarpoolRequest carpoolRequest) {
    CollectionReference carpoolRequests =
        FirebaseFirestore.instance.collection('CarpoolRequests');

    return carpoolRequests
        .doc(carpoolRequest.requestId)
        .set({
          'requestId': carpoolRequest.requestId,
          'requesterId': carpoolRequest.requesterId,
          'tripId': carpoolRequest.tripId,
          'driverId': carpoolRequest.driverId,
          'pickupLocation': carpoolRequest.pickupLocation,
          'remarks': carpoolRequest.remarks,
          'status': carpoolRequest.status,
        })
        .then((value) => print("Carpool Request Created"))
        .catchError(
            (error) => print("Failed to create carpool request: $error"));
  }

  Future<List<CarpoolRequest>> getCarpoolRequestList(String tripId) async {
    // Get docs from CarpoolRequests collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('CarpoolRequests')
        .where('tripId', isEqualTo: tripId)
        .where('status', isEqualTo: "Pending")
        .get();

    // Get data from docs and convert map to List
    final carpoolRequestList = querySnapshot.docs.map<CarpoolRequest>((doc) {
      return CarpoolRequest(
          requestId: doc['requestId'],
          requesterId: doc['requesterId'],
          tripId: doc['tripId'],
          driverId: doc['driverId'],
          pickupLocation: doc['pickupLocation'],
          remarks: doc['remarks'],
          status: doc['status']);
    }).toList();

    return carpoolRequestList;
  }

  Future<List<CarpoolRequest>> getUserCarpoolRequestList() async {
    // Get docs from CarpoolRequests collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('CarpoolRequests')
        .where('requesterId', isEqualTo: userId)
        .get();

    // Get data from docs and convert map to List
    final carpoolRequestList = querySnapshot.docs.map<CarpoolRequest>((doc) {
      return CarpoolRequest(
          requestId: doc['requestId'],
          requesterId: doc['requesterId'],
          tripId: doc['tripId'],
          driverId: doc['driverId'],
          pickupLocation: doc['pickupLocation'],
          remarks: doc['remarks'],
          status: doc['status']);
    }).toList();

    return carpoolRequestList;
  }

  Future<void> acceptCarpoolRequest(String requestId) async {
    var collection = FirebaseFirestore.instance.collection('CarpoolRequests');
    collection.doc(requestId).update({'status': 'Accepted'}) // <-- Updated data
        .then((_) {
      print('Accept carpool request success');
    }).catchError((error) {
      print('Failed: $error');
    });
  }

  Future<void> decrementCarpoolSeats(String tripId) async {
    var collection = FirebaseFirestore.instance.collection('Trips');
    collection
        .doc(tripId)
        .update({'seats': FieldValue.increment(-1)}) // <-- Updated data
        .then((_) {
      print('Decrement carpool remaining seats success');
    }).catchError((error) {
      print('Failed: $error');
    });
  }

  Future<void> rejectCarpoolRequest(String requestId) async {
    var collection = FirebaseFirestore.instance.collection('CarpoolRequests');
    collection.doc(requestId).update({'status': 'Rejected'}) // <-- Updated data
        .then((_) {
      print('Reject carpool request status success');
    }).catchError((error) {
      print('Failed: $error');
    });
  }

  Future compareAvailableTripsLocation(
      String startLocation, String destination) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Trips").get();
    List<String> tripIdList = [];

    for (final DocumentSnapshot doc in querySnapshot.docs) {
      final String fireStoreStartLocation = doc["startLocation"];
      final String fireStoreDestination = doc["destination"];

      final double startLocationSimilarity = StringSimilarity.compareTwoStrings(
          startLocation, fireStoreStartLocation);
      final double destinationSimilarity =
          StringSimilarity.compareTwoStrings(destination, fireStoreDestination);

      print(
          "$startLocation and $fireStoreStartLocation diff $startLocationSimilarity");
      print(
          "$destination and $fireStoreDestination diff $destinationSimilarity");

      if (startLocationSimilarity > 0.25 || destinationSimilarity > 0.25) {
        print('1');
        print(doc['id']);
        tripIdList.add(doc['id']);
      } else {
        print('0');
      }
    }
    return tripIdList;
  }

  Future<List<Trip>> retrieveTripListsbyId(List<String> tripIdList) async {
    // Get docs from trips collection reference where ID is in the tripIds list
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Trips')
        .where(FieldPath.documentId, whereIn: tripIdList)
        .get();

    // Get data from docs and convert map to List
    final tripsList = querySnapshot.docs.map<Trip>((doc) {
      return Trip(
          id: doc.id,
          userId: doc['userId'],
          startLocation: doc['startLocation'],
          destination: doc['destination'],
          date: doc['date'],
          time: doc['time'],
          status: doc['status'],
          seats: doc['seats'],
          enablePickupNotification: doc['enablePickupNotification']);
    }).toList();

    return tripsList;
  }

  Future<List<CarpoolRequest>> getAcceptedCarpoolRequestList(
      String tripId) async {
    // Get docs from CarpoolRequests collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('CarpoolRequests')
        .where('tripId', isEqualTo: tripId)
        .where('status', isEqualTo: "Accepted")
        .get();

    // Get data from docs and convert map to List
    final carpoolRequestList = querySnapshot.docs.map<CarpoolRequest>((doc) {
      return CarpoolRequest(
          requestId: doc['requestId'],
          requesterId: doc['requesterId'],
          tripId: doc['tripId'],
          driverId: doc['driverId'],
          pickupLocation: doc['pickupLocation'],
          remarks: doc['remarks'],
          status: doc['status']);
    }).toList();

    return carpoolRequestList;
  }

  Future<int?> getUserPoints() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        int points = snapshot.get('points');
        return points;
      } else {
        // Document with the specified user ID does not exist
        print("Nothing retrieved(ID) : " + userId);
        return null;
      }
    } catch (e) {
      print('Error getting field from collection: $e');
      return null;
    }
  }

  Future<Rewards> getReward(String rewardId) async {
    try {
      final DocumentReference<Map<String, dynamic>> documentRef =
          FirebaseFirestore.instance.collection('Rewards').doc(rewardId);
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await documentRef.get();

      if (snapshot.exists) {
        // Retrieve document data
        Map<String, dynamic> data = snapshot.data()!;

        // Create a Trip object from the retrieved data
        Rewards rewards = Rewards(
            id: data['id'],
            desc: data['desc'],
            discount: data['discount'],
            points: data['points'],
            remaining: data['remaining'],
            store: data['store'],
            url: data['url']);
        return rewards;
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      throw Exception('Failed to retrieve trip: $e');
    }
  }

  createRedeemRewards(RewardsRedemption rewardsRedeem) {
    CollectionReference rewardRedemption =
        FirebaseFirestore.instance.collection('RewardsRedemption');

    return rewardRedemption
        .doc(rewardsRedeem.redemptionId)
        .set({
          'redemptionId': rewardsRedeem.redemptionId,
          'storeId': rewardsRedeem.storeId,
          'userId': rewardsRedeem.userId,
          'date': rewardsRedeem.date,
          'status': rewardsRedeem.status,
        })
        .then((value) => print("RewardsRedemption Created"))
        .catchError(
            (error) => print("Failed to create rewardsRedeem : $error"));
  }

  Future updateStoreStock(String id, int remaining) async {
    try {
      await _firebaseFirestore.collection('Rewards').doc(id).set(
        {
          'remaining': remaining,
        },
        SetOptions(merge: true),
      );
    } on FirebaseAuthException catch (e) {
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occurred!';
    }
  }

  Future updateUserPoints(String userId, int points) async {
    try {
      await _firebaseFirestore.collection('Users').doc(userId).set(
        {
          'points': points,
        },
        SetOptions(merge: true),
      );
    } on FirebaseAuthException catch (e) {
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  Future<List<RewardsRedemption>> getMyRewardsList(String userId) async {
    // Get docs from CarpoolRequests collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('RewardsRedemption')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: "Unused")
        .get();

    // Get data from docs and convert map to List
    final rewardsRedemption = querySnapshot.docs.map<RewardsRedemption>((doc) {
      return RewardsRedemption(
          redemptionId: doc['redemptionId'],
          storeId: doc['storeId'],
          userId: doc['userId'],
          date: doc['date'],
          status: doc['status']);
    }).toList();

    return rewardsRedemption;
  }

  Future updateRewardsRedemptionStatus(String redemptionId) async {
    try {
      await _firebaseFirestore
          .collection('RewardsRedemption')
          .doc(redemptionId)
          .set(
        {
          'status': 'Used',
        },
        SetOptions(merge: true),
      );
    } on FirebaseAuthException catch (e) {
      throw signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  Future<List<RewardsRedemption>> getUserRedemptionList(String userId) async {
    // Get docs from CarpoolRequests collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('RewardsRedemption')
        .where('userId', isEqualTo: userId)
        .get();

    // Get data from docs and convert map to List
    final rewardsRedemption = querySnapshot.docs.map<RewardsRedemption>((doc) {
      return RewardsRedemption(
          redemptionId: doc['redemptionId'],
          storeId: doc['storeId'],
          userId: doc['userId'],
          date: doc['date'],
          status: doc['status']);
    }).toList();

    return rewardsRedemption;
  }

  Future<void> updateUserProfile(Map<String, dynamic> userProfile) async {
    try {
      await _firebaseFirestore
          .collection('Users')
          .doc(currentUser.uid)
          .update(userProfile);
    } catch (e) {
      throw '${e.toString()} Error Occurred!';
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> getResetCode(String email) async {
    try {
      // Generate a 6-digit reset code
      Random random = Random();
      String resetCode = (random.nextInt(900000) + 100000).toString();

      // Query the Firestore collection for the user with the given email
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Update or create the resetCode field for the first matching user
        DocumentSnapshot userSnapshot = querySnapshot.docs[0];
        DocumentReference userRef = userSnapshot.reference;

        if (userSnapshot.exists) {
          // Update the existing resetCode field
          await userRef.update({'resetCode': resetCode});
        } else {
          // Create a new document with the resetCode field
          await userRef.set({'resetCode': resetCode});
        }
      } else {
        throw 'User not found for the provided email!';
      }

      return resetCode;
    } catch (e) {
      throw '${e.toString()} Try Again!';
    }
  }

  Future<String> verifyCode(String code, String email) async {
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection('Users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot userSnapshot = querySnapshot.docs[0];

      if (userSnapshot.exists) {
        String resetCode = userSnapshot.get('resetCode');

        if (resetCode != code) {
          return 'Invalid code!';
        } else {
          return 'Valid code!';
        }
      } else {
        return 'User not found for the provided email!';
      }
    } else {
      return 'User not found for the provided email!';
    }
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        // Prompt the user to reauthenticate before updating the password
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: currentPassword);
        await user.reauthenticateWithCredential(credential);

        // Update the password
        await user.updatePassword(newPassword);
      } else {
        throw Exception('User is not currently authenticated.');
      }
    } catch (e) {
      throw '${e.toString()} Error Occurred!';
    }
  }

  Future<void> sendResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw '${e.toString()} Error Occurred!';
    }
  }

  Future<List<CustomRequest>> getCustomCarpoolRequestList(String userId) async {
    // Get docs from CarpoolRequests collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('CustomRequests')
        .where('userId', isNotEqualTo: userId)
        .where('status', isEqualTo: "Pending")
        .get();

    // Get current time
    DateTime currentTime = DateTime.now();

    // Get data from docs and convert map to List
    final customRequestList = querySnapshot.docs.map<CustomRequest>((doc) {
      // Get the time from the document

      DateTime requestTime = new DateFormat("dd-MM-yyyy").parse(doc['date']);
      DateTime customRequestTime = DateFormat.jm().parse(doc['time']);
      int hour = customRequestTime.hour;
      int minutes = customRequestTime.minute;

      requestTime = requestTime.add(Duration(hours: hour, minutes: minutes));

      // Calculate the time difference
      Duration timeDifference = currentTime.difference(requestTime);
      print("current time is $currentTime");

      print("requestTime is $requestTime");
      print("timeDifference is $timeDifference");

      // Create a CustomRequest object if the time difference is within 30 minutes
      return CustomRequest(
        id: doc['id'],
        userId: doc['userId'],
        startLocation: doc['startLocation'],
        destination: doc['destination'],
        date: doc['date'],
        time: doc['time'],
        status: doc['status'],
        remarks: doc['remarks'],
      );
    }).where((customRequest) {
      // Filter out the elements with a time difference exceeding 60 minutes
      DateTime requestTime = new DateFormat("dd-MM-yyyy").parse(customRequest.date);
      DateTime customRequestTime = DateFormat.jm().parse(customRequest.time);
      int hour = customRequestTime.hour;
      int minutes = customRequestTime.minute;

      requestTime = requestTime.add(Duration(hours: hour, minutes: minutes));

      Duration timeDifference = currentTime.difference(requestTime);
      print("1");
      return timeDifference.inMinutes <= 60;
    }).toList();

    print("in firebase services" + customRequestList.toString());

    return customRequestList;
  }

  Future<void> updateCustomCarpoolRequestStatus(String requestId) async {
    var collection = FirebaseFirestore.instance.collection('CustomRequests');
    collection.doc(requestId).update({'status': 'Accepted'}) // <-- Updated data
        .then((_) {
      print('Update request status success');
    }).catchError((error) {
      print('Failed: $error');
    });
  }

  Future<void> submitVerification(
      String carBrand,
      String carModel,
      String licensePlate,
      String carImageUrl,
      String licensePlateImgUrl) async {
    try {
      String? userId = _firebaseAuth.currentUser?.uid;

      if (userId != null) {
        await _firebaseFirestore.collection('Driver').add({
          'carBrand': carBrand,
          'carModel': carModel,
          'licensePlate': licensePlate,
          'carImageUrl': carImageUrl,
          'licensePlateImgUrl': licensePlateImgUrl,
          'userid': userId,
        });
        print('Driver verification submitted successfully!');
      } else {
        print('User is not currently authenticated.');
      }
    } catch (e) {
      print('${e.toString()} Error Occurred!');
    }
  }

  Future<Driver> getDriverInformation() async {
    var userId = _firebaseAuth.currentUser?.uid;
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection('Driver')
        .where('userid', isEqualTo: userId)
        .get();

    List<Driver> driverList = querySnapshot.docs.map<Driver>((doc) {
      return Driver(
        carBrand: doc['carBrand'],
        carModel: doc['carModel'],
        licensePlate: doc['licensePlate'],
        carImageUrl: doc['carImageUrl'],
        licensePlateImgUrl: doc['licensePlateImgUrl'],
        userId: doc['userid'],
      );
    }).toList();

    return driverList[0];
  }

  Future<String> uploadImageToFirebaseStorage(
      File file, String folderName) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
      FirebaseStorage.instance.ref().child(folderName);
      UploadTask uploadTask = storageReference.child(fileName).putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw 'Error uploading image to Firebase Storage: $e';
    }
  }

  Future<void> updateDriverStatus() async {
    await _firebaseFirestore.collection('Users').doc(currentUser.uid).update(
      {
        'driver': "2",
      },
    );
  }

  Future<void> saveToken(String token) async{
    await FirebaseFirestore.instance.collection("UserTokens").doc(userId).set({
      'token' : token,
    });
  }

  Future<void> updateProfileImageUrl(String url) async {
    try {
      final userRef = _firebaseFirestore.collection('Users').doc(currentUser.uid);
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        // Update the 'url' field if it exists
        if (userDoc.data()!.containsKey('url')) {
          await userRef.update({'url': url});
        } else {
          // Create a new 'url' field if it doesn't exist
          await userRef.set({'url': url}, SetOptions(merge: true));
        }
      } else {
        throw 'User document not found!';
      }
    } catch (e) {
      throw 'Failed to update profile image URL: $e';
    }
  }

  Future<void> deleteImageFromFirebaseStorage(String url) async {
    try {
      // Create a Firebase Storage reference from the URL
      Reference storageRef = FirebaseStorage.instance.refFromURL(url);

      // Delete the file from Firebase Storage
      await storageRef.delete();
      print('Image deleted successfully');
    } catch (e) {
      print('Error deleting image from Firebase Storage: $e');
      // Handle the error accordingly
    }
  }

}



