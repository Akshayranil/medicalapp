import 'package:flutter/material.dart';
import 'package:week7/screens/bmiscreen/bmi_screen.dart';
import 'package:week7/screens/bmiscreen/saved_bmi.dart';
class BMIMain extends StatelessWidget {
  const BMIMain({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('BMI Screen'),
          backgroundColor: Colors.blue,
          bottom: TabBar(
            labelColor: Colors.white,
            tabs:[
              Tab(text: 'BMI Check',),
              Tab(text: 'Saved BMI',)
            ] ),
        ),
        body: TabBarView(
          children: [
            BMICalculator(),
            SavedBMI(),
          ]),
      ),
    );
  }
}