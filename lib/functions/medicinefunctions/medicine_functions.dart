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
                    decoration:
                        InputDecoration(labelText: 'Total Medicine Count'),
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
                  String medicineName = medname.text.trim();
                  String totalCount = totalCountController.text.trim();

                  if (medicineName.isEmpty || totalCount.isEmpty) {
                    // Show error if input is empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Please enter valid medicine details.')),
                    );
                    return;
                  }

                  var box = Hive.box<MedicineData>('medicineDataNewBox');

                  // ✅ Check if medicine already exists (case insensitive)
                  bool medicineExists = box.values.any(
                    (medicine) =>
                        medicine.name.toLowerCase() ==
                        medicineName.toLowerCase(),
                  );

                  if (medicineExists) {
                    Navigator.pop(context);
                    // ❌ Medicine already exists, show error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Medicine already exists!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // ✅ Medicine does not exist, add it
                    var newMedicine = MedicineData(
                      name: medicineName,
                      count: double.parse(totalCount),
                      morningDosage: morning ? morningDosage : 0.0,
                      afternoonDosage: afternoon ? afternoonDosage : 0.0,
                      nightDosage: night ? nightDosage : 0.0,
                      morning: morning,
                      afternoon: afternoon,
                      night: night,
                    );

                    box.add(newMedicine);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Medicine added successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );

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
    {double? newMorningDosage,
    double? newAfternoonDosage,
    double? newNightDosage}) {
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
        morningDosage: newMorningDosage ??
            newMedical
                .morningDosage, // ✅ Update if provided, else keep old value
        afternoonDosage: newAfternoonDosage ?? newMedical.afternoonDosage,
        nightDosage: newNightDosage ?? newMedical.nightDosage,
      ),
    );
  }
}

void showDeleteMedicine(
    BuildContext context, Box<MedicineData> newMedicine, int index) {
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

void showEditMedicine(
    BuildContext context, Box<MedicineData> newMedicine, int index) {
  MedicineData medicinedata = newMedicine.getAt(index)!;
  TextEditingController nameController =
      TextEditingController(text: medicinedata.name);
  TextEditingController countController =
      TextEditingController(text: medicinedata.count.toString());

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
                    decoration:
                        InputDecoration(labelText: "Total Medicine Count"),
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
                  double newTotalCount =
                      double.tryParse(countController.text.trim()) ??
                          medicinedata.count;

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

void showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.green,
            child: Icon(Icons.check, color: Colors.white, size: 30),
          ),
          SizedBox(height: 10),
          Text(
            "Success!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
      content: Text(
        "You have successfully taken all your medicines for this session.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text("OK",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    ),
  );
}
