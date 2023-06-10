import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_development_cw2/views/redemption_history_view.dart';
import 'package:mobile_app_development_cw2/viewmodels/rewards_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/my_rewards_card_view.dart';
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
                                          const RedemptionHistoryView()));
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
                        ListView.builder(
                            itemCount: _model.myRewardsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var myRewards = _model.myRewardsList[index];
                              return MyRewardsCardView(rewardsRedemption: myRewards,);
                            })

                        //   Card(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   elevation: 16,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(4.0),
                        //     child: ListTile(
                        //       title: Row(
                        //         children: [
                        //           Expanded(
                        //             flex: 2,
                        //             child: Column(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: [
                        //                 Text(
                        //                   "RM 10",
                        //                   textAlign: TextAlign.center,
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.bold,
                        //                       color: Colors.green[900],
                        //                       fontSize: 20),
                        //                 ),
                        //                 Text(
                        //                   "Min. spend RM 50",
                        //                   textAlign: TextAlign.center,
                        //                   style: TextStyle(
                        //                     color: Colors.green[900],
                        //                     fontSize: 10,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           Container(
                        //             height: 70,
                        //             child: VerticalDivider(
                        //               thickness: 1,
                        //               color: Colors.grey,
                        //             ),
                        //           ),
                        //           Expanded(
                        //             flex: 8,
                        //             child: Column(
                        //               children: [
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Image.network(
                        //                       "https://firebasestorage.googleapis.com/v0/b/vtumpang-carpooling-app.appspot.com/o/Rewards%2F1%2FUniqlo.png?alt=media&token=8275c661-6c9f-4663-ae5c-39c07934ab49",
                        //                       height: 40,
                        //                       width: 100,
                        //                       fit: BoxFit.contain,
                        //                     ),
                        //                     // Container(
                        //                     //     width: 100,
                        //                     //     height: 40,
                        //                     //     decoration: BoxDecoration(
                        //                     //       borderRadius:
                        //                     //           BorderRadius.circular(
                        //                     //               10),
                        //                     //       color: Colors.green[900],
                        //                     //     ),
                        //                     //     child: Center(
                        //                     //       child: Text(
                        //                     //         'Use',
                        //                     //         style: TextStyle(
                        //                     //           color: Colors.white,
                        //                     //           fontSize: 16,
                        //                     //           fontWeight:
                        //                     //               FontWeight.bold,
                        //                     //         ),
                        //                     //       ),
                        //                     //     )),
                        //                     ElevatedButton(
                        //                       style: ElevatedButton.styleFrom(
                        //                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        //                           backgroundColor: Colors.green[900],
                        //                           minimumSize: Size(100, 40)),
                        //                       onPressed: () {},
                        //                       child: Text('Use'),
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       'Uniqlo Malaysia',
                        //                       style: TextStyle(fontSize: 16),
                        //                     ),
                        //                     Text(
                        //                       'Expiry Date: 11/07/2023',
                        //                       style: TextStyle(fontSize: 12),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ],
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
