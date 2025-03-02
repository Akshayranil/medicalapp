import 'package:flutter/material.dart';
import 'package:week7/profilescreen/settings/appversion.dart';
import 'package:week7/profilescreen/settings/disclaimer.dart';
import 'package:week7/profilescreen/settings/feedback.dart';
import 'package:week7/profilescreen/settings/privacy.dart';
import 'package:week7/profilescreen/settings/termsandconditions.dart';

class Settings extends StatelessWidget {
  final List<Map<String, dynamic>> settingsItems = [
    {"title": "Terms and Conditions", "route": TermsScreen(),"icons":Icons.article},
    {"title": "Privacy Policy", "route": PrivacyScreen(),"icons":Icons.lock_outline},
    {"title": "Disclaimer", "route": DisclaimerScreen(),"icons":Icons.warning_amber_rounded},
    {"title": "App Version & Update", "route": VersionScreen(),"icons":Icons.system_update},
    {"title": "Feedback & Report Issue", "route": FeedbackScreen(),"icons":Icons.feedback},
  ];

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"), backgroundColor: Colors.lightGreenAccent),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: settingsItems.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(settingsItems[index]["title"]),
                  leading: Icon(settingsItems[index]["icons"]),
                  onTap: () => _navigateTo(context, settingsItems[index]["route"]),
                );
              },
            ),
          ),
          // Version Name at the Bottom
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                "App Version 1.0.0",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
