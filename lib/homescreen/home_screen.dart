import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/appointmentscreen/appointment_screen.dart';
import 'package:week7/bmiscreen/bmi_main.dart';

import 'package:week7/bmiscreen/bmi_screen.dart';
import 'package:week7/glucosescreen/glucose_screen.dart';
import 'package:week7/medicinescreen/medicine_view.dart';

import 'package:week7/profilemodel/model.dart';
import 'package:week7/profilescreen/profile_screen.dart';
import 'package:week7/recordscreen/record_screen.dart';
import 'package:week7/vitalsscreen/vitals_screen.dart';

class ScreenHome extends StatefulWidget {
  final String userName;
  const ScreenHome({super.key, required this.userName});

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    _checkAndShowWarning();
  }

  int _selectedIndex = 0;

  // List of data for each card
  final List<Map<String, dynamic>> cardData = [
    {
      'image': 'assets/images/glucose.jpg',
      'title': 'Blood Glucose',
      'screen': GlucoseScreen()
    },
    {
      'image': 'assets/images/med2.jpg',
      'title': 'My Medicine',
      'screen': MedicineScreen()
    },
    {
      'image': 'assets/images/vital.webp',
      'title': 'My Vitals',
      'screen': MyVitals()
    },
    {
      'image': 'assets/images/BMI.webp',
      'title': 'BMI Calculator',
      'screen': BMIMain()
    },
  ];

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

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

    if(index ==1) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyRecords()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40, right: 130),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Hello ${widget.userName}", // Display the name
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/doctor2.jpg',
                  height: 190,
                  width: 367,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 35),
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Health Manager',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30.0,
                    mainAxisSpacing: 30.0,
                    childAspectRatio: 1,
                  ),
                  padding: const EdgeInsets.all(35.0),
                  itemCount: cardData.length,
                  itemBuilder: (context, index) {
                    final data = cardData[index];
                    return InkWell(
                      onTap: () {
                        if (data['screen'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => data['screen']),
                          );
                        }
                      },
                      child: Card(
                        margin: const EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 3.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                data['image']!,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              data['title']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black, // Set the background color of the bar
        selectedItemColor: Colors.green, // Color for the selected icon
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
      ),
    );
  }

//--------------------------------------------------------------------
  void _checkAndShowWarning() async {
    var settingsBox = Hive.box('settingsBox');
    bool showWarning =
        settingsBox.get('lowMedicineWarning', defaultValue: false);

    if (showWarning) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLowMedicinePopup();
      });

      // Reset flag so popup doesn't show again unnecessarily
      settingsBox.put('lowMedicineWarning', false);
    }
  }

  void _showLowMedicinePopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.amber,
        title: Center(
            child: Text(
          "Warning",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
        )), // Centering title
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "One of your medicines has a count less than 2.\nPlease restock soon.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500), // Centering content
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center, // Centering button
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red, // Red background
              foregroundColor: Colors.white, // White text
            ),
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
