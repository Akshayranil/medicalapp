import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week7/MedicineScreen/medicinecountview.dart';
import 'package:week7/MedicineScreen/medicinelist.dart';
import 'package:week7/functions/functions.dart';
import 'package:week7/profileModel/model.dart';

class MyMedicine extends StatefulWidget {
  @override
  _MyMedicineState createState() => _MyMedicineState();
}

class _MyMedicineState extends State<MyMedicine> {
  Box<Medicine>? medicineBox;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    medicineBox = await Hive.openBox<Medicine>('medicines');
    setState(() {}); // Update UI when box is ready
  }

  @override
  Widget build(BuildContext context) {
    if (medicineBox == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddMedicineDialog(context, medicineBox!);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightGreenAccent,
        ),
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          title: Text('My Medicines'),
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.green,
            tabs: [
              Tab(text: 'Medicine List'),
              Tab(text: 'Medicine Count'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MedicineListView(medicineBox: medicineBox!),
            MedicineCountView(medicineBox: medicineBox!)
          ],
        ),
      ),
    );
  }

  String selectedTime = "Morning"; // Default selected time

 

 
}
