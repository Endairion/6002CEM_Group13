import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'common/theme_helper.dart';

void main() {
  runApp(const PlanTrip());
}

class PlanTrip extends StatefulWidget {
  const PlanTrip({super.key});

  @override
  State<PlanTrip> createState() => _PlanTripState();
}

class _PlanTripState extends State<PlanTrip> {
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

  //future date picker
  DateTime selectedDate = DateTime.now();
  String selectedDateText = 'Set future date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDateText = DateFormat("dd-MM-yyyy").format(selectedDate);
      });
    }
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  var uuid = new Uuid();
  String _sessionToken = "";
  List<dynamic> _placeList = [];
  List<dynamic> _placeList2 = [];

  final _focus = FocusNode();
  final _focusDropdown = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      _onChanged();
    });
    _controller2.addListener(() {
      _onChanged2();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  _onChanged2() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion2(_controller2.text);
  }

  String getApiRequestUrl(String input) {
    String kPLACES_API_KEY = "AIzaSyA36o5GXvW4Kauogfmfgqnas7oBMzUqmkU";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&region=my&sessiontoken=$_sessionToken';
    return request;
  }

  void getSuggestion(String input) async {
    String request = getApiRequestUrl(input);
    http.Response response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  void getSuggestion2(String input) async {
    String request = getApiRequestUrl(input);
    http.Response response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList2 = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.lightGreen,
          title: Text(
            'Plan a trip',
            style: TextStyle(
              fontSize: 24,
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
                  padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
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
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Column(
                        children: [
                          TextField(
                            controller: _controller,
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
                            itemCount: _placeList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_placeList[index]["description"]),
                                onTap: () {
                                  setState(() {
                                    _controller.text =
                                        _placeList[index]["description"];
                                    _placeList.clear();
                                    _focus.requestFocus();
                                  });
                                },
                              );
                            },
                          ),
                          SizedBox(height: 12),
                          TextField(
                            focusNode: _focus,
                            controller: _controller2,
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
                            itemCount: _placeList2.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_placeList2[index]["description"]),
                                onTap: () {
                                  setState(() {
                                    _controller2.text =
                                        _placeList2[index]["description"];
                                    _placeList2.clear();
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
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
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
                                      _pickupNotificationIsChecked = value!;
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
                              padding: const EdgeInsets.only(top: 16, left: 8),
                              width: double.infinity,
                              child: Text('Departure Date & Time:')),
                          Row(
                            children: [
                              MyRadioListTile<int>(
                                value: 1,
                                groupValue: _departureValue,
                                leading: 'Now',
                                onChanged: (value) => setState(() {
                                  _departureValue = value!;
                                  _isFutureDateActive = false;
                                }),
                              ),
                              MyRadioListTile<int>(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: _isFutureDateActive ? () {
                                    _selectDate(context);
                                  } : null,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        selectedDateText,
                                        style: TextStyle(
                                          color: Colors.lightGreen[700],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 4),
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
                                    padding: const EdgeInsets.only(left: 4),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: _timeDropDownValue,
                                      items: _timeValue.map((String item) {
                                        return DropdownMenuItem(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                      onChanged: _isFutureDateActive
                                          ? (String? newValue) {
                                              setState(() {
                                                _timeDropDownValue = newValue!;
                                              });
                                            }
                                          : null,
                                      iconEnabledColor: Colors.lightGreen,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40.0),
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
                                              backgroundColor: Colors.red[700],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              )),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
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
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
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
      ),
    );
  }
}

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            _customRadioButton,
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green[900] : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Colors.green.shade900 : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600]!,
          fontSize: 16,
        ),
      ),
    );
  }
}
