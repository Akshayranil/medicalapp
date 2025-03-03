import 'package:flutter/material.dart';

class DisclaimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Disclaimer"),backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Medical Disclaimer",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Last Updated: March 2025",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 20),
              _buildSectionTitle("1. General Information"),
              _buildSectionContent(
                  "This app is designed for informational and educational purposes only. "
                  "It is not intended to be a substitute for professional medical advice, diagnosis, or treatment."),
              _buildSectionTitle("2. No Doctor-Patient Relationship"),
              _buildSectionContent(
                  "Using this app **does not create a doctor-patient relationship**. "
                  "Always consult with a qualified healthcare provider for medical concerns."),
              _buildSectionTitle("3. No Emergency Services"),
              _buildSectionContent(
                  "This app does not provide emergency medical services. In case of a medical emergency, please call your local emergency number immediately."),
              _buildSectionTitle("4. Accuracy of Information"),
              _buildSectionContent(
                  "While we strive to provide accurate and up-to-date information, we **do not guarantee** "
                  "the accuracy, completeness, or reliability of any health-related content in this app."),
              _buildSectionTitle("5. User Responsibility"),
              _buildSectionContent(
                  "Users are responsible for how they interpret and use the information provided. "
                  "We are not liable for any harm or damage resulting from the use of this app."),
              _buildSectionTitle("6. External Links"),
              _buildSectionContent(
                  "This app may contain links to third-party websites for additional health information. "
                  "We are not responsible for the content or privacy practices of external sites."),
              _buildSectionTitle("7. Changes to This Disclaimer"),
              _buildSectionContent(
                  "We reserve the right to update this disclaimer at any time. "
                  "Continued use of the app signifies your acceptance of the latest terms."),
              _buildSectionTitle("8. Contact Information"),
              _buildSectionContent(
                  "For any concerns related to this disclaimer, please contact us at support@medicalapp.com."),
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
