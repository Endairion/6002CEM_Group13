import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/viewmodels/homepage_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/custom_carpool_view.dart';
import 'package:mobile_app_development_cw2/views/plan_trip_view.dart';
import 'package:mobile_app_development_cw2/views/search_available_trips_view.dart';

void main() {
  runApp(const Homepage());
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final HomepageViewModel _model;
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BaseView<HomepageViewModel>(
        onModelReady: (model) {
          _model = model;
          _context = context;
          model.onModelReady();
        },
        onModelDestroy: (model) => model.onModelDestroy(),
        builder: (context, model, child) => Scaffold(
              body: Column(
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.limeAccent[700],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, bottom: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ' + _model.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
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
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Icon(
                                          Icons.redeem,
                                          size: 45,
                                          color: Colors.green[900],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'My Points',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.green[900],
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0, left: 46),
                                              child: Text(
                                                _model.points.toString(),
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
                                    child: _model.customRequestList.isEmpty
                                        ? Icon(
                                      Icons.notifications_outlined,
                                      //notifications_active_outlined
                                      size: 40,
                                      color: Colors.green[900],
                                    )
                                        : IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomCarpoolView()),
                                        );
                                      },
                                      icon: Icon(
                                        Icons
                                            .notifications_active_outlined,
                                        size: 40,
                                      ),
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
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 16),
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlanTripView()),
                              );
                            },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 8.0),
                            child: Text(
                              'I\'m a Passenger',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.lightGreen[900],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchAvailableTrips()),
                              );
                            },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Trips Nearby',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[850],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Image border
                            child: Image.asset(
                              'assets/trips_nearby.png',
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Tips & Tricks',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[850],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
