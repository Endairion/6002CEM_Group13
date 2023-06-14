import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/available_trips_card_view.dart';

class SearchAvailableTripsViewModel extends BaseViewModel {
  late final TextEditingController _startLocationController;
  late final TextEditingController _destinationController;
  String _startLocation = "";
  String _destination = "";
  String _driver = "";
  String _date = "";
  String _time = "";
  int _seats = 0;
  List<Trip> _availableTripsList = [];
  List<String> _tripIdList = [];
  double _singleListViewHeight = 135;
  double _listViewHeight = 400;

  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady() {
    _startLocationController = TextEditingController();
    _destinationController = TextEditingController();
    getAvailableTripList();
  }

  void onModelDestroy() {
    _startLocationController.dispose();
    _destinationController.dispose();
    _availableTripsList.clear();
  }

  Future<void> getAvailableTripList() async {
    _availableTripsList = await _firebaseService.getAvailableTripList();

    if (_availableTripsList.length * _singleListViewHeight > 400) {
        _listViewHeight = _availableTripsList.length * _singleListViewHeight;
      }
    notifyListeners();
  }

  Widget getAvailableTripListSizedBox() {
    return SizedBox(
      height: _listViewHeight,
      child: getAvailableTripListCard(),
    );
  }

  Widget getAvailableTripListCard() {
    if (_availableTripsList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _availableTripsList.length,
        itemBuilder: (BuildContext context, int index) {
          return AvailableTripsCardView(context, _availableTripsList, index);
        },
      );
    } else {
      return const Center(
        child: Text(
          'There are no trips available.',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      );
    }
  }

  Future <void> getSearchResultTripsList(TextEditingController startLocationController, TextEditingController destinationController) async{
    _availableTripsList.clear();
    print("Current input is " + startLocationController.text);
    _tripIdList = await _firebaseService.compareAvailableTripsLocation(startLocationController.text, destinationController.text);
    print("List content : " + _tripIdList.toString());
    if (_tripIdList.isNotEmpty) {
      _availableTripsList =
      await _firebaseService.retrieveTripListsbyId(_tripIdList);
      print(_availableTripsList.toList());
      if (_availableTripsList.length * _singleListViewHeight > 400) {
        _listViewHeight = _availableTripsList.length * _singleListViewHeight;
      }
      getAvailableTripListSizedBox();
      notifyListeners();
    }else{
      notifyListeners();
    }
  }




  // Getter
  TextEditingController get startLocationController =>
      _startLocationController;

  TextEditingController get destinationController => _destinationController;

  int get seats => _seats;

  String get time => _time;

  String get date => _date;

  String get driver => _driver;

  String get destination => _destination;

  String get startLocation => _startLocation;

  List<Trip> get availableTripsList => _availableTripsList;

  double get listViewHeight => _listViewHeight;

  // Setter
  set startLocationController(TextEditingController value) {
    _startLocationController = value;
  }

  set destinationController(TextEditingController value) {
    _destinationController = value;
  }

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

  set availableTripsList(List<Trip> value) {
    _availableTripsList = value;
  }

  set listViewHeight(double value) {
    _listViewHeight = value;
  }


}
