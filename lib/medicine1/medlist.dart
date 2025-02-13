import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week7/medicine1/medicinefunctions.dart';
import 'package:week7/profileModel/model.dart';
import 'package:intl/intl.dart';

class MedicineList extends StatefulWidget {
  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Box<MedicineData> medicineBox;
  late int initialTabIndex;

  @override
  void initState() {
    super.initState();
    medicineBox = Hive.box<MedicineData>('medicineDataNewBox');
    initialTabIndex = _getCurrentTabIndex(); // Get the correct tab index
    _tabController = TabController(length: 3, vsync: this, initialIndex: initialTabIndex);
  }

  /// Determines current time slot index
  int _getCurrentTabIndex() {
    int hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return 0; // Morning tab
    } else if (hour >= 12 && hour < 18) {
      return 1; // Afternoon tab
    } else {
      return 2; // Night tab
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          tabs: [
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
      ],
    );
  }

  Widget _buildMedicineList(String time) {
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

            return ListTile(
              title: Text(medicine.name),
              subtitle: Text("Count: ${medicine.count}"),
            );
          },
        );
      },
    );
  }
}
