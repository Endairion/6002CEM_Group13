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

  void onModelReady() {
    fetchRewardsData();
  }

  void onModelDestroy() {
    _rewardsList.clear();
  }

  void fetchRewardsData() async {
    _rewardsList = await _firebaseService.getRewardsLists();
    notifyListeners();
  }
}
