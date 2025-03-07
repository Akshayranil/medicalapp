import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:week7/profilemodel/model.dart';
import 'package:week7/functions/appointmentfunction/alarm_functions.dart';

class EditAppointmentScreen extends StatefulWidget {
  final AppointmentData appointment;

  EditAppointmentScreen({required this.appointment});

  @override
  _EditAppointmentScreenState createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
  late TextEditingController doctorController;
  late TextEditingController clinicController;
  late TextEditingController placeController;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int? reminderTime;  // Store selected reminder time

  @override
  void initState() {
    super.initState();
    doctorController = TextEditingController(text: widget.appointment.doctorname);
    clinicController = TextEditingController(text: widget.appointment.clinicname);
    placeController = TextEditingController(text: widget.appointment.placename);
    selectedDate = widget.appointment.appointmentDateTime;
    selectedTime = TimeOfDay.fromDateTime(widget.appointment.appointmentDateTime);
    reminderTime = widget.appointment.remainderTime;
  }

  void _updateAppointment() async {
    var box = Hive.box<AppointmentData>('appointments');
    int index = box.values.toList().indexOf(widget.appointment);

    DateTime updatedAppointmentTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    final updatedAppointment = AppointmentData(
      doctorname: doctorController.text,
      clinicname: clinicController.text,
      placename: placeController.text,
      appointmentDateTime: updatedAppointmentTime,
      remainderTime: reminderTime,
    );

    box.putAt(index, updatedAppointment);

    // 🔄 Reschedule the Alarm with the new time
    if (reminderTime != null) {
      scheduleAppointmentAlarm(
        appointmentId: index, // Same ID as Hive
        appointmentTime: updatedAppointmentTime,
        reminderMinutes: reminderTime!, // New reminder time
      );
    }

    Navigator.pop(context, updatedAppointment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Appointment"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCard(doctorController, "Doctor Name", Icons.person),
              SizedBox(height: 20),
              _buildCard(clinicController, "Clinic Name", Icons.local_hospital),
              SizedBox(height: 20),
              _buildCard(placeController, "City", Icons.location_city),
              SizedBox(height: 20),
          
              // 📅 Date Picker
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(Icons.calendar_today, color: Colors.blue),
                  title: Text("Date: ${DateFormat('dd-MM-yyyy').format(selectedDate!)}"),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate!,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                ),
              ),
          
              SizedBox(height: 20),
          
              // ⏰ Time Picker
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(Icons.access_time, color: Colors.blue),
                  title: Text("Time: ${selectedTime!.format(context)}"),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTime!,
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedTime = pickedTime;
                      });
                    }
                  },
                ),
              ),
          
              SizedBox(height: 20),
          
              // 🔔 Reminder Dropdown
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: DropdownButton<int>(
                    value: reminderTime,
                    isExpanded: true,
                    items: [ 30, 60, 120,240].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("Reminder: $value min before"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        reminderTime = value;
                      });
                    },
                  ),
                ),
              ),
          
             SizedBox(height: 160,),
          
              ElevatedButton(
                onPressed: _updateAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(200, 50),
                ),
                child: Text("Update Appointment", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Custom Input Field
  Widget _buildCard(TextEditingController controller, String label, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            icon: Icon(icon, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
