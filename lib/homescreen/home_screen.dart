import 'package:flutter/material.dart';
import 'package:week7/functions/general_functions.dart';
import 'package:week7/homescreen/home_functions.dart';

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
    checkAndShowWarning(context);
  }
  int _selectedIndex = 0;
  

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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
        bottomNavigationBar: ButtonNavigation(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              NavigateScreen(context, index);
            }));
  }
}
