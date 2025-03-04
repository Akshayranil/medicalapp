import 'package:flutter/material.dart';
import 'package:week7/functions/general_functions.dart';
import 'package:week7/screens/appointmentscreen/add_appointment.dart';
import 'package:week7/screens/appointmentscreen/appointment_view.dart';
import 'package:week7/screens/appointmentscreen/view_prescription.dart';

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
          title: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('Appointments')),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          
          bottom: TabBar(indicatorColor: Colors.black,
          labelColor: Colors.white,
            tabs: [
              Tab(text: 'View Appointment',),
              Tab(text: 'View Prescription',),
            ]),
        ),
        body: TabBarView(children: [
          ViewAppointmentsScreen(),
          ViewPrescriptionsScreen(),
        ]),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddAppointmentScreen()));
          },
          backgroundColor: Colors.blue,
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
