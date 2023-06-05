import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class SearchAvailableTripsViewmodel extends BaseViewModel{
  String _startLocation = "";
  String _destination = "";
  String _driver = "";
  String _date = "";
  String _time = "";
  int _seats = 0;
  List<Trip> _tripsList = [];

  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(){
    getAvailableTripList();
  }

  void onModelDestroy(){
    _tripsList.clear();
  }

  Future<void> getAvailableTripList() async {
    _tripsList = await _firebaseService.getTripList();
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
}