import 'package:flutter/material.dart';

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
  // Initial Selected Value
  String _dropDownValue = '1';
  // List of items in available seats menu
  final _seatValue = ['1', '2', '3', '4', '5', '6'];

  bool _pickupNotificationIsChecked = false;

  int _departureValue = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                    height: 600,
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
                            maxLines: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: TextField(
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
                              maxLines: 3,
                            ),
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
                                onChanged: (value) => setState(() => _departureValue = value!),
                              ),
                              MyRadioListTile<int>(
                                value: 2,
                                groupValue: _departureValue,
                                leading: 'Future',
                                onChanged: (value) => setState(() => _departureValue = value!),
                              ),
                            ],
                          ),
                          Text('data'),
                          Text('data'),
                          Text('data'),
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