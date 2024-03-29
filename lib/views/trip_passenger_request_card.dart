import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/models/carpool_request_model.dart';
import 'package:mobile_app_development_cw2/models/user_model.dart';
import 'package:mobile_app_development_cw2/viewmodels/trip_passenger_request_view_model.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

class TripPassengerRequestCard extends StatefulWidget {
  // BuildContext context;
  final CarpoolRequest carpoolRequest;
  final Users passenger;
  // final int index;
  TripPassengerRequestCard(
      {Key? key, required this.carpoolRequest, required this.passenger})
      : super(key: key);

  @override
  State<TripPassengerRequestCard> createState() =>
      _TripPassengerRequestCardState();
}

class _TripPassengerRequestCardState extends State<TripPassengerRequestCard> {
  late final TripPassengerRequestViewModel _model;
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BaseView<TripPassengerRequestViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady(
            widget.carpoolRequest.requestId, widget.carpoolRequest.tripId);
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: widget.passenger.url.isNotEmpty ? Image.network(widget.passenger.url).image : Image.asset('assets/app_logo.png').image,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        width: 150,
                        child: Text(
                          widget.passenger.name,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.lightGreen, width: 2),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.done,
                            color: Colors.lightGreen,
                          ),
                          onPressed: () {
                            _model.acceptRequestClicked(context);
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Container(
                        width: 50,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.red.shade400, width: 2),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _model.rejectRequestClicked(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          'Pickup Location: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 215,
                        child: Text(
                          widget.carpoolRequest.pickupLocation,
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
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}