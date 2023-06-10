import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/earn_point_model.dart';
import 'package:mobile_app_development_cw2/views/carpool_history_card_view.dart';
import 'package:mobile_app_development_cw2/views/points_earn_card.dart';
import 'package:mobile_app_development_cw2/views/trip_history_card_view.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
    getTripHistoryList();
    getPointsHistoryList();
    getUserCarpoolRequestList();
    updateAllTripStatus();
  }

  void setListHeight() async {
    maxListCount = max(max(_tripsList.length,_carpoolList.length),_pointsEarnList.length);

    if (maxListCount * _singleListViewHeight > _listViewHeight) {
      _listViewHeight = maxListCount * _singleListViewHeight;
    }
    notifyListeners();
  }

  Future<void> getTripHistoryList() async {
    _tripsList = await _firebaseService.getTripList();
    setListHeight();
    notifyListeners();
  }

  Future<void> getUserCarpoolRequestList() async {
    _userCarpoolRequestList = await _firebaseService.getUserCarpoolRequestList();
    setListHeight();

    for(var i=0;i<_userCarpoolRequestList.length;i++){
      Trip trip = await _firebaseService.getTrip(_userCarpoolRequestList[i].tripId);
      _userCarpoolTripList.add(trip);
    }

    notifyListeners();
  }

  Future<void> getPointsHistoryList() async {
    _pointsEarnList = await _firebaseService.getPointsEarnedList();
    setListHeight();

    for(var i=0;i<_pointsEarnList.length;i++){
      Trip trip = await _firebaseService.getTrip(_pointsEarnList[i].tripId);
      _pointsEarnTripList.add(trip);
    }

    notifyListeners();
  }

  //function to update list expiry status
  Future<void> updateAllTripStatus() async {
    List<Trip> _tripList = await _firebaseService.getAvailableTripList();

    for(var i=0;i<_tripList.length;i++){
      Trip trip = await _firebaseService.getTrip(_tripList[i].id);

      DateTime date = new DateFormat("dd-MM-yyyy").parse(trip.date);
      DateTime currentDate = DateTime.now();

      if (currentDate.difference(date).inDays > 1 ) {
        await _firebaseService.updateTripExpiry(_tripList[i].id);
      }
    }

    notifyListeners();
  }

  void onModelDestroy() {
    _tripsList.clear();
  }

  Widget getTripListCard(int index) {
    if (index == 0) {
      if (_tripsList.isNotEmpty) {
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
      return SizedBox(
        height: 400,
        child: _userCarpoolRequestList.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _userCarpoolRequestList.length,
                itemBuilder: (BuildContext context, int index) {
                  getUserCarpoolRequestList();
                  return CarpoolHistoryCard(context, _userCarpoolRequestList[index], _userCarpoolTripList[index]);
                },
              )
            : const Center(
                child: Text(
                  'There is no carpool history available.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
      );
    } else {
      if (_pointsEarnList.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _pointsEarnList.length,
          itemBuilder: (BuildContext context, int index) {
            getPointsHistoryList();
            return PointsEarnCard(context, _pointsEarnList[index], _pointsEarnTripList[index]);
          },
        );
      } else {
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
    return SizedBox(
        height: _listViewHeight,
        child: getTripListCard(index),
      );
  }
}