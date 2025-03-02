import 'package:flutter/material.dart';


class VersionScreen extends StatefulWidget {
  @override
  _VersionScreenState createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  String appVersion = "Loading...";
  String buildNumber = "Loading...";

  @override
  void initState() {
    super.initState();
    
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Version & Update"),backgroundColor: Colors.lightGreenAccent),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("App Version"),
            _buildSectionContent("Version: $appVersion (Build $buildNumber)"),
            SizedBox(height: 20),
            _buildSectionTitle("Check for Updates"),
            ElevatedButton(
              onPressed: () {
                _checkForUpdate();
              },
              child: Text("Check for Updates"),
            ),
            SizedBox(height: 20),
            _buildSectionTitle("Automatic Updates"),
            _buildSectionContent(
                "Ensure you have automatic updates enabled in your device settings to stay updated with the latest features."),
          ],
        ),
      ),
    );
  }

  void _checkForUpdate() {
    // Placeholder function - Normally, you would check for updates from an API
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Check for Updates"),
        content: Text("You are using the latest version of the app."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16),
    );
  }
}
