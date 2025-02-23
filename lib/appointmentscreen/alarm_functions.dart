// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Future<void> initializeNotifications() async {
//   const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//   const InitializationSettings initSettings = InitializationSettings(android: androidInit);
//   await flutterLocalNotificationsPlugin.initialize(initSettings);
// }

// // Show notification when alarm triggers
// void showNotification() async {
//   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'alarm_channel',
//     'Alarm Notifications',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Medicine Alert!',
//     'It\'s time to take your medicine.',
//     notificationDetails,
//   );
// }

// // Alarm callback
// void alarmCallback() {
//   showNotification();
// }

// // Function to schedule an alarm
// Future<void> scheduleAlarm(DateTime appointmentTime, int minutesBefore) async {
//   DateTime alarmTime = appointmentTime.subtract(Duration(minutes: minutesBefore));
//   int alarmId = 0; // Unique alarm ID

//   await AndroidAlarmManager.oneShotAt(
//     alarmTime,
//     alarmId,
//     alarmCallback,
//     exact: true,
//     wakeup: true,
//   );
// }


