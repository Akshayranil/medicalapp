import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String textName;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textName
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
