import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:week7/profilemodel/model.dart';
import 'package:week7/screens/appointmentscreen/view_prescription.dart';

class AddPrescriptionScreen extends StatefulWidget {
  final String doctorName;
  final DateTime appointmentDate;

  AddPrescriptionScreen({required this.doctorName, required this.appointmentDate});

  @override
  _AddPrescriptionScreenState createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  File? _image;
  final picker = ImagePicker();
  String _currentTime = DateFormat('hh:mm a').format(DateTime.now());

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

 void _showImagePickerOptions() {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Select Image Source", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt, size: 50,),
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  Text("Camera", style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(width: 20,),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo_library, size: 50,),
                    onPressed: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                  Text("Gallery", style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    ),
  );
}


  void _updateTime() {
    setState(() {
      _currentTime = DateFormat('hh:mm a').format(DateTime.now());
    });
  }

  void _savePrescription() async {
    if (_image != null) {
      var box = Hive.box<AppointmentData>('appointments');
      var appointments = box.values.toList();

      for (int i = 0; i < appointments.length; i++) {
        if (appointments[i].doctorname == widget.doctorName &&
            appointments[i].appointmentDateTime == widget.appointmentDate) {
          // Update appointment with image path
          appointments[i].prescriptionimage = _image!.path;
          await box.putAt(i, appointments[i]);
          break;
        }
      }

      // Navigate to ViewPrescriptionsScreen
        Navigator.pop(context, true); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image first.")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Stream.periodic(Duration(minutes: 1)).listen((_) => _updateTime());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Prescription'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Time: $_currentTime",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Doctor: ${widget.doctorName}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Upload Prescription Image:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _showImagePickerOptions, // Open bottom sheet
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _image == null
                    ? Center(
                        child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _savePrescription,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
              ),
              child: Text("Add Prescription", style: TextStyle(fontSize: 16,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
