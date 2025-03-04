import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/profilemodel/model.dart';
import 'package:week7/screens/profilescreen/profile_screen.dart';


Future<void> saveProfile({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController userController,
  required TextEditingController phoneController,
  required TextEditingController dobController,
  required String selectedGender,
  required TextEditingController bloodController,
  required File? profileImage,
  required TextEditingController cityController,
}) async {
  if (!formKey.currentState!.validate()) return;

  var box = Hive.box<Profile>('profileBox');
  final profile = Profile(
    name: userController.text.trim(),
    phoneNumber: phoneController.text.trim(),
    dateOfBirth: dobController.text.trim(),
    gender: selectedGender,
    bloodGroup: bloodController.text.trim(),
    photoPath: profileImage?.path ?? '',
    city: cityController.text.trim(),
  );

  await box.put('userProfile', profile);

  // Navigate to Profile Screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => ScreenProfile(
        bloodGroup: profile.bloodGroup,
        city: profile.city,
        name: profile.name,
      ),
    ),
  );
}
