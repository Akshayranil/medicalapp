import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

@pragma('vm:entry-point')  // Prevents Flutter from optimizing this function away
void callbackDispatcher() {
  print("🚨 Alarm triggered in background!");

  // ✅ Directly send the notification without using SharedPreferences
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 9999,
      channelKey: 'appointment_channel',
      title: 'Appointment Reminder',
      body: 'You have an appointment in a few minutes!',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}

// ✅ Schedule the alarm and notification
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
    callbackDispatcher,  // ✅ Uses background-safe callback
    exact: true,
    wakeup: true,
    allowWhileIdle: true,
  );

  print("✅ Alarm Scheduled: $isScheduled");
}
