import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'common/theme_helper.dart';

void main() {
  runApp(const CreateCustomTrip());
}

class CreateCustomTrip extends StatefulWidget {
  const CreateCustomTrip({super.key});

  @override
  State<CreateCustomTrip> createState() => _CreateCustomTripState();
}

class _CreateCustomTripState extends State<CreateCustomTrip> {

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
              padding: const EdgeInsets.fromLTRB(32,32,32,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8, bottom: 16),
                    child: Text('Create a custom request',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),),
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
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 8,),
                              Text('Time: ',
                              style: TextStyle(
                                fontSize: 16,
                              ),),
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
                                ),),
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
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text('Note:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontStyle: FontStyle.italic,
                            ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text('The request will auto expire in 30 minutes',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                              ),),
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
                                      onPressed: () {},
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(130, 40),
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
