import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class CarpoolDetailsViewModel extends BaseViewModel {
  String _date = "";
  String _time = "";
  String _startLocation = "";
  String _destination = "";
  String _pickupLocation = "";
  String _remarks = "";
  String _driverName = "";

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String requestId) {
    // get carpool request details based on requestId
    getCarpoolRequest(requestId);
  }

  void onModelDestroy() {}

  Future<void> getCarpoolRequest(String requestId) async {
    // get carpool request details based on requestId
    CarpoolRequest request =
        await _firebaseService.getCarpoolRequest(requestId);

    // set carpool request details text
    _pickupLocation = request.pickupLocation;
    _remarks = request.remarks;

    // get trip details based on tripId
    Trip trip = await _firebaseService.getTrip(request.tripId);

    // set trip details text
    _date = trip.date;
    _time = trip.time;
    _startLocation = trip.startLocation;
    _destination = trip.destination;

    // get driver details based on userId
    Users user = await _firebaseService.getUserData(request.driverId);

    // set driver details text
    _driverName = user.name;

    notifyListeners();
  }

  // getters
  String get destination => _destination;
  String get startLocation => _startLocation;
  String get time => _time;
  String get date => _date;
  String get pickupLocation => _pickupLocation;
  String get remarks => _remarks;
  String get driverName => _driverName;

  // setters
  set destination(String value) {
    _destination = value;
  }

  set startLocation(String value) {
    _startLocation = value;
  }

  set time(String value) {
    _time = value;
  }

  set date(String value) {
    _date = value;
  }

  set pickupLocation(String value) {
    _pickupLocation = value;
  }

  set remarks(String value) {
    _remarks = value;
  }

  set driverName(String value) {
    _driverName = value;
  }
}
