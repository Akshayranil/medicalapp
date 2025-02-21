import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome to V-Care . We respect your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your data when you use our App.",style: TextStyle(fontSize: 18),),
              SizedBox(height: 20,),
              Text("Information We Collect",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("We collect the following types of information:",style: TextStyle(fontSize: 16),),
              SizedBox(height: 10,),
              Text("Personal Information:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("When you use our App, we may collect personal details, including:\n\n Name \n Phone number \n address \n Date of birth \n Gender \n Blood group \n Medical history "
              ),
              SizedBox(height: 10,),
              Text("How We Use Your Information:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("We use your information to:\n\nProvide and improve our medical services\nStore and manage health records securely\nSend reminders for appointments and medications\nRespond to inquiries and customer support requests\nComply with legal and regulatory requirements"),
              SizedBox(height: 10,),
              Text(" Data Security:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("We take data protection seriously and implement measures such as:\n\nEncryption: Your data is encrypted during storage and transmission.\nAccess Controls: Only authorized users can access sensitive information.\nRegular Audits: We monitor and update our security practices regularly."),
              SizedBox(height: 10,),
              Text("Third-Party Links and Services:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("Our App may contain links to third-party websites or services. We are not responsible for their privacy policies, so we recommend reviewing their policies separately."),
              SizedBox(height: 10,),
              Text("Changes to This Privacy Policy:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("We may update this Privacy Policy from time to time. Changes will be notified through the App or our website"),
              SizedBox(height: 10,),
              Text("Contact Us:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("If you have any questions about this Privacy Policy, please contact us at:\n\n 📧 Email: Vcareforyou@gmail.com\n\n 🌐 Website: www.Vcarehealth@gmail.com")
            ],
          ),
          ),
      ),
        
    );
  }
}
