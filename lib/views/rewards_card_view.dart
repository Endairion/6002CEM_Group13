import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';
import 'package:mobile_app_development_cw2/views/rewards_card_details_view.dart';

class RewardsCardView extends StatelessWidget {
  final Rewards rewards;

  const RewardsCardView({Key? key, required this.rewards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RewardsCardDetailsView(reward: rewards,)),
        );
      },
      child: Card(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        rewards.discount,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                            fontSize: 20),
                      ),
                      Text(
                        rewards.desc,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            rewards.url,
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
                                  rewards.points.toString() + ' points',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            rewards.store,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Remaining: ' + rewards.remaining.toString(),
                            style: TextStyle(fontSize: 12),
                          )
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
