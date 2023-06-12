import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/custom_request_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class CustomCarpoolViewmodel extends BaseViewModel{
  List<CustomRequest> _customRequestList = [];

  List<CustomRequest> get customRequestList => _customRequestList;

  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  void onModelReady(){
    getCustomCarpoolRequest();
  }

  void onModelDestroy(){
    _customRequestList.clear();
  }

  Future<void> getCustomCarpoolRequest() async {
    _customRequestList = await _firebaseService
        .getCustomCarpoolRequestList(_firebaseService.userId);
    notifyListeners();
  }

  Future<void> acceptCustomRequest(String id) async {
    await _firebaseService.updateCustomCarpoolRequestStatus(id);

  }



}