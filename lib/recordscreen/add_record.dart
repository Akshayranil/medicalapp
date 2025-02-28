import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:week7/profilemodel/model.dart';
import 'package:week7/recordscreen/record_screen.dart';

class AddRecordScreen extends StatefulWidget {
  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  File? _image;
  final TextEditingController _recordNameController = TextEditingController();
  final String _todayDate = DateTime.now().toLocal().toString().split(' ')[0];
  String? _selectedRecordtype = 'X-Ray';

  Future<void> _pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.camera, size: 40, color: Colors.blue),
                        onPressed: () =>
                            _pickImageFromSource(ImageSource.camera, context),
                      ),
                      Text('Camera'),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.photo_library,
                            size: 40, color: Colors.green),
                        onPressed: () =>
                            _pickImageFromSource(ImageSource.gallery, context),
                      ),
                      Text('Gallery'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImageFromSource(
      ImageSource source, BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  void _saveRecord() async {
    if (_image == null || _recordNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please fill all the details mentioned above")));
      return;
    }
    final record = Records(
        recordPath: _image!.path,
        recordDate: _todayDate,
        recordName: _recordNameController.text,
        recordType: _selectedRecordtype ?? '');
    final box = Hive.box<Records>('records');
    await box.add(record);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Record saved successfully!")));
    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyRecords()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Record'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _pickImage(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 380,
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
              DropdownButtonFormField<String>(
                  value: _selectedRecordtype,
                  decoration: InputDecoration(
                    labelText: 'Record Type',
                    border: OutlineInputBorder(),
                  ),
                  items: ['X-Ray', 'Scans', 'Medical Reports', 'Others']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRecordtype=value;
                    });
                  }),
              SizedBox(height: 120),
              
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _saveRecord();
                    
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
      ),
    );
  }
}
