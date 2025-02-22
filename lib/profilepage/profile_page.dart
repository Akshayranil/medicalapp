import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week7/profilemodel/model.dart';
import 'package:week7/profilescreen/profile_screen.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bloodController = TextEditingController();
  final _dobController = TextEditingController();
  final _cityController = TextEditingController();
  String _selectedGender = "Male"; // Default selected gender
  File? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Add your details',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!) // Show selected image
                            : null, // Default is null
                        child: _profileImage == null
                            ? const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.black,
                              )
                            : null, // Hide icon when image is selected
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                            );

                            if (image != null) {
                              setState(() {
                                _profileImage = File(image.path);
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: _userController,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter your name',
                        prefixIcon: const Icon(Icons.person),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: const Color.fromARGB(60, 128, 126, 126),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter your phone number',
                        prefixIcon: const Icon(Icons.call),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: const Color.fromARGB(60, 128, 126, 126),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: _dobController,
                      readOnly: true,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon: const Icon(Icons.calendar_today),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: const Color.fromARGB(60, 128, 126, 126),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _dobController.text =
                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Select Gender',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: "Male",
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Male'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "Female",
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Female'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "Other",
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Other'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 0),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: _bloodController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter your blood group',
                        prefixIcon: const Icon(Icons.water_drop),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: const Color.fromARGB(60, 128, 126, 126),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                       inputFormatters: [
                       FilteringTextInputFormatter.allow(RegExp(r'^[ABOabo\+\-]*$')) // Only A, B, O, +, -
                      ],
 
  
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a blood group';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _cityController,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter your city',
                        prefixIcon: const Icon(Icons.location_city),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: const Color.fromARGB(60, 128, 126, 126),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        //  Open the Hive box
                        var box = Hive.box<Profile>('profileBox'); // Use already opened box


                        //  Create Profile Object
                        final profile = Profile(
                          name: _userController.text.trim(),
                          phoneNumber: _phoneController.text.trim(),
                          dateOfBirth: _dobController.text.trim(),
                          gender: _selectedGender,
                          bloodGroup: _bloodController.text.trim(),
                          photoPath: _profileImage?.path ?? '',
                          city:
                              _cityController.text.trim(), // Handle image path
                        );

                        //  Save Profile in Hive
                        await box.put('userProfile', profile);
                        print("Data Stored in Hive:");
                        print("Name: ${box.get('userProfile')?.name}");
                        print("Phone: ${box.get('userProfile')?.phoneNumber}");
                        print("DOB: ${box.get('userProfile')?.dateOfBirth}");
                        print("Gender: ${box.get('userProfile')?.gender}");
                        print(
                            "Blood Group: ${box.get('userProfile')?.bloodGroup}");
                        print(
                            "Photo Path: ${box.get('userProfile')?.photoPath}");
                          print("City: ${box.get('userProfile')?.city}");   
                        // Navigate to home screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>ScreenProfile(bloodGroup: profile.bloodGroup, city: profile.city,name: profile.name,)),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 50),
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
