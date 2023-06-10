import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';
import 'package:mobile_app_development_cw2/models/rewards_redemption_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/my_rewards_viewmodel.dart';
import 'package:mobile_app_development_cw2/viewmodels/rewards_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

class MyRewardsCardView extends StatelessWidget {
  RewardsRedemption rewardsRedemption;
  MyRewardsCardView({Key? key, required this.rewardsRedemption}) : super(key: key);

  late final MyRewardsViewModel _model;
  late final BuildContext _context;
  late Rewards _rewards;

  @override
  Widget build(BuildContext context) {
    return BaseView<MyRewardsViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        _model.getReward(rewardsRedemption.storeId);
        _model.getExpiryDate(rewardsRedemption.date);
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        _model.discount,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                            fontSize: 20),
                      ),
                      Text(
                        _model.desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  child: VerticalDivider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            _model.url,
                            height: 40,
                            width: 100,
                            fit: BoxFit.contain,
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.green[900],
                                minimumSize: Size(100, 40)),
                            onPressed: () {
                              _model.redeemRewards(context,rewardsRedemption.redemptionId);
                            },
                            child: Text('Use'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _model.store,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Expired:' + _model.expiryDate,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
