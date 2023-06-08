import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';

class PickupPassengerCardView extends StatefulWidget {
  CarpoolRequest carpoolRequest;
  Users user;
  PickupPassengerCardView({Key? key, required this.carpoolRequest, required this.user}) : super(key: key);

  @override
  State<PickupPassengerCardView> createState() => _PickupPassengerCardViewState();
}

class _PickupPassengerCardViewState extends State<PickupPassengerCardView> {

  bool _pickupButtonDisable = false;

  @override
  Widget build(BuildContext context) {
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
                      width: 135,
                      child: Text(
                        widget.user.name,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      width: 123,
                      child: ElevatedButton(
                          onPressed: () {
                            _pickupButtonDisable = true;
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _pickupButtonDisable
                                  ? Colors.grey[400]
                                  : Colors.lightGreen,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _pickupButtonDisable
                                  ? Icons.done
                                  : Icons.directions_car,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                width: 63,
                                child: Center(
                                  child: Text(
                                    _pickupButtonDisable
                                        ? "Done"
                                        : "To Pickup",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
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
                    'Pickup Location: ' + widget.carpoolRequest.pickupLocation,
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
                    'Remarks: ' + widget.carpoolRequest.remarks,
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
}