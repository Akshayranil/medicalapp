import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:week7/preboardingscreen/splashscreen/splash_screen.dart';
import 'package:week7/profilemodel/model.dart';


import 'package:timezone/data/latest.dart' as tz;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize timezone
  tz.initializeTimeZones();
  //  initializeNotifications;
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
  await Hive.openBox<AppointmentData>('appointments');
  Hive.registerAdapter(RecordsAdapter());
  await Hive.openBox<Records>('records');
  await Hive.openBox<String>('settingsdateBox');
  // Initialize Awesome Notifications
  await AwesomeNotifications().initialize(
  'resource://drawable/ic_medical',
  [
    NotificationChannel(
      channelKey: 'appointment_channel',
      channelName: 'Appointment Notifications',
      channelDescription: 'Reminder for upcoming appointments',
      defaultColor: Colors.blue,
      importance: NotificationImportance.Max, // 🔹 Ensure max importance
      ledColor: Colors.white,
      playSound: true, // 🔹 Enable sound
      soundSource: 'resource://raw/alarm',
      enableVibration: true,
      
    )
  ],
);

   print("✅ Awesome Notifications Initialized");

  // ✅ Request Permissions
  await requestPermissions();
  await AndroidAlarmManager.initialize(); // Initialize alarm manager
  // await requestAlarmPermission();
  
  runApp(MyApp());
}


Future<void> requestAlarmPermission() async {
  if (await Permission.scheduleExactAlarm.isDenied) {
    await Permission.scheduleExactAlarm.request();
  }
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

Future<void> requestPermissions() async {
  // Check & request notification permission
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // ✅ Request SCHEDULE_EXACT_ALARM permission for Android 12+
  if (await Permission.scheduleExactAlarm.isDenied) {
    await Permission.scheduleExactAlarm.request();
  }

   if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}





