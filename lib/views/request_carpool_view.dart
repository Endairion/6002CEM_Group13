import 'package:flutter/material.dart';
import 'package:mobile_app_development_cw2/viewmodels/request_carpool_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/utils/theme_helper.dart';

class RequestCarpoolView extends StatefulWidget {
  String tripId;
  RequestCarpoolView({Key? key, required this.tripId}) : super(key: key);

  @override
  State<RequestCarpoolView> createState() => _RequestCarpoolViewState();
}

class _RequestCarpoolViewState extends State<RequestCarpoolView> {
  late final RequestCarpoolViewmodel _model;
  late final BuildContext _context;
  final _focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BaseView<RequestCarpoolViewmodel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady(widget.tripId);
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.lightGreen,
          title: Text(
            'Back to Search',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/vector_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 16),
                      child: Text(
                        'Request Carpool',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Container(
                      height: 1200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date: ' + _model.date,
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Time: ' + _model.time,
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Available Seats: ' + _model.seats.toString(),
                              style: TextStyle(fontSize: 14, color: Colors.red),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              'Route Details',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
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
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                      color: Colors.limeAccent[700],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                Expanded(
                                  flex: 10,
                                  child: Text(
                                    _model.startLocation,
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
                              height: 24,
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
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                      color: Colors.green[900],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                Expanded(
                                  flex: 10,
                                  child: Text(
                                    _model.destination,
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
                              height: 24,
                            ),
                            Text(
                              'Driver: ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: 180,
                              width: 390,
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: CircleAvatar(
                                            radius: 15,
                                            //  NetworkImage
                                            backgroundImage: _model.imageUrl.isNotEmpty ? Image.network(_model.imageUrl).image : Image.asset('assets/app_logo.png').image,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            _model.driver,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: SizedBox(
                                            height: 30,
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  backgroundColor:
                                                      Colors.limeAccent[700]),
                                              onPressed: () {},
                                              icon: Icon(Icons.call),
                                              label: Text(
                                                'Contact',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 32,
                                    ),
                                    Text('Car Model: ' + _model.carModel),
                                    SizedBox(
                                      height: 32,
                                    ),
                                    Text('Number Plate: '+ _model.licensePlate),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Text(
                              'Pickup Location: ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            TextField(
                              controller: _model.pickUpLocationController,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Enter your pickup location", ""),
                              cursorColor: Colors.lightGreen,
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _model.placeList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                      _model.placeList[index]["description"]),
                                  onTap: () {
                                    setState(() {
                                      _model.pickUpLocationController.text =
                                          model.placeList[index]["description"];
                                      model.placeList.clear();
                                      _focus.requestFocus();
                                    });
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Text(
                              'Remarks: ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            TextField(
                              controller: _model.remarksController,
                              minLines: 2,
                              maxLines: 3,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Write your remarks here...", ""),
                              cursorColor: Colors.lightGreen,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 300,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: Colors.limeAccent[700]),
                                onPressed: () {
                                  _model.createCarpoolRequest(context);
                                },
                                child: Text(
                                  'Request for carpool',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
