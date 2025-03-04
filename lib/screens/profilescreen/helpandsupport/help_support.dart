import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help you?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions or need assistance, check our FAQs or contact us.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text('How do I book an appointment?'),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Go to the Appointments section and select your preferred doctor and time.'),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('How do I access my medical records?'),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Navigate to the Medical Records section in your profile.'),
                ),
              ],
            ),
            Spacer(),
            Text('Contact Us:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blueAccent),
              title: Text('support@medicalapp.com'),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blueAccent),
              title: Text('+1 234 567 8900'),
            ),
          ],
        ),
      ),
    );
  }
}
