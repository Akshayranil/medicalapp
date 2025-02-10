import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/MedicineScreen/mymedicine.dart';
import 'package:week7/ScreenProfile/screenProfile.dart';
import 'package:week7/profileModel/model.dart';

class ScreenHome extends StatefulWidget {
  final String userName;
  const ScreenHome({super.key, required this.userName});

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _selectedIndex = 0;

  // List of data for each card
  final List<Map<String, dynamic>> cardData = [
    {'image': 'assets/images/glucose.jpg', 'title': 'Blood Glucose'},
    {'image': 'assets/images/med2.jpg', 'title': 'My Medicine','screen':MyMedicine()},
    {'image': 'assets/images/vital.webp', 'title': 'My Vitals'},
    {'image': 'assets/images/BMI.webp', 'title': 'BMI Calculator'},
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
              builder: (context) => ScreenProfile(bloodGroup: bloodGroup,city: city,)));
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
                padding: EdgeInsets.only(top: 40,right: 130),
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
                             MaterialPageRoute(builder: (context) => data['screen']),
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
}
