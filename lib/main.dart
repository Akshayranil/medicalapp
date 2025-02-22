import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:week7/profilemodel/model.dart';
import 'package:week7/splashscreen/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileAdapter());

  await Hive.openBox<Profile>('ProfileBox');

  Hive.registerAdapter(MedicineDataAdapter()); // Register the adapter
  await Hive.openBox<MedicineData>('medicineDataNewBox');
  await Hive.openBox<List<int>>('takenMedicinesBox');
  var settingsBox =
      await Hive.openBox('settingsBox'); // Box to store warning flag

  // Check for low medicine count
  checkLowMedicineCount(settingsBox);
  Hive.registerAdapter(BloodGlucoseRecordAdapter());
  Hive.registerAdapter(VitalsModelAdapter());
  await Hive.openBox<VitalsModel>('vitalsBox');
  Hive.registerAdapter(BMIResultAdapter());
  await Hive.openBox<BMIResult>('bmiBox');
  Hive.registerAdapter(AppointmentDataAdapter());
  await Hive.openBox('appointments');
  runApp(MyApp());
}
void appointmentReminder() {
  print("🔔 Reminder: You have an appointment!");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'V Care',
      home: SplashScreen(),
    );
  }
}

void checkLowMedicineCount(Box settingsBox) {
  var medicineBox = Hive.box<MedicineData>('medicineDataNewBox');
  bool lowMedicineFound = false;

  for (var medicine in medicineBox.values) {
    if (medicine.count < 2) {
      lowMedicineFound = true;
      break;
    }
  }

  // Store flag in Hive
  settingsBox.put('lowMedicineWarning', lowMedicineFound);
}
