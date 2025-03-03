import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  void _submitFeedback() {
    String feedback = _feedbackController.text.trim();
    if (feedback.isNotEmpty) {
      // Here, you can send the feedback to your server or email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thank you for your feedback!")),
      );
      _feedbackController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter your feedback before submitting.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback & Report Issue"),backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Your Feedback"),
            _buildSectionContent(
                "Let us know your experience with the app. Your feedback helps us improve!"),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Enter your feedback or report an issue...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitFeedback,style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text("Submit Feedback",style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle("Contact Support"),
            _buildSectionContent(
                "If you are facing issues, contact us at:"),
            SizedBox(height: 5),
            SelectableText(
              "support@medicalapp.com",
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
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
