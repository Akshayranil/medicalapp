import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Privacy Policy"),backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Last Updated: March 2025",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 20),
              _buildSectionTitle("1. Introduction"),
              _buildSectionContent(
                  "We respect your privacy and are committed to protecting your personal and medical information. "
                  "This Privacy Policy explains how we collect, use, and safeguard your data."),
              _buildSectionTitle("2. Information We Collect"),
              _buildSectionContent(
                  "- **Personal Data:** Name, email, phone number, and other profile details.\n"
                  "- **Health Data:** Medical history, prescriptions, and health vitals.\n"
                  "- **Usage Data:** App activity, preferences, and device information."),
              _buildSectionTitle("3. How We Use Your Information"),
              _buildSectionContent(
                  "- To provide health-related services and reminders.\n"
                  "- To improve app functionality and user experience.\n"
                  "- To comply with legal requirements and ensure data security."),
              _buildSectionTitle("4. Data Security"),
              _buildSectionContent(
                  "We implement strong security measures to protect your data. However, no system is 100% secure, "
                  "so we encourage users to be cautious when sharing sensitive information."),
              _buildSectionTitle("5. Third-Party Sharing"),
              _buildSectionContent(
                  "We **do not sell or share** your personal data with third parties, except:\n"
                  "- When required by law.\n"
                  "- With your explicit consent.\n"
                  "- With healthcare providers if authorized by you."),
              _buildSectionTitle("6. Your Rights"),
              _buildSectionContent(
                  "- Access your stored data.\n"
                  "- Request data deletion.\n"
                  "- Opt-out of non-essential data collection."),
              _buildSectionTitle("7. Updates to This Policy"),
              _buildSectionContent(
                  "We may update this Privacy Policy periodically. Continued use of the app signifies acceptance of the new policy."),
              _buildSectionTitle("8. Contact Information"),
              _buildSectionContent(
                  "If you have questions about our Privacy Policy, contact us at support@medicalapp.com."),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("Accept & Continue",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
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
