import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_development_cw2/viewmodels/create_custom_trip_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:mobile_app_development_cw2/views/custom_radio_list_tile.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mobile_app_development_cw2/common/theme_helper.dart';

void main() {
  runApp(const CreateCustomTripView());
}

class CreateCustomTripView extends StatefulWidget {
  const CreateCustomTripView({super.key});

  @override
  State<CreateCustomTripView> createState() => _CreateCustomTripViewState();
}

class _CreateCustomTripViewState extends State<CreateCustomTripView> {

  final _focus = FocusNode();
  final _focusDropdown = FocusNode();
  late final CreateCustomTripViewmodel _model;
  late final BuildContext _context;


  @override
  Widget build(BuildContext context) {
    return BaseView<CreateCustomTripViewmodel>(
        onModelReady: (model) {
      _model = model;
      _context = context;
      model.onModelReady();
    },
    onModelDestroy: (model) => model.onModelDestroy(),
    builder: (context, model, child) =>MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.lightGreen,
          title: Text(
            'Back To Search',
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 16),
                  child: Text(
                    'Create a custom request',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                  height: 460,
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
                        TextField(
                          controller: _model.startLocationController,
                          onTap: () {},
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.lightGreen,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 16),
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(),
                              hintText: 'Enter your starting location',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.my_location,
                                  color: Colors.grey[400],
                                ),
                                onPressed: () {
                                  print('Pressed my location');
                                },
                              )),
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          minLines: 1,
                          maxLines: 1,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _model.placeList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_model.placeList[index]["description"]),
                              onTap: () {
                                setState(() {
                                  _model.startLocationController.text =
                                      model.placeList[index]["description"];
                                  model.placeList.clear();
                                  _focus.requestFocus();
                                });
                              },
                            );
                          },
                        ),
                        SizedBox(height: 12),
                        TextField(
                          focusNode: _focus,
                          controller: _model.destinationController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.lightGreen,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 16),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(),
                            hintText: 'Enter your destination location',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          minLines: 1,
                          maxLines: 1,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model.placeList2.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(model.placeList2[index]["description"]),
                              onTap: () {
                                setState(() {
                                  _model.destinationController.text =
                                      model.placeList2[index]["description"];
                                  _model.placeList2.clear();
                                  _focusDropdown.requestFocus();
                                });
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Time: ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 150,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.green[900],
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.green.shade900,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextField(
                          onTap: () {},
                          controller: _model.remarksController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.lightGreen,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(),
                            hintText: 'Remarks',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          minLines: 7,
                          maxLines: 7,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Note:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'The request will auto expire in 30 minutes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(130, 40),
                                        backgroundColor: Colors.red[700],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _model.planTrip(context);
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(130, 40),
                                        backgroundColor: Colors.lightGreen,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
