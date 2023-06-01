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

  void onModelDestroy() {}

  void fetchRewardsData() async {
    try {
      var snapshot = await _firebaseService.fetchRewardsData();
      _rewardsList.clear();
      for (var document in snapshot.docs) {
        _rewardsList.add(Rewards(
            desc: document['desc'],
            discount: document['discount'],
            points: document['points'],
            remaining: document['remaining'],
            store: document['store'],
            url: document['url']));
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
