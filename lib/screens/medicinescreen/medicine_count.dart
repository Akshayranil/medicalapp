import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week7/functions/medicinefunctions/medicine_functions.dart';
import 'package:week7/profilemodel/model.dart';

class MedicineCount extends StatelessWidget {
  final Box<MedicineData> newMedicine;
  const MedicineCount({super.key, required this.newMedicine});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: newMedicine.listenable(),
        builder: (context, Box<MedicineData> box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text("No Medicine Added"),
            );
          }
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                MedicineData meddata = box.getAt(index)!;
                final textColor = meddata.count < 2 ? Colors.red : Colors.black;
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(meddata.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                          
                            Text(
                              "${meddata.count}",
                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: textColor),
                            ),
                            SizedBox(width: 60,),
                          
                            IconButton(
                                onPressed: () {
                                  showDeleteMedicine(
                                      context, newMedicine, index);
                                },
                                icon: Icon(Icons.delete)),
                            IconButton(
                                onPressed: () {
                                  showEditMedicine(context, newMedicine, index);
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
