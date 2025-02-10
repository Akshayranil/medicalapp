import 'package:flutter/material.dart';

class MyMedicine extends StatelessWidget {
  const MyMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          title: Text('My Medicines'),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.green,
            tabs: [
              Tab(text: 'Medicine List' ,),
              Tab(text: 'Medicine Count',),
            ],
          ),
        ),
        body: Center(
         
        ),
      ),
    );
  }
}
