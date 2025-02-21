import 'package:flutter/material.dart';
import 'package:week7/vitalsscreen/add_vitals.dart';
import 'package:week7/vitalsscreen/vitals_trends.dart';

class MyVitals extends StatefulWidget {
  const MyVitals({super.key});

  @override
  State<MyVitals> createState() => _MyVitalsState();
}

class _MyVitalsState extends State<MyVitals> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Vitals'),
          backgroundColor: Colors.lightGreenAccent,
          bottom: TabBar(indicatorColor: Colors.black,
            tabs: [
              Tab(
                text: 'Add Vitals',
              ),
              Tab(text: 'View Trends',)
            ]),
        ),
        body: TabBarView(children: [
          AddVitals(),
          ViewTrends(),
        ]),
      ),
    );
  }
}