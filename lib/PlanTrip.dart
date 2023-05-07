import 'package:flutter/material.dart';

void main() {
  runApp(const PlanTrip());
}

class PlanTrip extends StatelessWidget{
  const PlanTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
        body: Text('Plan Trip'),
      ),
    ));
  }

}