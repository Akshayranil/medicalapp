import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:week7/appointmentscreen/add_prescription.dart';
import 'package:week7/appointmentscreen/alarm_functions.dart';
import 'package:week7/appointmentscreen/edit_appointment.dart';

import 'package:week7/main.dart';
import 'package:week7/profilemodel/model.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

//It was told to inport here because to set tz

class ViewAppointmentsScreen extends StatefulWidget {
  @override
  _ViewAppointmentsScreenState createState() => _ViewAppointmentsScreenState();
}

class _ViewAppointmentsScreenState extends State<ViewAppointmentsScreen> {
  @override
  void initState() {
    super.initState();

    var box = Hive.box<AppointmentData>('appointments');
    var appointments = box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Hive.box<AppointmentData>('appointments').listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return Center(child: Text('No Appointments Found'));
          } else {
            var appointments = box.values.toList();
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                AppointmentData appointment = appointments[index];

                return Card(
                  margin: EdgeInsets.all(16),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Doctor: ${appointment.doctorname}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 5),
                        Text(
                          "Date: ${DateFormat('dd-MM-yyyy').format(appointment.appointmentDateTime)}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Clinic: ${appointment.clinicname}"),
                        Text("City: ${appointment.placename}"),
                        Text(
                          "Reminder: ${appointment.remainderTime} minutes before",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddPrescriptionScreen(
                                          doctorName: appointment.doctorname,
                                          appointmentDate:
                                              appointment.appointmentDateTime,
                                        )));
                            setState(() {});
                          },
                          icon: Icon(Icons.add_a_photo)),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditAppointmentScreen(
                                        appointment: appointment)));
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            box.deleteAt(index);
                            AndroidAlarmManager.cancel(
                                index); // Cancel alarm when deleted
                          });
                        },
                      ),
                    ]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
