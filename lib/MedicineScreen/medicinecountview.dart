import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week7/profileModel/model.dart';
import 'package:week7/functions/functions.dart'; // Ensure this contains updateMedicineCount()

class MedicineCountView extends StatelessWidget {
  final Box<Medicine> medicineBox;

  const MedicineCountView({super.key, required this.medicineBox});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: medicineBox.listenable(),
      builder: (context, Box<Medicine> box, _) {
        if (box.isEmpty) {
          return Center(child: Text("No Medicines Added"));
        }
        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            Medicine medicine = box.getAt(index)!;
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      medicine.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.red),
                          onPressed: () {
                            if (medicine.count > 0) {
                              updateMedicineCount(
                                  medicineBox, index, medicine.count - 1);
                            }
                          },
                        ),
                        Text(
                          "${medicine.count}",
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.green),
                          onPressed: () {
                            updateMedicineCount(
                                medicineBox, index, medicine.count + 1);
                          },
                        ),
                        IconButton(
                            onPressed: () {
                              showDeleteMedicineDialog(
                                  context, medicineBox, index);
                            },
                            icon: Icon(Icons.delete)),
                        IconButton(
                            onPressed: () {
                              showEditMedicineDialog(
                                  context, medicineBox, index);
                            },
                            icon: Icon(
                              Icons.edit,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
