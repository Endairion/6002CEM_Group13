import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/utils/validators.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class OngoingTripDetailsViewModel extends BaseViewModel {

  String _startLocation = "";
  String _destination = "";

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(String tripId) {
    getTrip(tripId);
  }

  void onModelDestroy() {
  }

  Future<void> getTrip(String tripId) async {
    Trip trip = await _firebaseService.getTrip(tripId);

    _startLocation = trip.startLocation;
    _destination = trip.destination;

    notifyListeners();
  }

  // Getters
  String get startLocation => _startLocation;
  String get destination => _destination;

  // Setters
  set destination(String value) {
    _destination = value;
  }

  set startLocation(String value) {
    _startLocation = value;
  }
}
