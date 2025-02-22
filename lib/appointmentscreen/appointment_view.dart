import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/profilemodel/model.dart';

class ViewAppointmentsScreen extends StatefulWidget {
  @override
  _ViewAppointmentsScreenState createState() => _ViewAppointmentsScreenState();
}

class _ViewAppointmentsScreenState extends State<ViewAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('appointments');
    var appointments = box.values.toList();

    return Scaffold(
      
      body: appointments.isEmpty
          ? Center(child: Text("No appointments added"))
          : ListView.builder(
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
                          "Date: ${appointment.appointmentDateTime.day}/${appointment.appointmentDateTime.month}/${appointment.appointmentDateTime.year} "
                          "${appointment.appointmentDateTime.hour.toString().padLeft(2, '0')}:${appointment.appointmentDateTime.minute.toString().padLeft(2, '0')}",
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
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          box.deleteAt(index); // Deletes the appointment
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
