import 'package:flutter/material.dart';
import 'package:week7/customwidgets/customappointments/appointment_remainder.dart';
import 'package:week7/customwidgets/customappointments/custom_textfield.dart';
import 'package:week7/functions/appointmentfunction/appointment_functions.dart';




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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Appointment'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextfield(controller: doctorController, hintText:"Doctor's name",textName: "Doctor name",),
              CustomTextfield(controller: clinicController, hintText: "Clinic's name", textName: "Clinic name"),
              CustomTextfield(controller: placeController, hintText: "City", textName: "City"),
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
                                firstDate: DateTime.now(),
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
             
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 ReminderDropdown(onReminderSelected: (reminder)=>reminderTime=reminder),
                ],
              ),
              SizedBox(
                height: 170,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        saveAppointment(
                            context: context,
                            doctorController: doctorController,
                            clinicController: clinicController,
                            placeController: placeController,
                            selectedDate: selectedDate,
                            selectedTime: selectedTime,
                            reminderTime: reminderTime);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 60),
                          backgroundColor: Colors.blue),
                      child: Text('Add Appointment',style: TextStyle(color: Colors.white),))),
              
            ],
          ),
        ),
      ),
    );
  }
}
