import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app_development_cw2/TripHistoryCard.dart';
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

  double _singleListViewHeight = 150;
  double _listViewHeight = 400;
  int maxListCount = 0;

  List<Trip> _tripsList = [];
  List<Trip> _carpoolList = [];
  List<Trip> _pointsEarnList = [];

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {

    getTripHistoryList();

    maxListCount = max(max(_tripsList.length,_carpoolList.length),_pointsEarnList.length);

    if (maxListCount * _singleListViewHeight > _listViewHeight) {
      _listViewHeight = maxListCount * _singleListViewHeight;
    }

  }

  Future<void> getTripHistoryList() async {
    _tripsList = await _firebaseService.getTripList();
    notifyListeners();
    print(_tripsList);
  }

  void onModelDestroy() {
    // _startLocationController.dispose();
    // _destinationController.dispose();
    // _tripsList.clear();
  }

  Widget getTripListCard(int index) {
    if (index == 0) {
      if (_tripsList.isNotEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _tripsList.length,
          itemBuilder: (BuildContext context, int index) {
            return TripHistoryCard(context, _tripsList, index);
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
                  return TripHistoryCard(context, _tripsList, index);
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
      return SizedBox(
        height: 400,
        child: _tripsList.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _tripsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return TripHistoryCard(context, _tripsList, index);
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
    }
  }

  Widget getHistoryList(int index) {
    return SizedBox(
      height: _listViewHeight,
      child: getTripListCard(index),
    );
  }
}