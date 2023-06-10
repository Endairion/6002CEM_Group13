import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';
import 'package:mobile_app_development_cw2/models/rewards_redemption_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class RedemptionHistoryViewModel extends BaseViewModel {
  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();
  List<RewardsRedemption> _redemptionList = [];

  List<RewardsRedemption> get redemptionList => _redemptionList;

  String _id = "";
  String _desc = "";
  String _discount = "";
  int _points = 0;
  int _remaining = 0;
  String _store = "";
  String _url = "";
  String _expiryDate = "";

  void onModelReady(){
    fetchUserRedemptionList();
  }

  void onModelDestroy(){
  }

  void fetchUserRedemptionList() async {
    _redemptionList = await _firebaseService.getUserRedemptionList(_firebaseService.userId);
    notifyListeners();
  }

  Future<void> getReward(String rewardId) async {
    Rewards rewards = await _firebaseService.getReward(rewardId);
    _id = rewards.id;
    _desc = rewards.desc;
    _discount = rewards.discount;
    _points = rewards.points;
    _remaining = rewards.remaining;
    _store = rewards.store;
    _url = rewards.url;
    notifyListeners();
  }

  String get url => _url;

  String get store => _store;

  int get remaining => _remaining;

  int get points => _points;

  String get discount => _discount;

  String get desc => _desc;

  String get id => _id;


  set url(String value) {
    _url = value;
  }

  set store(String value) {
    _store = value;
  }

  set remaining(int value) {
    _remaining = value;
  }

  set points(int value) {
    _points = value;
  }

  set discount(String value) {
    _discount = value;
  }

  set desc(String value) {
    _desc = value;
  }

  set id(String value) {
    _id = value;
  }

  set expiryDate(String value) {
    _expiryDate = value;
  }

}