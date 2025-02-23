import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:week7/profilemodel/model.dart';

class EditProfileScreen extends StatefulWidget {
  final Profile profile;
  const EditProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _cityController;
  late TextEditingController _bloodGroupController;
  late TextEditingController _dobController;
  String _selectedGender = "Male"; // Default selected gender
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _phoneController = TextEditingController(text: widget.profile.phoneNumber);
    _cityController = TextEditingController(text: widget.profile.city);
    _bloodGroupController = TextEditingController(text: widget.profile.bloodGroup);
    _dobController = TextEditingController(text: widget.profile.dateOfBirth);
    _selectedGender = widget.profile.gender;

    if (widget.profile.photoPath.isNotEmpty) {
      _profileImage = File(widget.profile.photoPath);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      var box = Hive.box<Profile>('profileBox');

      Profile updatedProfile = Profile(
        name: _nameController.text,
        phoneNumber: _phoneController.text,
        city: _cityController.text,
        bloodGroup: _bloodGroupController.text,
        dateOfBirth: _dobController.text,
        gender: _selectedGender,
        photoPath: _profileImage?.path ?? widget.profile.photoPath,
      );

      await box.put('userProfile', updatedProfile);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully!"),
        backgroundColor: Colors.green,),
      );

      Navigator.pop(context, updatedProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile"),backgroundColor: Colors.lightGreenAccent,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 60,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.black,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: _pickImage,
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
                const SizedBox(height: 20),
                _buildTextField(_nameController, "Enter your name", Icons.person),
                _buildTextField(_phoneController, "Enter your phone number", Icons.call, keyboardType: TextInputType.phone),
                _buildTextField(_dobController, "Date of Birth", Icons.calendar_today, readOnly: true, onTap: _pickDate),
                _buildGenderSelection(),
                _buildTextField(_bloodGroupController, "Enter your blood group", Icons.water_drop),
                _buildTextField(_cityController, "Enter your city", Icons.location_city),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 50),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("Save Profile", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon, {TextInputType keyboardType = TextInputType.text, bool readOnly = false, GestureTapCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: const Color.fromARGB(60, 128, 126, 126),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 1.0, style: BorderStyle.none),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a $labelText';
          }
          return null;
        },
      ),
    );
  }

  void _pickDate() async {
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

  Widget _buildGenderSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Select Gender", style: TextStyle(fontSize: 18)),
          Row(
            children: [
              _buildGenderRadio("Male"),
              _buildGenderRadio("Female"),
              _buildGenderRadio("Other"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderRadio(String gender) {
    return Row(
      children: [
        Radio<String>(
          value: gender,
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
        Text(gender),
      ],
    );
  }
}
