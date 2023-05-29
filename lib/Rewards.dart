import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/RedemptionHistory.dart';

void main() {
  runApp(const Rewards());
}

class Rewards extends StatefulWidget {
  const Rewards({Key? key}) : super(key: key);

  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.175, // Adjust the height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/rewards_bg.png'), // Replace with your image path
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 25.0),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                '1570',
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
                          MaterialPageRoute(builder: (context) => const RedemptionHistory())
                      );
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
                  color: Colors.green[900]!, // Use the MaterialColor class with the index [900]
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
                Center(
                  child: Text('Rewards Catalogue'),
                ),
                // My Rewards Tab
                Center(
                  child: Text('My Rewards'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
