import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week7/medicinescreen/medicine_functions.dart';
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

  @override
  void initState() {
    super.initState();
    medicineBox = Hive.box<MedicineData>('medicineDataNewBox');
    takenMedicinesBox = Hive.box<List<int>>('takenMedicinesBox');

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
    List<int>? storedTakenMedicines = takenMedicinesBox.get(session);
    if (storedTakenMedicines != null) {
      setState(() {
        takenMedicines = storedTakenMedicines.toSet();
      });
    }
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
      _getCurrentSession() == "Morning" ? _buildMedicineList("Morning") : buildLockedSection("Morning"),
      _getCurrentSession() == "Afternoon" ? _buildMedicineList("Afternoon") : buildLockedSection("Afternoon"),
      _getCurrentSession() == "Night" ? _buildMedicineList("Night") : buildLockedSection("Night"),
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
    return ValueListenableBuilder(
      valueListenable: medicineBox.listenable(),
      builder: (context, Box<MedicineData> box, _) {
        var filteredMedicines = box.values.toList();
        var medicineKeys = box.keys.toList(); 

        filteredMedicines = filteredMedicines.where((medicine) {
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
            final medicineKey = medicineKeys[index]; 
            final isTaken = takenMedicines.contains(medicineKey); 
            
            return ListTile(
              title: Text(medicine.name),
              
              leading: Checkbox(
                value: isTaken || selectedMedicines.contains(medicineKey),
                onChanged: isTaken
                    ? null 
                    : (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedMedicines.add(medicineKey);
                          } else {
                            selectedMedicines.remove(medicineKey);
                          }
                        });
                      },
              ),
            );
          },
        );
      },
    );
  }

  void _takeMedicine() {
  setState(() {
    String session = _getCurrentSession();

    List<int> allMedicinesInSession = medicineBox.keys.where((key) {
      final medicine = medicineBox.get(key);
      if (medicine == null) return false;
      if (session == "Morning") return medicine.morning;
      if (session == "Afternoon") return medicine.afternoon;
      if (session == "Night") return medicine.night;
      return false;
    }).cast<int>().toList();

    // Decrease count and mark as taken for selected medicines
    for (int key in selectedMedicines) {
      final medicine = medicineBox.get(key);
      if (medicine != null && medicine.count > 0) {
        medicine.count -= 1;
        medicineBox.put(key, medicine);
        takenMedicines.add(key); // Add medicine to taken list after decrement
      }
    }

    // Save updated taken medicines
    takenMedicinesBox.put(session, takenMedicines.toList());

    // Now check if all medicines for the session have been taken
    bool allTaken = allMedicinesInSession.every((key) => takenMedicines.contains(key));

    selectedMedicines.clear();

    if (allTaken) {
      _showConfirmationDialog(); // Show success message
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


  void _showConfirmationDialog() {
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
}
