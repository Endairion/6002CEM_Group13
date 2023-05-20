import 'package:flutter/material.dart';

class RedemptionHistory extends StatelessWidget {
  const RedemptionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redemption History"),
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
