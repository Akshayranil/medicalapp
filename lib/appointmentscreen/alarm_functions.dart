import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

// Callback function for background alarm execution
void callbackDispatcher() {
  print("🔔 Alarm triggered in background!");
  sendNotification(9999); // Test notification
}

// Schedule the alarm and notification
void scheduleAppointmentAlarm({
  required int appointmentId,
  required DateTime appointmentTime,
  required int reminderMinutes,
}) async {
  DateTime reminderTime = appointmentTime.subtract(Duration(minutes: reminderMinutes));

  print("⏰ Scheduling alarm for: $reminderTime");

  bool isScheduled = await AndroidAlarmManager.oneShotAt(
    reminderTime,
    appointmentId,
    callbackDispatcher,  // Uses background-safe callback
    exact: true,
    wakeup: true,
    allowWhileIdle: true,
  );

  print("✅ Alarm Scheduled: $isScheduled");
}

// Function to show the notification
void sendNotification(int id) {
  print("🔔 Sending notification with ID: $id");

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'appointment_channel',
      title: 'Appointment Reminder',
      body: 'You have an appointment in a few minutes!',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}




