import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/PointsEarn.dart';
import 'package:mobile_app_development_cw2/locator.dart';
import 'package:mobile_app_development_cw2/models/earn_point_model.dart';
import 'package:mobile_app_development_cw2/models/trip_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/activity_page_viewmodel.dart';
import 'package:mobile_app_development_cw2/services/firebase_service.dart';


Widget PointsEarnCard(BuildContext context, EarnPoint earnPoint, Trip trip) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.limeAccent[700],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: Text(
                    "+" + earnPoint.points.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          'From: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 205,
                        child: Text(
                          trip.startLocation,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          'To: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 205,
                        child: Text(
                          trip.destination,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        'Date: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        trip.date,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Time: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        trip.time,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Role: ' + earnPoint.role,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 20.0,
            color: Colors.green,
          ),
        ],
      ),
    ),
  );
}