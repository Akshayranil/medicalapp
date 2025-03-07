import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/profilemodel/model.dart';


void MedicineDialogue(BuildContext context) {
  TextEditingController medname = TextEditingController();
  TextEditingController totalCountController = TextEditingController();

  double morningDosage = 1.0;
  double afternoonDosage = 1.0;
  double nightDosage = 1.0;

  bool morning = false;
  bool afternoon = false;
  bool night = false;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Enter Medicine Details'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: medname,
                    decoration: InputDecoration(labelText: 'Medicine Name'),
                  ),
                  TextField(
                    controller: totalCountController,
                    decoration: InputDecoration(labelText: 'Total Medicine Count'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 15),
                  Text("Select Dosage for Each Time"),
                  
                  CheckboxListTile(
                    title: Text("Morning"),
                    value: morning,
                    onChanged: (bool? value) {
                      setState(() {
                        morning = value ?? false;
                      });
                    },
                  ),
                  if (morning)
                    DropdownButton<double>(
                      value: morningDosage,
                      onChanged: (double? newValue) {
                        setState(() {
                          morningDosage = newValue!;
                        });
                      },
                      items: [0.5, 1.0, 1.5, 2.0]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
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
                  if (afternoon)
                    DropdownButton<double>(
                      value: afternoonDosage,
                      onChanged: (double? newValue) {
                        setState(() {
                          afternoonDosage = newValue!;
                        });
                      },
                      items: [0.5, 1.0, 1.5, 2.0]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
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
                  if (night)
                    DropdownButton<double>(
                      value: nightDosage,
                      onChanged: (double? newValue) {
                        setState(() {
                          nightDosage = newValue!;
                        });
                      },
                      items: [0.5, 1.0, 1.5, 2.0]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (medname.text.isNotEmpty && totalCountController.text.isNotEmpty) {
                    var newMedicine = MedicineData(
                      name: medname.text,
                      count: double.parse(totalCountController.text),
                      morningDosage: morning ? morningDosage : 0.0,
                      afternoonDosage: afternoon ? afternoonDosage : 0.0,
                      nightDosage: night ? nightDosage : 0.0,
                      morning: morning,
                      afternoon: afternoon,
                      night: night,
                    );

                    var box = Hive.box<MedicineData>('medicineDataNewBox');
                    box.add(newMedicine);

                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text("Add", style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    },
  );
}




void updateMedicine(Box<MedicineData> newMedicine, int index, double newCount, 
    {double? newMorningDosage, double? newAfternoonDosage, double? newNightDosage}) {
  
  MedicineData? newMedical = newMedicine.getAt(index);
  
  if (newMedical != null) {
    newMedicine.putAt(
      index,
      MedicineData(
        name: newMedical.name, 
        count: newCount, // ✅ Update total count
        morning: newMedical.morning, 
        afternoon: newMedical.afternoon,
        night: newMedical.night,
        morningDosage: newMorningDosage ?? newMedical.morningDosage, // ✅ Update if provided, else keep old value
        afternoonDosage: newAfternoonDosage ?? newMedical.afternoonDosage,
        nightDosage: newNightDosage ?? newMedical.nightDosage,
      ),
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

  double morningDosage = medicinedata.morningDosage;
  double afternoonDosage = medicinedata.afternoonDosage;
  double nightDosage = medicinedata.nightDosage;

  bool morning = medicinedata.morning;
  bool afternoon = medicinedata.afternoon;
  bool night = medicinedata.night;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("Edit Medicine"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Medicine Name"),
                  ),
                  TextField(
                    controller: countController,
                    decoration: InputDecoration(labelText: "Total Medicine Count"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  Text("Select Dosage Per Intake"),
                  
                  CheckboxListTile(
                    title: Text("Morning"),
                    value: morning,
                    onChanged: (bool? value) {
                      setState(() {
                        morning = value ?? false;
                      });
                    },
                  ),
                  if (morning)
                    DropdownButton<double>(
                      value: morningDosage,
                      onChanged: (double? newValue) {
                        setState(() {
                          morningDosage = newValue!;
                        });
                      },
                      items: [0.5, 1.0, 1.5, 2.0]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
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
                  if (afternoon)
                    DropdownButton<double>(
                      value: afternoonDosage,
                      onChanged: (double? newValue) {
                        setState(() {
                          afternoonDosage = newValue!;
                        });
                      },
                      items: [0.5, 1.0, 1.5, 2.0]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
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
                  if (night)
                    DropdownButton<double>(
                      value: nightDosage,
                      onChanged: (double? newValue) {
                        setState(() {
                          nightDosage = newValue!;
                        });
                      },
                      items: [0.5, 1.0, 1.5, 2.0]
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  String newName = nameController.text.trim();
                  double newTotalCount = double.tryParse(countController.text.trim()) ?? medicinedata.count;

                  if (newName.isNotEmpty) {
                    newMedicine.putAt(
                      index,
                      MedicineData(
                        name: newName,
                        count: newTotalCount,
                        morningDosage: morning ? morningDosage : 0.0,
                        afternoonDosage: afternoon ? afternoonDosage : 0.0,
                        nightDosage: night ? nightDosage : 0.0,
                        morning: morning,
                        afternoon: afternoon,
                        night: night,
                      ),
                    );
                  }

                  Navigator.pop(context);
                },
                child: Text("Save"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          );
        },
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



