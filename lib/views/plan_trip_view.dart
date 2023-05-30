import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_development_cw2/TripDetails.dart';
import 'package:mobile_app_development_cw2/models/custom_radio_list_tile.dart';
import 'package:mobile_app_development_cw2/viewmodels/plan_trip_viewmodel.dart';
import 'package:mobile_app_development_cw2/views/base_view.dart';
import 'package:intl/intl.dart';
import '../common/theme_helper.dart';

void main() {
  runApp(PlanTripView());
}

class PlanTripView extends StatefulWidget {
  PlanTripView({super.key});

  @override
  State<PlanTripView> createState() => _PlanTripViewState();
}

class _PlanTripViewState extends State<PlanTripView> {
  late final PlanTripViewModel _model;
  late final BuildContext _context;

  // Set Initial Selected Value
  String _dropDownValue = '1';

  // List of items in available seats menu
  final _seatValue = ['1', '2', '3', '4', '5', '6'];

  bool _pickupNotificationIsChecked = false;
  int _departureValue = 1;
  bool _isFutureDateActive = false;

  // Set Initial Selected Value for future time
  String _timeDropDownValue = 'Select future time';

  // List of items in available seats menu
  final _timeValue = [
    'Select future time',
    '5:00 am',
    '6:00 am',
    '7:00 am',
    '8:00 am',
    '9:00am',
    '10:00 am',
    '11:00am',
    '12:00 pm',
    '1:00 pm',
    '2:00 pm',
    '3:00 pm',
    '4:00 pm',
    '5:00 pm',
    '6:00 pm',
    '7:00 pm',
    '8:00 pm',
    '9:00 pm',
    '10:00 pm',
    '11:00 pm',
    '12:00 am'
  ];

  final _focus = FocusNode();
  final _focusDropdown = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BaseView<PlanTripViewModel>(
        onModelReady: (model) {
          _model = model;
          _context = context;
          model.onModelReady();
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
                  'Plan a trip',
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
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 32, left: 32, right: 32),
                        child: Container(
                          height: 520,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: Column(
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
                                      title: Text(_model.placeList[index]
                                          ["description"]),
                                      onTap: () {
                                        setState(() {
                                          _model.startLocationController.text =
                                              _model.placeList[index]
                                                  ["description"];
                                          _model.placeList.clear();
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
                                  itemCount: _model.placeList2.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(_model.placeList2[index]
                                          ["description"]),
                                      onTap: () {
                                        setState(() {
                                          _model.destinationController.text =
                                              _model.placeList2[index]
                                                  ["description"];
                                          _model.placeList2.clear();
                                          _focusDropdown.requestFocus();
                                        });
                                      },
                                    );
                                  },
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Text('Available seat: '),
                                      ),
                                      Container(
                                        width: 60,
                                        child: DropdownButton(
                                          focusNode: _focusDropdown,
                                          isExpanded: true,
                                          value: _dropDownValue,
                                          items: _seatValue.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _dropDownValue = newValue!;
                                            });
                                          },
                                          iconEnabledColor: Colors.lightGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: Colors.green[900],
                                        value: _pickupNotificationIsChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _pickupNotificationIsChecked =
                                                value!;
                                          });
                                        }),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                          'Enable pickup recommendation \nnotification'),
                                    ),
                                  ],
                                ),
                                Container(
                                    padding:
                                        const EdgeInsets.only(top: 16, left: 8),
                                    width: double.infinity,
                                    child: Text('Departure Date & Time:')),
                                Row(
                                  children: [
                                    CustomRadioListTile<int>(
                                      value: 1,
                                      groupValue: _departureValue,
                                      leading: 'Now',
                                      onChanged: (value) => setState(() {
                                        _departureValue = value!;
                                        _isFutureDateActive = false;
                                      }),
                                    ),
                                    CustomRadioListTile<int>(
                                      value: 2,
                                      groupValue: _departureValue,
                                      leading: 'Future',
                                      onChanged: (value) => setState(() {
                                        _departureValue = value!;
                                        _isFutureDateActive = true;
                                      }),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: _isFutureDateActive
                                            ? () {
                                                _model.selectDate(context);
                                              }
                                            : null,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              model.selectedDateText,
                                              style: TextStyle(
                                                color: Colors.lightGreen[700],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4),
                                              child: Icon(
                                                Icons.calendar_month,
                                                color: Colors.lightGreen[700],
                                              ),
                                            )
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: const BorderSide(
                                            width: 2.0,
                                            color: Colors.lightGreen,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 180,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: DropdownButton(
                                            isExpanded: true,
                                            value: _timeDropDownValue,
                                            items:
                                                _timeValue.map((String item) {
                                              return DropdownMenuItem(
                                                value: item,
                                                child: Text(item),
                                              );
                                            }).toList(),
                                            onChanged: _isFutureDateActive
                                                ? (String? newValue) {
                                                    setState(() {
                                                      _timeDropDownValue =
                                                          newValue!;
                                                    });
                                                  }
                                                : null,
                                            iconEnabledColor: Colors.lightGreen,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 40.0),
                                        child: Container(
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
                                                    minimumSize: Size(140, 40),
                                                    backgroundColor:
                                                        Colors.red[700],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    )),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const TripDetails()),
                                                  );
                                                },
                                                child: Text(
                                                  'Go',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    minimumSize: Size(140, 40),
                                                    backgroundColor:
                                                        Colors.lightGreen,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ));
  }
}
