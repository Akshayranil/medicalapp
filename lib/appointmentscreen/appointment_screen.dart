import 'package:flutter/material.dart';
import 'package:week7/appointmentscreen/add_appointment.dart';

class MyAppointment extends StatelessWidget {
  const MyAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Appointments'),
          backgroundColor: Colors.lightGreenAccent,
          bottom: TabBar(indicatorColor: Colors.black,
            tabs: [
              Tab(text: 'View Appointment',),
              Tab(text: 'View Prescription',),
            ]),
        ),
        body: Center(
          child: Text('No text is present now'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddAppointmentScreen()));
          },
          backgroundColor: Colors.lightGreenAccent,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
