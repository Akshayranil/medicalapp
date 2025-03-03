import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/profilemodel/model.dart';
import 'package:week7/profilescreen/personaldetails/personal_details.dart';
import 'package:week7/profilescreen/editprofile/edit_profile.dart';

/// Function to load the saved profile image
Future<File?> loadProfileImage() async {
  var box = Hive.box<Profile>('profileBox');
  Profile? profile = box.get('userProfile');
  if (profile != null && profile.photoPath.isNotEmpty) {
    return File(profile.photoPath);
  }
  return null;
}

/// Function to navigate to the "My Details" screen with stored profile data
void navigateToDetailsScreen(BuildContext context) {
  var box = Hive.box<Profile>('profileBox');
  var profile = box.get('userProfile');

  if (profile != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyDetails(
          name: profile.name,
          phoneNumber: profile.phoneNumber,
          dateOfBirth: profile.dateOfBirth,
          gender: profile.gender,
          bloodGroup: profile.bloodGroup,
          city: profile.city,
          photoPath: profile.photoPath,
        ),
      ),
    );
  }
}

/// Function to navigate to the "Edit Profile" screen and update UI on return
Future<void> navigateToEditProfile(BuildContext context, Function updateUI) async {
  var box = Hive.box<Profile>('profileBox');
  var profile = box.get('userProfile');

  if (profile != null) {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(profile: profile),
      ),
    );

    if (updatedProfile != null) {
      updateUI(); // Call the function to update UI with new profile data
    }
  }
}
