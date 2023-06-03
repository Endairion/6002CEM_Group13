import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/views/ongoing_trip_details_view.dart';
import 'package:mobile_app_development_cw2/viewmodels/trip_details_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';

class TripDetails extends StatefulWidget {
  String tripId;
  TripDetails({Key? key, required this.tripId}) : super(key: key);

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late final TripDetailsViewModel _model;
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BaseView<TripDetailsViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady(widget.tripId);
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.lightGreen,
          toolbarHeight: 65,
          title: Text(
            'Trip Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            width: size.width,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OngoingTripDetails(tripId: widget.tripId)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.limeAccent[700],
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text('Start Trip'),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ' + _model.date,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Time: ' + _model.time,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.limeAccent[700],
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.edit),
                              SizedBox(
                                width: 4,
                              ),
                              Text('Edit Details'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Route Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.limeAccent.shade700,
                            ),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          _model.startLocation,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16,
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
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: new BorderRadius.circular(30.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          'Address aksjdhkasd asjhd kajsdh asdhja sdkjashd kajsdh akjsdhaks dhkajs',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
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
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green.shade900,
                            ),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          _model.destination,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Passengers:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
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
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(4), // Border radius
                                  child: ClipOval(
                                      child:
                                          Image.asset('assets/app_logo.png')),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  'Elizabeth Tan',
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
                                  border: Border.all(
                                      color: Colors.lightGreen, width: 2),
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
                                    print('Pressed Accept');
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.red.shade400, width: 2),
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
                                    print('Pressed Decline');
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
                                width: 240,
                                child: Text(
                                  'addressa sdasdjasd ashgdjasdjas dasdj alsdkjalsk djakd jslajsdl ajsdlkja lksd jlkaj dklajskdl',
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
                          Text(
                            'Remarks: addressa sdasdjasd ashgdjasdjas dasdj alsdkjalsk djakd jslajsdl ajsdlkja lksd jlkaj dklajskdl',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
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
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(4), // Border radius
                                  child: ClipOval(
                                      child:
                                      Image.asset('assets/app_logo.png')),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  'Elizabeth Tan',
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
                                  border: Border.all(
                                      color: Colors.lightGreen, width: 2),
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
                                    print('Pressed Accept');
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.red.shade400, width: 2),
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
                                    print('Pressed Decline');
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
                                width: 240,
                                child: Text(
                                  'addressa sdasdjasd ashgdjasdjas dasdj alsdkjalsk djakd jslajsdl ajsdlkja lksd jlkaj dklajskdl',
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
                          Text(
                            'Remarks: addressa sdasdjasd ashgdjasdjas dasdj alsdkjalsk djakd jslajsdl ajsdlkja lksd jlkaj dklajskdl',
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
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
            ),
          ),
        ),
      ),
    );
  }
}
