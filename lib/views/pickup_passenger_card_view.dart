import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';

Widget PickupPassengerCardView(CarpoolRequest carpoolRequest) {
  return Column(
    children: [
      Container(
        width: double.infinity,
        height: 210,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4), // Border radius
                      child:
                          ClipOval(child: Image.asset('assets/app_logo.png')),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      carpoolRequest.requesterId,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              width: 2.0,
                              color: Colors.lightGreen,
                            ),
                            backgroundColor: Colors.white),
                        child: Row(
                          children: [
                            Icon(
                              Icons.done,
                              color: Colors.lightGreen,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Pickup',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.lightGreen,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 350,
                child: Text(
                  'Pickup Location: ' + carpoolRequest.pickupLocation,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 350,
                child: Text(
                  'Remarks: ' + carpoolRequest.remarks,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: 100,
                height: 30,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.amber,
                          size: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Report',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 16,
      ),
    ],
  );
}
