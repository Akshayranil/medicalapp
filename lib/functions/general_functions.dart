import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/appointmentscreen/appointment_screen.dart';
import 'package:week7/homescreen/home_screen.dart';
import 'package:week7/profilemodel/model.dart';
import 'package:week7/profilescreen/profile_screen.dart';
import 'package:week7/recordscreen/record_screen.dart';

class ButtonNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const ButtonNavigation({super.key,required this.currentIndex,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: Colors.black, // Set the background color of the bar
        selectedItemColor: Colors.blue, // Color for the selected icon
        unselectedItemColor: Colors.grey, // Color for the unselected icons
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      );
  }
}

Future<void> NavigateScreen(BuildContext context, int index) async {
  if (index == 3) {
    var box = Hive.box<Profile>('profileBox'); // Use the already opened box

    var profile = box.get('userProfile');
    String? bloodGroup = profile?.bloodGroup;
    String? city = profile?.city;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScreenProfile(
                bloodGroup: bloodGroup, city: city, name: profile?.name)));
  }
  if (index == 2) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyAppointment()));
  }

  if (index == 1) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyRecords()));
  }

  if (index == 0) {
    var box = Hive.box<Profile>('profileBox'); 
    var profile = box.get('userProfile');
    String? userName = profile?.name; 
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ScreenHome(userName: userName!)));
  }
}
