import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  File? _image;
  final TextEditingController _recordNameController = TextEditingController();
  final TextEditingController _recordTypeController = TextEditingController();
  final String _todayDate = DateTime.now().toLocal().toString().split(' ')[0];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Record'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _image == null
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
             Text(
              'Date: $_todayDate',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
           
            SizedBox(height: 20),
            TextField(
              controller: _recordNameController,
              decoration: InputDecoration(
                labelText: 'Record Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _recordTypeController,
              decoration: InputDecoration(
                labelText: 'Record Type',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add logic to save record
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                  minimumSize: Size(250, 60),
                ),
                child: Text('Save Record'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
