import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/functions/general_functions.dart';
import 'package:week7/profilemodel/model.dart';
import 'package:week7/profilescreen/editprofile/edit_profile.dart';
import 'package:week7/profilescreen/helpandsupport/help_support.dart';
import 'package:week7/profilescreen/personaldetails/personal_details.dart';
import 'package:week7/profilescreen/privacypolicy/privacy_policy.dart';

class ScreenProfile extends StatefulWidget {
  ScreenProfile(
      {super.key,
      required this.bloodGroup,
      required this.city,
      required this.name});
  String? bloodGroup;
  String? city;
  String? name;
  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage(); // Load saved profile image when screen opens
  }

  void _loadProfileImage() {
    var box = Hive.box<Profile>('profileBox');
    Profile? profile = box.get('userProfile');
    if (profile != null) {
      setState(() {
        _profileImage = File(profile.photoPath); // Convert stored path to File
      });
    }
  }

  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.lightGreenAccent,
                child: Center(
                  child: SizedBox(
                    width:
                        double.infinity, // Forces the Stack to take full width
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 100,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 65,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!) // Show stored image
                                : null,
                          ),
                        ),
                        Positioned(
                          top: 194,
                          right: MediaQuery.of(context).size.width *
                              0.35, // Adjust position dynamically
                          child: GestureDetector(
                            onTap: () async {
                              //gvvdfvcdfgggtu
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
                              child: GestureDetector(
                                onTap: () {
                                  var box = Hive.box<Profile>('profileBox');
                                  var profile = box.get('userProfile');
                                  String? name = profile?.name;
                                  String? phoneNumber = profile?.phoneNumber;
                                  String? dateOfBirth = profile?.dateOfBirth;
                                  String? gender = profile?.gender;
                                  String? bloodGroup = profile?.bloodGroup;
                                  String? city = profile?.city;
                                  String? profileImage = profile?.photoPath;

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyDetails(
                                              name: name,
                                              phoneNumber: phoneNumber,
                                              dateOfBirth: dateOfBirth,
                                              gender: gender,
                                              bloodGroup: bloodGroup,
                                              city: city,
                                              photoPath: profileImage)));
                                },
                                child: const Icon(
                                  Icons.person_search,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 260, // Position below profile picture
                          child: Text(
                            widget.name ??
                                "Guest", // Show name or fallback to 'Guest'
                            style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.bloodtype,
                                      color: Colors.red,
                                      size: 48), // Blood Group Icon
                                  SizedBox(height: 5), // Small spacing
                                  Text(
                                    'Blood Group',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    widget.bloodGroup ?? 'Not Available',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              // Blood Group Icon
                              SizedBox(width: 120),
                              Column(
                                children: [
                                  Icon(Icons.location_city,
                                      color: Colors.blue, size: 48),
                                  SizedBox(height: 5),
                                  Text(
                                    'City',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    widget.city ?? 'Not Available',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ), // Spacing
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10), // Padding for spacing
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, // Space the rows equally
                  children: [
                    InkWell(
                      onTap: () async {
                        var box = Hive.box<Profile>('profileBox');
                        var profile = box
                            .get('userProfile'); // Retrieve the stored profile

                        if (profile != null) {
                          final updatedProfile = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditProfileScreen(profile: profile)),
                          );
                          if (updatedProfile != null) {
                            setState(() {
                              _loadProfileImage();
                              widget.name = updatedProfile.name;
                              widget.bloodGroup = updatedProfile.bloodGroup;
                              widget.city = updatedProfile.city;
                            });
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.edit_square, color: Colors.black),
                          SizedBox(width: 16),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicy()));
                      },
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // Align text to the left
                        children: [
                          Icon(Icons.privacy_tip, color: Colors.black),
                          SizedBox(width: 16),
                          Text(
                            'Privacy Policy',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                    ),

                    // Third Row
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HelpSupportScreen()));
                      },
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.start, // Align text to the left
                        children: [
                          Icon(Icons.help_outline, color: Colors.black),
                          SizedBox(width: 16),
                          Text(
                            'Help and Support',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ButtonNavigation(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            NavigateScreen(context, index);
          }),
    );
  }
}
