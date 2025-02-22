import 'package:flutter/material.dart';
import 'package:week7/appointmentscreen/add_appointment.dart';
import 'package:week7/appointmentscreen/appointment_view.dart';
import 'package:week7/appointmentscreen/view_prescription.dart';
import 'package:week7/functions/general_functions.dart';

class MyAppointment extends StatefulWidget {
  
   MyAppointment({super.key});

  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
int _selectedIndex = 2;

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
        body: TabBarView(children: [
          ViewAppointmentsScreen(),
          StoreData()
        ]),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddAppointmentScreen()));
          },
          backgroundColor: Colors.lightGreenAccent,
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: ButtonNavigation(currentIndex: _selectedIndex ,
         onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              NavigateScreen(context, index);
            })
      ),
    );
  }
}
