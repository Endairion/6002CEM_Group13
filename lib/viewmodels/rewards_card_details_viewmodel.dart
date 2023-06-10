import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_development_cw2/NavigationMenu.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';
import 'package:mobile_app_development_cw2/models/rewards_redemption_model.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';
import 'package:mobile_app_development_cw2/viewmodels/base_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/rewards_view.dart';
import 'package:uuid/uuid.dart';

class RewardsCardDetailsViewModel extends BaseViewModel {
  // Services
  final FirebaseService _firebaseService = locator<FirebaseService>();
  int _userPoints = 0;
  String _id = "";
  String _desc = "";
  String _discount = "";
  int _points = 0;
  int _remaining = 0;
  String _store = "";
  String _url = "";
  var uuid = new Uuid();

  void onModelReady(String id) {
    getReward(id);
    getUserPoints();
  }

  void onModelDestroy() {}

  void getUserPoints() async {
    _userPoints = (await _firebaseService.getUserPoints())!;
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

  Future<void> redeemRewards(BuildContext context) async {


    if (_userPoints >= _points) {
      showConfirmationDialog(context);
    } else {
      showErrorDialog(context);
    }
  }

  Future<bool> showErrorDialog(BuildContext context) async {
    bool? showError = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error Message'),
        content: Text('You don\'t have enough points to redeem this reward'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cancel logout
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );

    return showError ?? false;
  }

  Future<bool> showConfirmationDialog(BuildContext context) async {
    // Show the error message dialog
    bool? showSuccess = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rewards Redeem Confirmation'),
        content: Text("Are you sure you want to redeem this reward?"),
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
              createRedeemRewards();
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
        content: Text("Check it out in My Rewards tab"),
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

  Future<void> createRedeemRewards() async {
    String date = DateFormat("dd-MM-yyyy").format(DateTime.now());
    int difference = _userPoints - _points;

    RewardsRedemption rewardsRedeem = RewardsRedemption(
        redemptionId: uuid.v4().toString(),
        storeId: id,
        userId: _firebaseService.userId,
        date: date,
        status: 'Unused');

    await _firebaseService.createRedeemRewards(rewardsRedeem);
    await _firebaseService.updateUserPoints(difference);
    await _firebaseService.updateStoreStock(id, remaining-1);
  }



  int get userPoints => _userPoints;

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
}
