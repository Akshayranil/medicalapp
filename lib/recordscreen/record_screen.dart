import 'package:flutter/material.dart';
import 'package:week7/functions/general_functions.dart';

class MyRecords extends StatefulWidget {
  const MyRecords({super.key});

  @override
  State<MyRecords> createState() => _MyRecordsState();
}

class _MyRecordsState extends State<MyRecords> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Records'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      bottomNavigationBar: ButtonNavigation(
        currentIndex: _selectedIndex, 
        onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              NavigateScreen(context, index);
            } ),
    );
  }
}