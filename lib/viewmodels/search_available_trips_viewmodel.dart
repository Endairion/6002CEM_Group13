import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/available_trips_card_view.dart';

class SearchAvailableTripsViewmodel extends BaseViewModel {
  String _startLocation = "";
  String _destination = "";
  String _driver = "";
  String _date = "";
  String _time = "";
  int _seats = 0;
  List<Trip> _tripsList = [];
  double _listViewHeight = 400;

  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
    getAvailableTripList();
    print('2');
    print(_tripsList.length);
  }

  void onModelDestroy() {
    _tripsList.clear();
  }

  Future<void> getAvailableTripList() async {
    print('1');
    _tripsList = await _firebaseService.getTripList();
    print(_tripsList.length);
    notifyListeners();
  }

  // Getter
  int get seats => _seats;

  String get time => _time;

  String get date => _date;

  String get driver => _driver;

  String get destination => _destination;

  String get startLocation => _startLocation;

  List<Trip> get tripsList => _tripsList;

  // Setter
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

  set tripsList(List<Trip> value) {
    _tripsList = value;
  }

  Widget getTripList(int index) {
    return SizedBox(
      // height: _listViewHeight,
      // child: getTripListCard(index),
    );
  }

  // Widget getTripListCard(int index) {
  //   if (index == 0) {
  //     if (_tripsList.isNotEmpty) {
  //       return ListView.builder(
  //         shrinkWrap: true,
  //         physics: NeverScrollableScrollPhysics(),
  //         itemCount: _tripsList.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           return AvailableTripsCardView(context, _tripsList, index);
  //         },
  //       );
  //     } else {
  //       return const Center(
  //         child: Text(
  //           'There are no trips available.',
  //           style: TextStyle(
  //             fontStyle: FontStyle.italic,
  //             color: Colors.red,
  //             fontSize: 16,
  //           ),
  //         ),
  //       );
  //     }
  //   }
  //   else{
  //     return null;
  //   }
  // }
}
