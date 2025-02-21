import 'package:flutter/material.dart';

class MyRecords extends StatelessWidget {
  const MyRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Records'),
        backgroundColor: Colors.lightGreenAccent,
      ),
    );
  }
}