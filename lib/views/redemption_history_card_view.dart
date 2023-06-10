
import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';
import 'package:mobile_app_development_cw2/models/rewards_redemption_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/redemption_history_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

class RedemptionHistoryCardView extends StatelessWidget {
  RewardsRedemption redemptionHistory;
  RedemptionHistoryCardView({Key? key, required this.redemptionHistory}) : super(key: key);
  late final RedemptionHistoryViewModel _model;
  late final BuildContext _context;
  late Rewards _rewards;

  @override
  Widget build(BuildContext context) {
    return BaseView<RedemptionHistoryViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        _model.getReward(redemptionHistory.storeId);
        model.onModelReady();
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Card(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Text("-${_model.points.toString()}", style: TextStyle(fontSize: 24, color: Colors.grey[900]), textAlign: TextAlign.center,),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_model.store, style: TextStyle(fontSize: 20, color: Colors.grey[900]),),
                    Text("${_model.discount} (${_model.desc})", style: TextStyle(fontSize: 16, color: Colors.grey[700]),),
                    Text("Redemption Date: ${redemptionHistory.date}", style: TextStyle(fontSize: 16, color: Colors.grey[900]),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
