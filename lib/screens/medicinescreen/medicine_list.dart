import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week7/functions/medicinefunctions/medicine_functions.dart';
import 'package:week7/profilemodel/model.dart';

class MedicineList extends StatefulWidget {
  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Box<MedicineData> medicineBox;
  late Box<List<int>> takenMedicinesBox;
  late int initialTabIndex;
  Set<int> selectedMedicines = {}; 
  Set<int> takenMedicines = {}; 
  late Box<String> dateBox;//seperate box for storing last date
  @override
  void initState() {
    super.initState();
    medicineBox = Hive.box<MedicineData>('medicineDataNewBox');
    takenMedicinesBox = Hive.box<List<int>>('takenMedicinesBox');
    dateBox = Hive.box<String>('settingsdateBox');
    initialTabIndex = _getCurrentTabIndex();
    _tabController = TabController(length: 3, vsync: this, initialIndex: initialTabIndex);
    _tabController.addListener(_resetSelection);

    _loadTakenMedicines();
  }

  int _getCurrentTabIndex() {
    int hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return 0; 
    } else if (hour >= 12 && hour < 18) {
      return 1; 
    } else {
      return 2; 
    }
  }

  String _getCurrentSession() {
    return ["Morning", "Afternoon", "Night"][_getCurrentTabIndex()];
  }

 void _loadTakenMedicines() {
  String session = _getCurrentSession();
  DateTime today = DateTime.now();

  // Retrieve last stored date from `settingsBox`
  String? lastDateString = dateBox.get('lastDate');
  DateTime? lastDate = lastDateString != null ? DateTime.tryParse(lastDateString) : null;

  if (lastDate == null || lastDate.day != today.day || lastDate.month != today.month || lastDate.year != today.year) {
    // If it's a new day, reset taken medicines
    takenMedicinesBox.clear();
    dateBox.put('lastDate', today.toIso8601String()); // Save new date as String
    takenMedicines.clear();
  } else {
    // Otherwise, load saved taken medicines
    List<int>? storedTakenMedicines = takenMedicinesBox.get(session);
    if (storedTakenMedicines != null) {
      takenMedicines = storedTakenMedicines.toSet();
    }
  }

  setState(() {});
}



  void _resetSelection() {
    setState(() {
      selectedMedicines.clear();
      takenMedicines.clear();
      _loadTakenMedicines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(text: 'Morning'),
            Tab(text: 'Afternoon'),
            Tab(text: 'Night'),
          ],
        ),
       Expanded(
  child: TabBarView(
    controller: _tabController,
    children: [
   
       _buildMedicineList("Morning"),
      _buildMedicineList("Afternoon"),
      _buildMedicineList("Night"),
    ],
  ),
),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreenAccent),
            onPressed: selectedMedicines.isNotEmpty ? _takeMedicine : null,
            child: Text("Take Medicine"),
          ),
        ),
      ],
    );
  }



Widget _buildMedicineList(String time) {
  bool isEnabled = _getCurrentSession() == time; // Enable only current session

  return ValueListenableBuilder(
    valueListenable: medicineBox.listenable(),
    builder: (context, Box<MedicineData> box, _) {
      var filteredMedicines = box.values.where((medicine) {
        if (time == "Morning") return medicine.morning;
        if (time == "Afternoon") return medicine.afternoon;
        if (time == "Night") return medicine.night;
        return false;
      }).toList();

      if (filteredMedicines.isEmpty) {
        return Center(child: Text("No medicines for $time"));
      }

      return ListView.builder(
        itemCount: filteredMedicines.length,
        itemBuilder: (context, index) {
          final medicine = filteredMedicines[index];
          final medicineKey = box.keys.toList()[index];
          final isTaken = takenMedicines.contains(medicineKey);

          // ✅ Get the correct dosage for the session
          double dosage = time == "Morning"
              ? medicine.morningDosage
              : time == "Afternoon"
                  ? medicine.afternoonDosage
                  : medicine.nightDosage;

          return ListTile(
            title: Text(medicine.name),
            leading: Checkbox(
              value: isTaken || selectedMedicines.contains(medicineKey),
              onChanged: isEnabled && !isTaken
                  ? (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedMedicines.add(medicineKey);
                        } else {
                          selectedMedicines.remove(medicineKey);
                        }
                      });
                    }
                  : null, // Disabled if not in correct time
            ),
            trailing: Text("Dosage: $dosage", style: TextStyle(color: Colors.black54)), // ✅ Show dosage instead of count
          );
        },
      );
    },
  );
}




void _takeMedicine() {
  setState(() {
    String session = _getCurrentSession();
    DateTime today = DateTime.now();

    List<int> allMedicinesInSession = medicineBox.keys.where((key) {
      final medicine = medicineBox.get(key);
      if (medicine == null) return false;
      if (session == "Morning") return medicine.morning;
      if (session == "Afternoon") return medicine.afternoon;
      if (session == "Night") return medicine.night;
      return false;
    }).cast<int>().toList();

    // ✅ Reduce total count by correct dosage
    for (int key in selectedMedicines) {
      final medicine = medicineBox.get(key);
      if (medicine != null) {
        double dosage = session == "Morning"
            ? medicine.morningDosage
            : session == "Afternoon"
                ? medicine.afternoonDosage
                : medicine.nightDosage;

        if (medicine.count >= dosage) {  // ✅ Ensure there is enough stock
          medicineBox.put(
            key,
            MedicineData(
              name: medicine.name,
              count: medicine.count - dosage, // ✅ Reduce by exact dosage (no rounding)
              morningDosage: medicine.morningDosage,
              afternoonDosage: medicine.afternoonDosage,
              nightDosage: medicine.nightDosage,
              morning: medicine.morning,
              afternoon: medicine.afternoon,
              night: medicine.night,
            ),
          );

          takenMedicines.add(key);
        }
      }
    }

    // ✅ Save updated taken medicines
    takenMedicinesBox.put(session, takenMedicines.toList());
    dateBox.put('lastDate', today.toIso8601String()); // ✅ Store last date

    selectedMedicines.clear();

    bool allTaken = allMedicinesInSession.every((key) => takenMedicines.contains(key));

    if (allTaken) {
      showConfirmationDialog(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You have not taken all your medicines!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  });
}

}
