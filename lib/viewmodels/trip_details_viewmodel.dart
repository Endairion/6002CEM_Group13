import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
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
    // set tripId
    _tripId = tripId;
    // get trip details
    getTrip(tripId);
    // get pickup location address list
    getPickupLocationList();
    // get passenger carpool request
    getCarpoolRequestList();
  }

  void onModelDestroy() {}

  Future<void> getTrip(String tripId) async {
    // get trip details based on tripId
    Trip trip = await _firebaseService.getTrip(tripId);

    // set trip details text
    _date = trip.date;
    _time = trip.time;
    _startLocation = trip.startLocation;
    _destination = trip.destination;
    _status = trip.status;

    notifyListeners();
  }

  Future<void> getCarpoolRequestList() async {
    // get passenger carpool request list based on tripId
    _carpoolRequestList = await _firebaseService.getCarpoolRequestList(_tripId);

    // update list view height
    setListHeight();

    for (var i = 0; i < _carpoolRequestList.length; i++) {
      // get user data for each carpool request
      Users user = await _firebaseService
          .getUserData(_carpoolRequestList[i].requesterId);
      _passengerList.add(user);
    }

    notifyListeners();
  }

  void setListHeight() async {
    // calculate the list view height based on carpool request list item count
    if (_singleListViewHeight * _carpoolRequestList.length > _listViewHeight) {
      _listViewHeight = _singleListViewHeight * _carpoolRequestList.length;
    }
    notifyListeners();
  }

  Future<void> getPickupLocationList() async {
    // get accepted carpool request
    _acceptedCarpoolRequestList =
        await _firebaseService.getAcceptedCarpoolRequestList(_tripId);
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
          getPickupLocationList();
          return PickupAddressCardView(
              _acceptedCarpoolRequestList[index], index);
        },
      );
    } else {
      return Container();
    }
  }

  Widget getPassengerCardList() {
    // display passenger carpool request card list
    if (_carpoolRequestList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _carpoolRequestList.length,
        itemBuilder: (BuildContext context, int index) {
          getCarpoolRequestList();
          return TripPassengerRequestCard(
              carpoolRequest: _carpoolRequestList[index],
              passenger: _passengerList[index]);
        },
      );
    } else {
      // display empty message
      return const Center(
        child: Text(
          'There are no new passenger request.',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      );
    }
  }

  // getters
  String get date => _date;
  String get time => _time;
  String get startLocation => _startLocation;
  String get destination => _destination;
  String get status => _status;
  List<CarpoolRequest> get carpoolRequestList => _carpoolRequestList;
  double get listViewHeight => _listViewHeight;
  double get singleListViewHeight => _singleListViewHeight;
  List<CarpoolRequest> get acceptedCarpoolRequestList =>
      _acceptedCarpoolRequestList;
  List<Users> get passengerList => _passengerList;
  String get tripId => _tripId;

  // setters
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

  set status(String value) {
    _status = value;
  }

  set carpoolRequestList(List<CarpoolRequest> value) {
    _carpoolRequestList = value;
  }

  set listViewHeight(double value) {
    _listViewHeight = value;
  }

  set singleListViewHeight(double value) {
    _singleListViewHeight = value;
  }

  set acceptedCarpoolRequestList(List<CarpoolRequest> value) {
    _acceptedCarpoolRequestList = value;
  }

  set passengerList(List<Users> value) {
    _passengerList = value;
  }

  set tripId(String value) {
    _tripId = value;
  }
}
