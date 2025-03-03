import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldProfile extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool readOnly;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;

  const CustomTextFieldProfile({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: const Color.fromARGB(60, 128, 126, 126),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Please enter $label' : null,
      ),
    );
  }
}
