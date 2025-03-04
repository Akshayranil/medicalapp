import 'package:flutter/material.dart';

class VitalInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  VitalInputField({required this.label, required this.controller,this.enabled=true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        enabled: enabled,
      ),
    );
  }
}
