import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/functions/general_functions.dart';
import 'package:week7/functions/profilescreenfunctions/profilescreen_function.dart';
import 'package:week7/profilemodel/model.dart';
import 'package:week7/screens/profilescreen/helpandsupport/help_support.dart';
import 'package:week7/screens/profilescreen/settings/settings.dart';

// ignore: must_be_immutable
class ScreenProfile extends StatefulWidget {
  ScreenProfile({super.key, required this.bloodGroup, required this.city, required this.name});

  String? bloodGroup;
  String? city;
  String? name;

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  File? _profileImage;
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  /// Load the profile image using helper function
  Future<void> _loadProfileImage() async {
    _profileImage = await loadProfileImage();
    setState(() {});
  }

   void updateUI() {
    var box = Hive.box<Profile>('profileBox');
    var updatedProfile = box.get('userProfile');

    if (updatedProfile != null) {
      setState(() {
        widget.name = updatedProfile.name;
        widget.bloodGroup = updatedProfile.bloodGroup;
        widget.city = updatedProfile.city;
        _loadProfileImage();  // Reload profile image if changed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 100,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 65,
                            backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                            child: _profileImage == null
                          ? const Icon(Icons.person, size: 95, color: Colors.black)
                          : null, 
                          ),
                        ),
                        Positioned(
                          top: 194,
                          right: MediaQuery.of(context).size.width * 0.35,
                          child: GestureDetector(
                            onTap: () => navigateToDetailsScreen(context), // Call helper function
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
                                ],
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(Icons.person_search, color: Colors.black, size: 20),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 260,
                          child: Text(
                            widget.name ?? "Guest",
                            style: const TextStyle(fontSize: 29, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  const Icon(Icons.bloodtype, color: Colors.red, size: 48),
                                  const SizedBox(height: 5),
                                  const Text('Blood Group', style: TextStyle(fontSize: 16)),
                                  const SizedBox(height: 5),
                                  Text(
                                    widget.bloodGroup ?? 'Not Available',
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 120),
                              Column(
                                children: [
                                  const Icon(Icons.location_city, color: Colors.blueGrey, size: 48),
                                  const SizedBox(height: 5),
                                  const Text('City', style: TextStyle(fontSize: 16)),
                                  const SizedBox(height: 5),
                                  Text(
                                    widget.city ?? 'Not Available',
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => navigateToEditProfile(context, updateUI),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.edit_square, color: Colors.black),
                          SizedBox(width: 16),
                          Text('Edit Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 1),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Settings())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.settings, color: Colors.black),
                          SizedBox(width: 16),
                          Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 1),
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportScreen())),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.help_outline, color: Colors.black),
                          SizedBox(width: 16),
                          Text('Help and Support', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
        },
      ),
    );
  }
}
