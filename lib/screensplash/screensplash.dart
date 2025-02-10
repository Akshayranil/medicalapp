import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/SlideScreen/slidescreen.dart';
import 'package:week7/homescreen/homescreen.dart';
import 'package:week7/profileModel/model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkProfileData();
  }

  void _checkProfileData() async {
    
    await Future.delayed(Duration(seconds: 3));

    var box = await Hive.openBox<Profile>('ProfileBox');
    
    // Check if profile data exists
    if (box.isNotEmpty) {
      // Retrieve the profile instance from Hive
      var profile = box.getAt(0); // Assuming there's only one profile saved
      
      if (profile != null) {
        // Pass the profile name (or other data) to ScreenHome
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenHome(userName: profile.name),
          ),
        );
      }
    } else {
      // If profile doesn't exist, navigate to SlideScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SlideViewScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/medical-removebg-preview.png'),
            Text(
              'V-Care',
              style: TextStyle(fontSize: 60, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
