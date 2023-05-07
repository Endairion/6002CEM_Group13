import 'package:flutter/material.dart';

void main() {
  runApp(const Homepage());
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            color: Colors.limeAccent[700],
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ' + 'User',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          height: 60,
                          width: 180,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Icon(
                                  Icons.redeem,
                                  size: 45,
                                  color: Colors.green[900],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'My Points',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[900],
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0, left: 46),
                                      child: Text(
                                        '1570',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.notifications_outlined,
                              size: 40,
                              color: Colors.green[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'I\'m a Driver',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.lightGreen[900],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.green.shade900,
                            Colors.lightGreen.shade700
                          ]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Plan a trip',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Start the carpool journey',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.lightGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 45,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                    child: Text(
                      'I\'m a Passenger',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.lightGreen[900],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.green.shade900,
                            Colors.lightGreen.shade700
                          ]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Search for available trips',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Join the carpool journey',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.lightGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 45,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
