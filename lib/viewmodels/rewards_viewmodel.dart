import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';

class RewardsViewModel extends BaseViewModel {
  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();
  List<Rewards> _rewardsList = [];
  List<Rewards> get rewardsList => _rewardsList;
  int _userPoints = 0;

  void onModelReady() {
    fetchRewardsData();
    // getUserPoints();
  }

  void onModelDestroy() {
    _rewardsList.clear();
  }

  void fetchRewardsData() async {
    _rewardsList = await _firebaseService.getRewardsLists();
    print("get user points");
    _userPoints = (await _firebaseService.getUserPoints())!;
    print("Viewmodel " + _userPoints.toString());
    notifyListeners();
  }

  // void getUserPoints() async{
  //   print("get user points");
  //   _userPoints = await _firebaseService.getUserPoints();
  //   print("Viewmodel " + _userPoints);
  //   notifyListeners();
  // }

  int get userPoints => _userPoints;
}
