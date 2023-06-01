import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/rewards_model.dart';

class RewardsCardView extends StatelessWidget {
  final Rewards rewards;

  const RewardsCardView({Key? key, required this.rewards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[900],
                                minimumSize: Size(100, 40)),
                            onPressed: () {},
                            child: Text(rewards.points + 'points')),
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
                          'Remaining: ' + rewards.remaining,
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
    );
  }
}
