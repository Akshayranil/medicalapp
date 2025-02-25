import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/medicinescreen/medicine_count.dart';
import 'package:week7/medicinescreen/medicine_functions.dart';
import 'package:week7/medicinescreen/medicine_list.dart';
import 'package:week7/profilemodel/model.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({super.key});

  @override
  State<MedicineScreen> createState() => _Medicine1State();
  
}

class _Medicine1State extends State<MedicineScreen> {
  Box<MedicineData>?newMedicine;
  List<Map<String, dynamic>> medicine1 = [];
  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    newMedicine = await Hive.openBox<MedicineData>('medicineDataNewBox');
    setState(() {}); // Update UI when box is ready
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Medicals'),
          backgroundColor: Colors.lightGreenAccent,
          bottom: TabBar(indicatorColor: Colors.black, tabs: [
            Tab(
              text: 'Medicine List',
            ),
            Tab(
              text: 'Medicine Count',
            )
          ]),
        ),
        body: TabBarView(children: [
          MedicineList(),
          MedicineCount(newMedicine:newMedicine! ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            MedicineDialogue(context);
          },
          backgroundColor: Colors.lightGreenAccent,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
