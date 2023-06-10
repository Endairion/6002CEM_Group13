import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_development_cw2/NavigationMenu.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';
import 'package:mobile_app_development_cw2/models/rewards_redemption_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';

class MyRewardsViewModel extends BaseViewModel {
  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();
  List<RewardsRedemption> _myRewardsList = [];
  List<RewardsRedemption> get myRewardsList => _myRewardsList;
  int _userPoints = 0;
  String _id = "";
  String _desc = "";
  String _discount = "";
  int _points = 0;
  int _remaining = 0;
  String _store = "";
  String _url = "";
  String _expiryDate = "";

  void onModelReady() {
    fetchRewardsData();
  }

  void onModelDestroy(){
    _myRewardsList.clear();
  }


  void fetchRewardsData() async {
    _myRewardsList = await _firebaseService.getMyRewardsList(_firebaseService.userId);
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

  String get expiryDate => _expiryDate;

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

  set userPoints(int value) {
    _userPoints = value;
  }

  set expiryDate(String value) {
    _expiryDate = value;
  }

  void getExpiryDate(String date) {
    // Parse the given date string to DateTime object
    DateTime initialDate = DateFormat('dd-MM-yyyy').parse(date);

    // Add 1 month to the initial date
    DateTime expired = DateTime(initialDate.year, initialDate.month + 1, initialDate.day);

    // Format the expiry date to the desired format
    _expiryDate = DateFormat('dd-MM-yyyy').format(expired);

  }

  Future<void> redeemRewards(BuildContext context, String redemptionId) async {
    showConfirmationDialog(context, redemptionId);
  }

  Future<bool> showConfirmationDialog(BuildContext context, String redemptionId) async {
    // Show the error message dialog
    bool? showSuccess = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rewards Redeem Confirmation'),
        content: Text("Are you sure you want to use it now?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cancel logout
              updateRedemptionStatus(redemptionId);
              showSuccessDialog(context);
            },
            child: Text('Redeem'),
          ),
        ],
      ),
    );
    return showSuccess ?? false; // Return false if the dialog is dismissed
  }

  Future<bool> showSuccessDialog(BuildContext context) async {

    // Show the error message dialog
    bool? showSuccess = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Redeemed Rewards Successfully'),
        content: Text("Check it out in Rewards Redemption History"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => NavigationMenu()));
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
    return showSuccess ?? false; // Return false if the dialog is dismissed
  }

  Future<void> updateRedemptionStatus(String redemptionId) async{
    await _firebaseService.updateRewardsRedemptionStatus(redemptionId);
    notifyListeners();
  }
}