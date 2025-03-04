import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:week7/customwidgets/profile_gender.dart';
import 'package:week7/functions/profilepagefunctions/profilepage_functions.dart';
import 'package:week7/profilemodel/model.dart'; // Ensure the Profile model is imported

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
  String _selectedGender = "Male";
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage(); // Load saved image
  }

  /// Load the profile image from Hive when the screen opens
  void _loadProfileImage() {
    var box = Hive.box<Profile>('profileBox');
    Profile? profile = box.get('userProfile');

    if (profile != null && profile.photoPath.isNotEmpty) {
      setState(() {
        _profileImage = File(profile.photoPath);
      });
    }
  }

  /// Pick an image and save its path in Hive
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });

      // Save the selected image path in Hive
      var box = Hive.box<Profile>('profileBox');
      Profile? profile = box.get('userProfile');

      if (profile != null) {
        profile.photoPath = image.path; // Update the image path
        await box.put('userProfile', profile); // Save the updated profile
      }
    }
  }

  Future<void> _pickDate() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text('Add your details', style: TextStyle(fontSize: 25)),
                const SizedBox(height: 20),

                /// **Profile Image**
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 65,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) // Show saved image
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person, size: 80, color: Colors.black)
                          : null, // Hide icon if image is set
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage, // Pick image when tapped
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
                            ],
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(Icons.camera_alt, color: Colors.black, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                CustomTextFieldProfile(label: 'Enter your name', icon: Icons.person, controller: _userController),
                CustomTextFieldProfile(
                  label: 'Enter your phone number',
                  icon: Icons.call,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                CustomTextFieldProfile(
                  label: 'Date of Birth',
                  icon: Icons.calendar_today,
                  controller: _dobController,
                  readOnly: true,
                  onTap: _pickDate,
                ),
                CustomTextFieldProfile(
                  label: 'Enter your blood group',
                  icon: Icons.water_drop,
                  controller: _bloodController,
                ),
                CustomTextFieldProfile(label: 'Enter your city', icon: Icons.location_city, controller: _cityController),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    saveProfile(
                      context: context,
                      formKey: formKey,
                      userController: _userController,
                      phoneController: _phoneController,
                      dobController: _dobController,
                      selectedGender: _selectedGender,
                      bloodController: _bloodController,
                      profileImage: _profileImage,
                      cityController: _cityController,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 50),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Submit', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
