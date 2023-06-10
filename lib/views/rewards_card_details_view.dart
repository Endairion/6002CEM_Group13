import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/rewards_card_details_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

class RewardsCardDetailsView extends StatefulWidget {
  Rewards reward;
  RewardsCardDetailsView({Key? key, required this.reward}) : super(key: key);

  @override
  State<RewardsCardDetailsView> createState() => _RewardsCardDetailsViewState();
}

class _RewardsCardDetailsViewState extends State<RewardsCardDetailsView> {
  late final RewardsCardDetailsViewModel _model;
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BaseView<RewardsCardDetailsViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady(widget.reward.id);
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.lightGreen,
            title: Text(
              'Back To Search',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/vector_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 460,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 32, left: 32, right: 32),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                _model.url,
                                height: 40,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                              Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green[900],
                                ),
                                child: Center(
                                  child: Text(
                                    _model.points.toString() + ' points',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                _model.store,
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _model.discount +
                                    " (" +
                                    _model.desc +
                                    ")",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Remaining: ' + _model.remaining.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green[900],
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Text(
                                "Terms & Condition:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "1. ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(" "),
                                    ],
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      "Points are deducted upon redemption.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "2. ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(" "),
                                    ],
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      "Redemption cannot be canceled, and points are non-refundable.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "3. ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(" "),
                                    ],
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      "The rewards will expired after one month.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _model.redeemRewards(context);
                            },
                            child: Text(
                              "Redeem",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(240, 40),
                                backgroundColor: Colors.limeAccent[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
