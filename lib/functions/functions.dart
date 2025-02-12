import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/profileModel/model.dart';


void showAddMedicineDialog(BuildContext context, Box<Medicine> medicineBox) {
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();
  List<String> selectedTimes = [];

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Add Medicine"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Medicine Name"),
                ),
                TextField(
                  controller: countController,
                  decoration: InputDecoration(labelText: "Medicine Count"),
                  keyboardType: TextInputType.number,
                ),
                CheckboxListTile(
                  title: Text("Morning"),
                  value: selectedTimes.contains("Morning"),
                  onChanged: (bool? value) {
                    setState(() {
                      value! ? selectedTimes.add("Morning") : selectedTimes.remove("Morning");
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Afternoon"),
                  value: selectedTimes.contains("Afternoon"),
                  onChanged: (bool? value) {
                    setState(() {
                      value! ? selectedTimes.add("Afternoon") : selectedTimes.remove("Afternoon");
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Night"),
                  value: selectedTimes.contains("Night"),
                  onChanged: (bool? value) {
                    setState(() {
                      value! ? selectedTimes.add("Night") : selectedTimes.remove("Night");
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text.trim();
                  int? count = int.tryParse(countController.text.trim());

                  if (name.isNotEmpty && count != null && selectedTimes.isNotEmpty) {
                    medicineBox.add(Medicine(name: name, count: count, times: selectedTimes));
                    Navigator.pop(context);
                  }
                },
                child: Text("Add"),
              ),
            ],
          );
        },
      );
    },
  );
}

void showDeleteMedicineDialog(BuildContext context, Box<Medicine> medicineBox, int index) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text("Are you sure you want to delete this medicine?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              medicineBox.deleteAt(index);
              Navigator.pop(context); // Close alert
            },
            child: Text("Delete"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      );
    },
  );
}

void updateMedicineCount(Box<Medicine> medicineBox, int index, int newCount) {
  Medicine? medicine = medicineBox.getAt(index);
  if (medicine != null) {
    medicineBox.putAt(
      index,
      Medicine(
        name: medicine.name,
        count: newCount,
        times: medicine.times, // Preserve times
      ),
    );
  }
}



void showEditMedicineDialog(BuildContext context, Box<Medicine> medicineBox, int index) {
  Medicine medicine = medicineBox.getAt(index)!;
  TextEditingController nameController = TextEditingController(text: medicine.name);
  TextEditingController countController = TextEditingController(text: medicine.count.toString());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Edit Medicine"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Medicine Name"),
            ),
            TextField(
              controller: countController,
              decoration: InputDecoration(labelText: "Count"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              String newName = nameController.text.trim();
              int newCount = int.tryParse(countController.text.trim()) ?? medicine.count;

              if (newName.isNotEmpty) {
                medicineBox.putAt(
                  index,
                  Medicine(
                    name: newName,
                    count: newCount,
                    times: medicine.times,
                  ),
                );
              }

              Navigator.pop(context); // Close dialog
            },
            child: Text("Save"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
        ],
      );
    },
  );
}
