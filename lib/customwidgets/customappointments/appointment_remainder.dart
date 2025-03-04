import 'package:flutter/material.dart';

class ReminderDropdown extends StatefulWidget {
  final Function(int?) onReminderSelected;

  const ReminderDropdown({super.key, required this.onReminderSelected});

  @override
  _ReminderDropdownState createState() => _ReminderDropdownState();
}

class _ReminderDropdownState extends State<ReminderDropdown> {
  int? selectedReminder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Set Reminder", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        DropdownButton<int>(
          value: selectedReminder,
          hint: const Text('Select reminder time'),
          items: const [
            DropdownMenuItem(child: Text('30 Minutes before'), value: 30),
            DropdownMenuItem(child: Text('60 Minutes before'), value: 60),
            DropdownMenuItem(child: Text('120 Minutes before'), value: 120),
            DropdownMenuItem(child: Text('240 Minutes before'), value: 240),
          ],
          onChanged: (int? value) {
            setState(() => selectedReminder = value);
            widget.onReminderSelected(value);
          },
        ),
      ],
    );
  }
}
