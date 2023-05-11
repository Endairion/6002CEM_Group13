import 'package:flutter/material.dart';

void main() {
  runApp(const Rewards());
}

class Rewards extends StatelessWidget {
  const Rewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.limeAccent[700],
          title: Center(
            child: Text(
              'Rewards',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Text('data'));
  }
}
