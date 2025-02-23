// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();



// // Function to show notification
// void showAlarmNotification(int id, String doctorName, String time) async {
//   await flutterLocalNotificationsPlugin.show(
//     id,
//     'Appointment Reminder',
//     'You have an appointment with Dr. $doctorName at $time',
//     const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'alarm_channel',
//         'Alarm Notifications',
//         channelDescription: 'This notification is for appointment alarms',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//     ),
//   );
// }

// // Schedule an alarm that will work even if the app is closed
// void scheduleRealTimeAlarm(appointment, int id) async {
//   DateTime scheduledTime = appointment.appointmentDateTime.subtract(
//     Duration(minutes: appointment.remainderTime),
//   );

//   // Schedule an alarm
//   await AndroidAlarmManager.oneShotAt(
//     scheduledTime,
//     id, // Unique ID
//     () => showAlarmNotification(
//       id,
//       appointment.doctorname,
//       "${appointment.appointmentDateTime.hour.toString().padLeft(2, '0')}:${appointment.appointmentDateTime.minute.toString().padLeft(2, '0')}",
//     ),
//     exact: true,
//     wakeup: true, // Ensures the device wakes up
//   );
// }
