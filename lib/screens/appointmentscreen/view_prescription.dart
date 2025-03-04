import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/profilemodel/model.dart';

class ViewPrescriptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box<AppointmentData>('appointments');
    var appointments = box.values.toList();

    return Scaffold(
      body: appointments.isEmpty
          ? Center(child: Text('No prescriptions found'))
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                var appointment = appointments[index];

                return appointment.prescriptionimage != null
                    ? Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreenImage(
                                    imagePath: appointment.prescriptionimage!,
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(appointment.prescriptionimage!),
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text("Doctor: ${appointment.doctorname}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            "Date: ${appointment.appointmentDateTime.day}/${appointment.appointmentDateTime.month}/${appointment.appointmentDateTime.year}",
                          ),
                        ),
                      )
                    : SizedBox(); // Hide if no prescription
              },
            ),
    );
  }
}

// Full-screen Image Viewer
class FullScreenImage extends StatelessWidget {
  final String imagePath;

  FullScreenImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true, // Enables pinch & zoom
          child: Image.file(File(imagePath)),
        ),
      ),
    );
  }
}
