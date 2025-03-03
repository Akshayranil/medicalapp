import 'package:flutter/material.dart';
import 'package:week7/glucosescreen/add_glucose.dart';
import 'package:week7/glucosescreen/glucose_trend.dart';

class GlucoseScreen extends StatelessWidget {
  const GlucoseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Blood Glucose'),
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(text: 'Add Blood Glucose',),
              Tab(text: 'View Trends',)
            ]),),
        body: TabBarView(children: [
          BloodGlucoseScreen(),
          GlucoseTrendScreen(),
        ]),  
      ),
    );
    
  }
}
