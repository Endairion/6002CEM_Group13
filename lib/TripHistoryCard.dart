import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/views/trip_details_view.dart';

Widget TripHistoryCard(BuildContext context, List<Trip> trip, int index) {
  String startLocation;
  String destination;

  if (trip[index].startLocation.length > 35) {
    startLocation = trip[index].startLocation.substring(0, 35);
  } else {
    startLocation = trip[index].startLocation;
  }

  if (trip[index].destination.length > 35) {
    destination = trip[index].destination.substring(0, 35);
  } else {
    destination = trip[index].destination;
  }

  statusColor(String status) {
    switch (status) {
      case 'Ongoing':
        return Colors.lightGreen;
      case 'Completed':
        return Colors.yellow[800];
      case 'Expired':
        return Colors.red[300];
    }
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const TripDetails()),
        );
      },
      child: Container(
        height: 125,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(30.0),
                            color: Colors.limeAccent[700],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'S',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        startLocation,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(30.0),
                            color: Colors.green[900],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'D',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        destination,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Date: ' + trip[index].date,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Time: ' + trip[index].time,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Status: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                        width: 100,
                        height: 24,
                        decoration: BoxDecoration(
                            color: statusColor(trip[index].status),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                            child: Text(
                          trip[index].status,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.navigate_next,
                size: 45,
                color: Colors.green[900],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
