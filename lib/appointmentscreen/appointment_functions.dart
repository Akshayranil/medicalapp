import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/appointmentscreen/alarm_functions.dart';
import 'package:week7/profilemodel/model.dart';


Future<void> saveAppointment({
  required BuildContext context,
  required TextEditingController doctorController,
  required TextEditingController clinicController,
  required TextEditingController placeController,
  required DateTime? selectedDate,
  required TimeOfDay? selectedTime,
  required int? reminderTime,
}) async {
  if (doctorController.text.isNotEmpty &&
      clinicController.text.isNotEmpty &&
      placeController.text.isNotEmpty &&
      selectedDate != null &&
      selectedTime != null) {
        
    DateTime appointmentDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    AppointmentData newAppointment = AppointmentData(
      doctorname: doctorController.text,
      clinicname: clinicController.text,
      placename: placeController.text,
      appointmentDateTime: appointmentDateTime,
      remainderTime: reminderTime,
    );

    var box = Hive.box<AppointmentData>('appointments');
    int id = await box.add(newAppointment);

    // ✅ Schedule the real-time alarm & notification
    if (reminderTime != null) {
      scheduleAppointmentAlarm(
        appointmentId: id,  // Use Hive's ID for uniqueness
        appointmentTime: appointmentDateTime,
        reminderMinutes: reminderTime,  // Dynamic reminder time
      );
    }

    Navigator.pop(context); // Go back and refresh the tab
  }
}


