import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/viewmodels/redemption_history_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/redemption_history_card_view.dart';

class RedemptionHistoryView extends StatelessWidget {
  const RedemptionHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final RedemptionHistoryViewModel _model;
    late final BuildContext _context;

    return BaseView<RedemptionHistoryViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady();
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Redemption History"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          backgroundColor: Color.fromRGBO(155, 214, 17, 1),
        ),
        body: ListView.builder(
          itemCount: _model.redemptionList.length,
          itemBuilder: (BuildContext context, int index) {
            var redemptionList = _model.redemptionList[index];
            return RedemptionHistoryCardView(
              redemptionHistory: redemptionList,
            );
          },
        ),
      ),
    );
  }
}
