import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class TripDetailsViewModel extends BaseViewModel {

  String _date = "";
  String _time = "";
  String _startLocation = "";
  String _destination = "";
  String _status = "";

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String tripId) {
    getTrip(tripId);
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
}
