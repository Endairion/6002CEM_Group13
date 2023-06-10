import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/pickup_address_card_view.dart';
import 'package:mobile_app_development_cw2/views/trip_passenger_request_card.dart';

class TripDetailsViewModel extends BaseViewModel {

  double _singleListViewHeight = 200;
  double _listViewHeight = 260;

  String _tripId = "";
  String _date = "";
  String _time = "";
  String _startLocation = "";
  String _destination = "";
  String _status = "";

  List<CarpoolRequest> _carpoolRequestList = [];
  List<Users> _passengerList = [];
  List<CarpoolRequest> _acceptedCarpoolRequestList = [];

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String tripId) {
    _tripId = tripId;
    getTrip(tripId);
    getPickupLocationList();
    getCarpoolRequestList();
  }

  void onModelDestroy() {
  }

  Future<void> getTrip(String tripId) async {
    Trip trip = await _firebaseService.getTrip(tripId);

    _date = trip.date;
    _time = trip.time;
    _startLocation = trip.startLocation;
    _destination = trip.destination;
    _status = trip.status;

    notifyListeners();
  }

  Future<void> getCarpoolRequestList() async {
    _carpoolRequestList = await _firebaseService.getCarpoolRequestList(_tripId);
    setListHeight();

    for(var i=0;i<_carpoolRequestList.length;i++){
      Users user = await _firebaseService.getUserData(_carpoolRequestList[i].requesterId);
      _passengerList.add(user);
    }

    notifyListeners();
  }

  void setListHeight() async {
    if (_singleListViewHeight * _carpoolRequestList.length > _listViewHeight) {
      _listViewHeight = _singleListViewHeight * _carpoolRequestList.length;
    }
    notifyListeners();
  }

  Future<void> getPickupLocationList() async {
    _acceptedCarpoolRequestList = await _firebaseService.getAcceptedCarpoolRequestList(_tripId);
    notifyListeners();
  }

  Widget getPickupAddressCardList() {
    if (_acceptedCarpoolRequestList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _acceptedCarpoolRequestList.length,
        itemBuilder: (BuildContext context, int index) {
          getPickupLocationList();
          return PickupAddressCardView(_acceptedCarpoolRequestList[index], index);
        },
      );
    } else {
      return Container();
    }
  }

  Widget getPassengerCardList() {
    if (_carpoolRequestList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _carpoolRequestList.length,
        itemBuilder: (BuildContext context, int index) {
          getCarpoolRequestList();
          return TripPassengerRequestCard(carpoolRequest: _carpoolRequestList[index],passenger: _passengerList[index]);
        },
      );
    } else {
      return const Center(
        child: Text(
          'There are no passenger request.',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      );
    }
  }

  String get date => _date;
  String get time => _time;
  String get startLocation => _startLocation;
  String get destination => _destination;

  set date(String value) {
    _date = value;
  }

  set time(String value) {
    _time = value;
  }

  set destination(String value) {
    _destination = value;
  }

  set startLocation(String value) {
    _startLocation = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  List<CarpoolRequest> get carpoolRequestList => _carpoolRequestList;

  set carpoolRequestList(List<CarpoolRequest> value) {
    _carpoolRequestList = value;
  }

  double get listViewHeight => _listViewHeight;

  set listViewHeight(double value) {
    _listViewHeight = value;
  }

  double get singleListViewHeight => _singleListViewHeight;

  set singleListViewHeight(double value) {
    _singleListViewHeight = value;
  }

  List<CarpoolRequest> get acceptedCarpoolRequestList =>
      _acceptedCarpoolRequestList;

  set acceptedCarpoolRequestList(List<CarpoolRequest> value) {
    _acceptedCarpoolRequestList = value;
  }

  List<Users> get passengerList => _passengerList;

  set passengerList(List<Users> value) {
    _passengerList = value;
  }

  String get tripId => _tripId;

  set tripId(String value) {
    _tripId = value;
  }
}
