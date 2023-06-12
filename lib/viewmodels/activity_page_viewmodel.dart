import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/earn_point_model.dart';
import 'package:mobile_app_development_cw2/views/carpool_history_card_view.dart';
import 'package:mobile_app_development_cw2/views/points_earn_card.dart';
import 'package:mobile_app_development_cw2/views/trip_history_card_view.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ActivityPageViewModel extends BaseViewModel {
  double _singleListViewHeight = 200;
  double _listViewHeight = 400;
  int maxListCount = 0;

  List<Trip> _tripsList = [];
  List<Trip> _carpoolList = [];
  List<EarnPoint> _pointsEarnList = [];
  List<Trip> _pointsEarnTripList = [];
  List<CarpoolRequest> _userCarpoolRequestList = [];
  List<Trip> _userCarpoolTripList = [];

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
    // retrieve trip history, carpool request history and points history list
    getTripHistoryList();
    getPointsHistoryList();
    getUserCarpoolRequestList();

    // update all trip status
    updateAllTripStatus();
  }

  void setListHeight() async {
    // get the maximum list item count
    maxListCount = max(
        max(_tripsList.length, _carpoolList.length), _pointsEarnList.length);

    // calculate the list view height
    if (maxListCount * _singleListViewHeight > _listViewHeight) {
      _listViewHeight = maxListCount * _singleListViewHeight;
    }
    notifyListeners();
  }

  Future<void> getTripHistoryList() async {
    //get trip history list
    _tripsList = await _firebaseService.getTripList();

    // update list view height
    setListHeight();
    notifyListeners();
  }

  Future<void> getUserCarpoolRequestList() async {
    //get carpool request history list
    _userCarpoolRequestList =
        await _firebaseService.getUserCarpoolRequestList();

    // update list view height
    setListHeight();

    for (var i = 0; i < _userCarpoolRequestList.length; i++) {
      // get the trip details for each carpool request
      Trip trip =
          await _firebaseService.getTrip(_userCarpoolRequestList[i].tripId);
      _userCarpoolTripList.add(trip);
    }

    notifyListeners();
  }

  Future<void> getPointsHistoryList() async {
    //get points earned history list
    _pointsEarnList = await _firebaseService.getPointsEarnedList();

    // update list view height
    setListHeight();

    for (var i = 0; i < _pointsEarnList.length; i++) {
      // get the trip details for each carpool request
      Trip trip = await _firebaseService.getTrip(_pointsEarnList[i].tripId);
      _pointsEarnTripList.add(trip);
    }

    notifyListeners();
  }

  Future<void> updateAllTripStatus() async {
    // get all trip list with status Ongoing
    List<Trip> _tripList = await _firebaseService.getAvailableTripList();

    for (var i = 0; i < _tripList.length; i++) {
      // get the trip date
      DateTime date = new DateFormat("dd-MM-yyyy").parse(_tripList[i].date);

      // get current date
      DateTime currentDate = DateTime.now();

      // compare both date to check if trip date has passed by 1 day
      if (currentDate.difference(date).inDays > 1) {
        // update trip status to expired
        await _firebaseService.updateTripExpiry(_tripList[i].id);
      }
    }

    notifyListeners();
  }

  void onModelDestroy() {
    _tripsList.clear();
  }

  Widget getTripListCard(int index) {
    // trip history tab
    if (index == 0) {
      if (_tripsList.isNotEmpty) {
        // display trip history card list
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _tripsList.length,
          itemBuilder: (BuildContext context, int index) {
            updateAllTripStatus();
            getTripHistoryList();
            return TripHistoryCard(context, _tripsList[index]);
          },
        );
      } else {
        // display empty message
        return const Center(
          child: Text(
            'There is no trips history available.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        );
      }
    } else if (index == 1) {
      // carpool history tab
      if (_userCarpoolRequestList.isNotEmpty) {
        // display carpool history card list
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _userCarpoolRequestList.length,
          itemBuilder: (BuildContext context, int index) {
            getUserCarpoolRequestList();
            return CarpoolHistoryCard(context, _userCarpoolRequestList[index],
                _userCarpoolTripList[index]);
          },
        );
      } else {
        // display empty message
        return const Center(
          child: Text(
            'There is no carpool history available.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        );
      }
    } else {
      // points earned history tab
      if (_pointsEarnList.isNotEmpty) {
        // display points earned history card list
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _pointsEarnList.length,
          itemBuilder: (BuildContext context, int index) {
            getPointsHistoryList();
            return PointsEarnCard(
                context, _pointsEarnList[index], _pointsEarnTripList[index]);
          },
        );
      } else {
        // display empty message
        return const Center(
          child: Text(
            'There is no points earned history available.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        );
      }
    }
  }

  Widget getHistoryList(int index) {
    // display the size box for all list
    return SizedBox(
      height: _listViewHeight,
      // get each list according to menu tab index
      child: getTripListCard(index),
    );
  }
}
