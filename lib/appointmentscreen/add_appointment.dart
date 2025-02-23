import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/appointmentscreen/appointment_view.dart';
import 'package:week7/appointmentscreen/time_function.dart';
import 'package:week7/profilemodel/model.dart';



class AddAppointmentScreen extends StatefulWidget {
  @override
  _AddAppointmentScreenState createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  final doctorController = TextEditingController();
  final clinicController = TextEditingController();
  final placeController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int? reminderTime;
  bool isReminderSet = false;
  // Function to format the selected date
  String getFormattedDate() {
    if (selectedDate == null) return "No Date Selected";
    return "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
  }

  // Function to format the selected time
  String getFormattedTime() {
    if (selectedTime == null) return "No Time Selected";
    return "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}";
  }

  void saveAppointment() async {
  if (doctorController.text.isNotEmpty &&
      clinicController.text.isNotEmpty &&
      placeController.text.isNotEmpty &&
      selectedDate != null &&
      selectedTime != null) {
    DateTime appointmentDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    AppointmentData newAppointment = AppointmentData(
      doctorname: doctorController.text,
      clinicname: clinicController.text,
      placename: placeController.text,
      appointmentDateTime: appointmentDateTime,
      remainderTime: reminderTime,
    );

    var box = Hive.box('appointments');
    int id = await box.add(newAppointment);

    // scheduleRealTimeAlarm(newAppointment, id); // Real-time alarm

    Navigator.pop(context); // This will go back to the tab and trigger a refresh

  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Appointment'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Doctor Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: doctorController,
                    decoration: InputDecoration(
                        hintText: "Doctor's name", border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text("Clinic Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: clinicController,
                    decoration: InputDecoration(
                        hintText: "Clinic name", border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text("City Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: placeController,
                    decoration: InputDecoration(
                        hintText: "City ", border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  // Date Picker Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(getFormattedDate()),
                            trailing: Icon(Icons.calendar_today),
                            onTap: () async {
                              selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16), // Space between date and time

                  // Time Picker Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select Time",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(getFormattedTime()),
                            trailing: Icon(Icons.access_time),
                            onTap: () async {
                              selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text("Set Reminder",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<int>(
                    value: reminderTime,
                    hint: Text('Select reminder time'),
                    items: [
                      DropdownMenuItem(
                        child: Text('30 Minutes before'),
                        value: 30,
                      ),
                      DropdownMenuItem(
                        child: Text('60 Minutes before'),
                        value: 60,
                      ),
                      DropdownMenuItem(
                        child: Text('120 Minutes before'),
                        value: 120,
                      ),
                      DropdownMenuItem(
                        child: Text('240 Minutes before'),
                        value: 240,
                      ),
                    ],
                    onChanged: (int? value) {
                      setState(() {
                        reminderTime = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 180,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        saveAppointment();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 60),
                          backgroundColor: Colors.lightGreenAccent),
                      child: Text('Add Appointment')))
            ],
          ),
        ),
      ),
    );
  }
}
