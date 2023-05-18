import 'package:flutter/material.dart';

class DriverVerification extends StatelessWidget {
  const DriverVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Verification"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        backgroundColor: Color.fromRGBO(155, 214, 17, 1),
      ),
    );
  }
}
