import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week7/functions/functions.dart';
import 'package:week7/profileModel/model.dart';


class MedicineListView extends StatefulWidget {
  final Box<Medicine> medicineBox;

  const MedicineListView({Key? key, required this.medicineBox}) : super(key: key);

  @override
  _MedicineListViewState createState() => _MedicineListViewState();
}

class _MedicineListViewState extends State<MedicineListView> {
  String selectedTime = "Morning"; // Default selected time

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFilterButton("Morning"),
            _buildFilterButton("Afternoon"),
            _buildFilterButton("Night"),
          ],
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: widget.medicineBox.listenable(),
            builder: (context, Box<Medicine> box, _) {
              List<Medicine> filteredMedicines = box.values
                  .where((medicine) => medicine.times.contains(selectedTime))
                  .toList();

              if (filteredMedicines.isEmpty) {
                return Center(child: Text("No Medicines for $selectedTime"));
              }

              return ListView.builder(
                itemCount: filteredMedicines.length,
                itemBuilder: (context, index) {
                  Medicine medicine = filteredMedicines[index];
                  return ListTile(
                    title: Text(medicine.name),
                    
                    
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton(String time) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedTime = time;
        });
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: selectedTime == time
              ? Colors.greenAccent
              : const Color.fromARGB(255, 198, 197, 197),
          foregroundColor: Colors.white),
      child: Text(time),
    );
  }
}
