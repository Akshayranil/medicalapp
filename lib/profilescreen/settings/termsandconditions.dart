import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms and Conditions"),backgroundColor: Colors.lightGreenAccent,),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Terms and Conditions",
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
                  "By using this app, you agree to abide by these Terms and Conditions. "
                  "If you do not agree, please discontinue use immediately."),
              _buildSectionTitle("2. Medical Disclaimer"),
              _buildSectionContent(
                  "This app provides general health and wellness information. It does not replace professional medical advice, diagnosis, or treatment. "
                  "Always consult a qualified healthcare provider before making any medical decisions."),
              _buildSectionTitle("3. User Responsibilities"),
              _buildSectionContent(
                  "- You must provide accurate health data.\n"
                  "- You are responsible for managing your medication and appointments.\n"
                  "- Do not share sensitive medical data with unauthorized persons."),
              _buildSectionTitle("4. Data Privacy"),
              _buildSectionContent(
                  "We respect your privacy. All health data is stored securely and will not be shared without consent. "
                  "Refer to our Privacy Policy for more details."),
              _buildSectionTitle("5. Limitation of Liability"),
              _buildSectionContent(
                  "We are not liable for any medical complications arising from the use of this app. "
                  "Users must verify all health-related information with a certified medical professional."),
              _buildSectionTitle("6. Updates and Changes"),
              _buildSectionContent(
                  "We reserve the right to update these Terms and Conditions at any time. Continued use of the app signifies your acceptance of changes."),
              _buildSectionTitle("7. Contact Information"),
              _buildSectionContent(
                  "If you have any questions, contact us at support@medicalapp.com."),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Accept & Continue"),
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
