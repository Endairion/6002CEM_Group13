import 'package:flutter/material.dart';

void main() {
  runApp(const PlanTrip());
}

class PlanTrip extends StatelessWidget {
  const PlanTrip({super.key});

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
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
