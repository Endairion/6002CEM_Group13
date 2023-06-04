
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

import '../locator.dart';
import '../models/trip_model.dart';
import '../services/firebase_service.dart';

class RequestCarpoolViewmodel extends BaseViewModel{
  String _startLocation = "";
  String _destination = "";
  String _driver = "";
  String _date = "";
  String _time = "";
  int _seats = 0;


  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String tripId) {
    getTrip(tripId);
  }

  void onModelDestroy() {}

  Future<void> getTrip(String tripId) async {
    Trip trip = await _firebaseService.getTrip(tripId);
    Users user = await _firebaseService.getUserData(trip.userId);
    _startLocation = trip.startLocation;
    _destination = trip.destination;
    _date = trip.date;
    _time = trip.time;
    _seats = trip.seats;
    _driver = user.name;


    notifyListeners();
  }


  // Getters
  int get seats => _seats;

  String get time => _time;

  String get date => _date;

  String get driver => _driver;

  String get destination => _destination;

  String get startLocation => _startLocation;


  // Setters
  set seats(int value) {
    _seats = value;
  }

  set time(String value) {
    _time = value;
  }

  set date(String value) {
    _date = value;
  }

  set driver(String value) {
    _driver = value;
  }

  set destination(String value) {
    _destination = value;
  }

  set startLocation(String value) {
    _startLocation = value;
  }

}