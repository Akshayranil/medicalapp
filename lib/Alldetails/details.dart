import 'package:flutter/material.dart';
import 'dart:io';

import 'package:week7/profileModel/model.dart';

class MyDetails extends StatefulWidget {
  final String? name;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? bloodGroup;
  final String? city;
  final String? photoPath;

  MyDetails(
      {super.key,
      required this.name,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.gender,
      required this.bloodGroup,
      required this.city,
      required this.photoPath
      });

  @override
  State<MyDetails> createState() => _MyDetailsState();
  // File? photoPath;
}

class _MyDetailsState extends State<MyDetails> {
  @override
  Widget build(BuildContext context) {
    print("photopath :${widget.photoPath}");
    // List to store user details dynamically
    List<Map<String, String?>> userDetails = [
      {'label': 'Name', 'value': widget.name},
      {'label': 'Phone Number', 'value': widget.phoneNumber},
      {'label': 'Date of Birth', 'value': widget.dateOfBirth},
      {'label': 'Gender', 'value': widget.gender},
      {'label': 'Blood Group', 'value': widget.bloodGroup},
      {'label': 'City', 'value': widget.city},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: const Text("Profile Details"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Profile Picture
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 65,
            backgroundImage: widget.photoPath != null
                ? FileImage(File(widget.photoPath!)) // Load image if available
                : null,
            child: widget.photoPath == null
                ? const Icon(Icons.person,
                    size: 60, color: Colors.white) // Default icon
                : null,
          ),

          const SizedBox(height: 20),

          // ListView for User Details with Divider
          Expanded(
            child: ListView.separated(
              itemCount: userDetails.length,
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 15,
                endIndent: 15,
              ),
              itemBuilder: (context, index) {
                final item = userDetails[index];

                return ListTile(
                  title: Text(
                    item['label']!,
                    style: const TextStyle(
                         fontSize: 16),
                  ),
                  subtitle: Text(
                    item['value'] ?? "Not Available",
                    style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
