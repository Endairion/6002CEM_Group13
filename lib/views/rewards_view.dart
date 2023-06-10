import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_development_cw2/RedemptionHistory.dart';
import 'package:mobile_app_development_cw2/viewmodels/rewards_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/rewards_card_view.dart';

void main() {
  runApp(const RewardsView());
}

class RewardsView extends StatefulWidget {
  const RewardsView({Key? key}) : super(key: key);

  @override
  _RewardsViewState createState() => _RewardsViewState();
}

class _RewardsViewState extends State<RewardsView>
    with SingleTickerProviderStateMixin {
  late final RewardsViewModel _model;
  late final BuildContext _context;
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return BaseView<RewardsViewModel>(
        onModelReady: (model) {
          _model = model;
          _context = context;
          _tabController = TabController(length: 2, vsync: this);
          model.onModelReady();
        },
        onModelDestroy: (model) => model.onModelDestroy(),
        builder: (context, model, child) => Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.175, // Adjust the height as needed
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/rewards_bg.png'), // Replace with your image path
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 25.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 35,
                                  child: Icon(
                                    Icons.redeem,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Padding(
                                  padding: EdgeInsets.only(top: 33),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'My Points',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green[900],
                                        ),
                                      ),
                                      Text(
                                        _model.userPoints.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RedemptionHistory()));
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: CircleBorder(),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'View my redemption history',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(text: 'Rewards Catalogue'),
                      Tab(text: 'My Rewards'),
                    ],
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.green[
                              900]!, // Use the MaterialColor class with the index [900]
                          width: 2.0, // Border width
                        ),
                      ),
                      color: Colors.lightGreenAccent.withOpacity(0.2),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Rewards Catalogue Tab
                        _model.rewardsList.isEmpty
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                itemCount: _model.rewardsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var rewards = _model.rewardsList[index];
                                  return RewardsCardView(rewards: rewards);
                                }),

                        // My Rewards Tab
                        Center(
                          child: Text('My Rewards'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
