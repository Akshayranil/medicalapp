import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/bmiscreen/bmi_main.dart';
import 'package:week7/glucosescreen/glucose_screen.dart';
import 'package:week7/medicinescreen/medicine_view.dart';
import 'package:week7/vitalsscreen/vitals_screen.dart';

final List<Map<String, dynamic>> cardData = [
  {
    'image': 'assets/images/glucose.jpg',
    'title': 'Blood Glucose',
    'screen': GlucoseScreen()
  },
  {
    'image': 'assets/images/med2.jpg',
    'title': 'My Medicine',
    'screen': MedicineScreen()
  },
  {
    'image': 'assets/images/vital.webp',
    'title': 'My Vitals',
    'screen': MyVitals()
  },
  {
    'image': 'assets/images/BMI.webp',
    'title': 'BMI Calculator',
    'screen': BMIMain()
  },
];

void checkAndShowWarning(BuildContext context) async {
  var settingsBox = Hive.box('settingsBox');
  bool showWarning = settingsBox.get('lowMedicineWarning', defaultValue: false);

  if (showWarning) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLowMedicinePopup(context);
    });

    // Reset flag so popup doesn't show again unnecessarily
    settingsBox.put('lowMedicineWarning', false);
  }
}

void showLowMedicinePopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.amber,
      title: Center(
          child: Text(
        "Warning",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
      )), // Centering title
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "One of your medicines has a count less than 2.\nPlease restock soon.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500), // Centering content
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center, // Centering button
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red, // Red background
            foregroundColor: Colors.white, // White text
          ),
          onPressed: () => Navigator.pop(context),
          child: Text("OK"),
        ),
      ],
    ),
  );
}

