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

class ActivityPageViewModel extends BaseViewModel {

  late final List<Trip> _tripsHistory;
  // double _singleListViewHeight = 150;
  // double _listViewHeight = 400;

  List<Trip> _tripsList = [];

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
    // _startLocationController = TextEditingController();
    // _destinationController = TextEditingController();
    //
    // startLocationController.addListener(() {
    //   _onChanged();
    // });
    // destinationController.addListener(() {
    //   _onChanged2();
    // });
    getTripHistoryList();
  }

  // void updateTriplist() {
  //   getTripHistoryList();
  // }

  Future<void> getTripHistoryList() async {
    _tripsList = await _firebaseService.getTripList();
    print(_tripsList);
  }

  void onModelDestroy() {
    // _startLocationController.dispose();
    // _destinationController.dispose();
    _tripsList.clear();
  }

  Widget getHistoryList(int index) {
    if (index == 0) {
      return SizedBox(
      height: 400,
      child: _tripsList.length > 0
          ? ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _tripsList.length,
        itemBuilder: (BuildContext context, int index) {
          getTripHistoryList();
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
}



// Widget getHistoryList(int index, double height, List<Trip> tripList, List<PointsEarn> pointsList) {
//   if (index == 0) {
//     return SizedBox(
//       height: height,
//       child: tripList.length > 0
//           ? ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: tripList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return TripHistoryCard(context, tripList, index);
//         },
//       )
//           : const Center(
//         child: Text(
//           'There are no trips history available.',
//           style: TextStyle(
//             fontStyle: FontStyle.italic,
//             color: Colors.red,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   } else if (index == 1) {
//     return SizedBox(
//       height: height,
//       child: tripList.length > 0
//           ? ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: tripList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return TripHistoryCard(context, tripList, index);
//         },
//       )
//           : const Center(
//         child: Text(
//           'There are no carpool history available.',
//           style: TextStyle(
//             fontStyle: FontStyle.italic,
//             color: Colors.red,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   } else {
//     return SizedBox(
//       height: height,
//       child: pointsList.length > 0
//           ? ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: pointsList.length,
//         itemBuilder: (BuildContext context, int index) {
//           return PointsEarnCard(pointsList, index);
//         },
//       )
//           : const Center(
//         child: Text(
//           'There are no points earned history available.',
//           style: TextStyle(
//             fontStyle: FontStyle.italic,
//             color: Colors.red,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }
