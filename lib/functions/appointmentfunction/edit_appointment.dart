import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:week7/profilemodel/model.dart';

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

  @override
  void initState() {
    super.initState();
    doctorController = TextEditingController(text: widget.appointment.doctorname);
    clinicController = TextEditingController(text: widget.appointment.clinicname);
    placeController = TextEditingController(text: widget.appointment.placename);
    selectedDate = widget.appointment.appointmentDateTime;
  }

  void _updateAppointment() {
    var box = Hive.box<AppointmentData>('appointments');
    int index = box.values.toList().indexOf(widget.appointment);

    final updatedAppointment = AppointmentData(
      doctorname: doctorController.text,
      clinicname: clinicController.text,
      placename: placeController.text,
      appointmentDateTime: DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
      ),
      remainderTime: widget.appointment.remainderTime,
    );

    box.putAt(index, updatedAppointment);
    Navigator.pop(context, updatedAppointment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Appointment"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCard(doctorController, "Doctor Name", Icons.person),
            SizedBox(height: 20,),
            _buildCard(clinicController, "Clinic Name", Icons.local_hospital),
            SizedBox(height: 20,),
            _buildCard(placeController, "City", Icons.location_city),
            SizedBox(height: 20,),

            // Date Picker Section
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

            Spacer(),

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
    );
  }

  // Custom Card Builder for Input Fields
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
