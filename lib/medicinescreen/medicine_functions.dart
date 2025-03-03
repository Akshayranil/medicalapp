import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/profilemodel/model.dart';


void MedicineDialogue(BuildContext context) {
  TextEditingController medname = TextEditingController();
  TextEditingController medvalue = TextEditingController();

  bool morning = false;
  bool afternoon = false;
  bool night = false;

  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Enter Medicine details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: medname,
                  decoration: InputDecoration(labelText: 'Medicine name'),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: medvalue,
                  decoration: InputDecoration(labelText: 'Medicine Count'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15),
                Text("Select Time to Take Medicine",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                CheckboxListTile(
                  title: Text('Morning'),
                  value: morning,
                  onChanged: (bool? value) {
                    setState(() {
                      morning = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Afternoon"),
                  value: afternoon,
                  onChanged: (bool? value) {
                    setState(() {
                      afternoon = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Night"),
                  value: night,
                  onChanged: (bool? value) {
                    setState(() {
                      night = value ?? false;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (medname.text.isNotEmpty && medvalue.text.isNotEmpty) {
                    var newMedicine = MedicineData(
                      name: medname.text,
                      count: int.parse(medvalue.text),
                      morning: morning,
                      afternoon: afternoon,
                      night: night,
                    );

                    var box = Hive.box<MedicineData>('medicineDataNewBox');
                    box.add(newMedicine); // Save to NEW Hive database

                    print("Medicine Added: ${newMedicine.name}, Count: ${newMedicine.count}");

                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text('Add',style: TextStyle(color: Colors.white),),
              )
            ],
          );
        });
      });
}

void updateMedicine(Box<MedicineData> newMedicine, int index, int newCount) {
  MedicineData? newMedical = newMedicine.getAt(index);
  if (newMedical != null) {
    newMedicine.putAt(
      index,
      MedicineData(
        name: newMedical.name, 
        count: newMedical.count,
         morning: newMedical.morning, 
         afternoon: newMedical.afternoon,
          night:newMedical.night)
    );
  }
}


void showDeleteMedicine(BuildContext context, Box<MedicineData> newMedicine, int index) {
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
              newMedicine.deleteAt(index);
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

void showEditMedicine(BuildContext context, Box<MedicineData> newMedicine, int index) {
  MedicineData medicinedata = newMedicine.getAt(index)!;
  TextEditingController nameController = TextEditingController(text: medicinedata.name);
  TextEditingController countController = TextEditingController(text: medicinedata.count.toString());

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
              int newCount = int.tryParse(countController.text.trim()) ?? medicinedata.count;

              if (newName.isNotEmpty) {
                newMedicine.putAt(
                  index,
                 MedicineData(name: newName, count: newCount, morning:medicinedata.morning, afternoon: medicinedata.afternoon, night: medicinedata.night)
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

// Widget buildLockedSection(String time) {
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(Icons.lock, size: 50, color: Colors.grey),
//         SizedBox(height: 10),
//         Text(
//           "This section is locked.",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
//         ),
//         SizedBox(height: 5),
//         Text(
//           "You can access $time medicines only during its time.",
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.black54),
//         ),
//       ],
//     ),
//   );
// }

void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.green,
          child: Icon(Icons.check,))),
        content: Text("You have successfully taken all your medicines for this session."),
        backgroundColor: Colors.lightGreenAccent,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
            onPressed: () => Navigator.pop(context),
            child: Text("OK",textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }



