import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/views/pickup_address_card_view.dart';
import 'package:mobile_app_development_cw2/views/pickup_passenger_card_view.dart';
import 'package:intl/intl.dart';

class OngoingTripDetailsViewModel extends BaseViewModel {
  String _tripId = "";
  String _startLocation = "";
  String _destination = "";
  String _departureTime = "";
  String _arrivalTime = "";
  String _distance = "";
  String _duration = "";
  int _durationValue = 0;
  int _seats = 0;

  List<CarpoolRequest> _acceptedCarpoolRequestList = [];
  List<Users> _passengerList = [];

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String tripId) {
    // set tripId
    _tripId = tripId;
    // get trip details
    getTrip(tripId);
    // get passenger list
    getAcceptedCarpoolRequestList();
  }

  void onModelDestroy() {}

  Future<void> getTrip(String tripId) async {
    // get trip details based on tripId
    Trip trip = await _firebaseService.getTrip(tripId);
    // set trip details text
    _startLocation = trip.startLocation;
    _destination = trip.destination;
    _seats = trip.seats;

    // get distance matrix of the trip
    await getDistanceMatrix();

    // calculate trip arrival time
    calculateArrivalTime();

    notifyListeners();
  }

  Future<void> getDistanceMatrix() async {
    // set Map API key
    String API_KEY = dotenv.env['GOOGLE_API_KEY']??'';
    try {
      // use Distance Matrix API to calculate the distance matrix from start location to destination
      var response = await Dio().get(
          'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$_destination&origins=$_startLocation&mode=driving&key=$API_KEY');
      if (response.statusCode == 200) {
        print(response);

        // Extract the distance and duration from the response
        _distance = response.data['rows'][0]['elements'][0]['distance']['text'];
        _duration = response.data['rows'][0]['elements'][0]['duration']['text'];
        _durationValue = response.data['rows'][0]['elements'][0]['duration']
            ['value']; // duration in seconds unit

        notifyListeners();
      } else {
        print('Failed to retrieve distance matrix');
      }
    } catch (e) {
      print(e);
    }
  }

  void calculateArrivalTime() async {
    // Calculate arrival time based on departure time and duration
    DateTime departureDateTime = DateTime.now();
    _departureTime = DateFormat.jm().format(departureDateTime);

    // add the duration in seconds to the departure date and time to get estimated arrival time
    Duration duration = Duration(seconds: _durationValue);
    DateTime arrivalDateTime = departureDateTime.add(duration);

    // set the arrival time text
    _arrivalTime = DateFormat.jm().format(arrivalDateTime);

    notifyListeners();
  }

  Future<void> getAcceptedCarpoolRequestList() async {
    // get accepted carpool list of the trip
    _acceptedCarpoolRequestList =
        await _firebaseService.getAcceptedCarpoolRequestList(_tripId);

    // get passenger user list from the accepted carpool list
    await getPassengerList();

    notifyListeners();
  }

  Future<void> getPassengerList() async {
    for (var i = 0; i < _acceptedCarpoolRequestList.length; i++) {
      // get passenger user data for each accepted carpool request
      Users user = await _firebaseService
          .getUserData(_acceptedCarpoolRequestList[i].requesterId);
      _passengerList.add(user);
    }
    notifyListeners();
  }

  Widget getPickupAddressCardList() {
    // display passenger pickup location address list
    if (_acceptedCarpoolRequestList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _acceptedCarpoolRequestList.length,
        itemBuilder: (BuildContext context, int index) {
          getAcceptedCarpoolRequestList();
          return PickupAddressCardView(
              _acceptedCarpoolRequestList[index], index);
        },
      );
    } else {
      return Container();
    }
  }

  Widget getPickupPassengerCardList() {
    // display pickup passenger card list
    if (_acceptedCarpoolRequestList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _acceptedCarpoolRequestList.length,
        itemBuilder: (BuildContext context, int index) {
          getAcceptedCarpoolRequestList();
          return PickupPassengerCardView(
              carpoolRequest: _acceptedCarpoolRequestList[index],
              user: _passengerList[index]);
        },
      );
    } else {
      // display empty message
      return SizedBox(
        height: 100,
        child: const Center(
          child: Text(
            'There are no carpool passenger.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        ),
      );
    }
  }

  // Getters
  String get startLocation => _startLocation;
  String get destination => _destination;
  String get arrivalTime => _arrivalTime;
  String get departureTime => _departureTime;
  String get duration => _duration;
  String get distance => _distance;

  // Setters
  set destination(String value) {
    _destination = value;
  }

  set startLocation(String value) {
    _startLocation = value;
  }

  set arrivalTime(String value) {
    _arrivalTime = value;
  }

  set departureTime(String value) {
    _departureTime = value;
  }

  set duration(String value) {
    _duration = value;
  }

  set distance(String value) {
    _distance = value;
  }

  int get seats => _seats;

  set seats(int value) {
    _seats = value;
  }

  int get durationValue => _durationValue;

  set durationValue(int value) {
    _durationValue = value;
  }
}
