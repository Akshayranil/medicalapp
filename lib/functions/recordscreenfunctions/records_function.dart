import 'dart:io';
import 'package:flutter/material.dart';

void showFullImage(BuildContext context, String imagePath) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.black, // Set background to black for a better view
      insetPadding: EdgeInsets.zero, // Remove default padding
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context), // Close on tap
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black, // Black background for fullscreen effect
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain, // Adjust fit as needed (cover, contain, fitWidth, etc.)
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    ),
  );
}
