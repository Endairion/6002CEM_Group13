import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app_development_cw2/models/earn_point_model.dart';
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

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
    getTripHistoryList();
    getPointsHistoryList();
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

  Future<void> getPointsHistoryList() async {
    _pointsEarnList = await _firebaseService.getPointsEarnedList();
    setListHeight();

    for(var i=0;i<_pointsEarnList.length;i++){
      Trip trip = await _firebaseService.getTrip(_pointsEarnList[i].tripId);
      _pointsEarnTripList.add(trip);
    }

    notifyListeners();
  }

  void onModelDestroy() {
    // _startLocationController.dispose();
    // _destinationController.dispose();
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
            getTripHistoryList();
            return TripHistoryCard(context, _tripsList[index]);
          },
        );
      } else {
        return const Center(
          child: Text(
            'There are no trips history available.',
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
        child: _tripsList.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _tripsList.length,
                itemBuilder: (BuildContext context, int index) {
                  getTripHistoryList();
                  return TripHistoryCard(context, _tripsList[index]);
                },
              )
            : const Center(
                child: Text(
                  'There are no trips history available.',
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
            'There are no points earned history available.',
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