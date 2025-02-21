import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:week7/profilemodel/model.dart';

class AddVitals extends StatefulWidget {
  const AddVitals({super.key});

  @override
  State<AddVitals> createState() => _AddVitalsState();
}

class _AddVitalsState extends State<AddVitals> {
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String time = DateFormat('hh:mm a').format(DateTime.now());
  final TextEditingController bpController = TextEditingController();
  final TextEditingController pulseController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  final TextEditingController spo2Controller = TextEditingController();
  final TextEditingController exerciseController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  bool _isBpAdded = false;
  bool _isPulseAdded = false;
  bool _isTempAdded = false;
  bool _isSpo2Added = false;
  bool _isExerciseAdded = false;
  bool _isWeightAdded = false;

  @override
  void initState() {
    super.initState();
    _checkVitalsForToday();
  }

  void _checkVitalsForToday() {
    final box = Hive.box<VitalsModel>('vitalsBox');
    final vitals = box.get(date);

    if (vitals != null) {
      setState(() {
        _isBpAdded = vitals.bp.isNotEmpty;
        _isPulseAdded = vitals.pulse.isNotEmpty;
        _isTempAdded = vitals.temperature.isNotEmpty;
        _isSpo2Added = vitals.spo2.isNotEmpty;
        _isExerciseAdded = vitals.exercise.isNotEmpty;
        _isWeightAdded = vitals.weight.isNotEmpty;
      });
    }
  }

  void saveVital(String key, TextEditingController controller) async {
    if (controller.text.isEmpty) return;

    final box = Hive.box<VitalsModel>('vitalsBox');
    String currentTime = DateFormat('hh:mm a').format(DateTime.now());
    var vitals = box.get(date) ??
        VitalsModel(
          vitaldate: date,
          vitaltime: currentTime,
          bp: '',
          pulse: '',
          temperature: '',
          spo2: '',
          exercise: '',
          weight: '',
        );

    switch (key) {
      case 'bp':
        vitals.bp = controller.text;
        vitals.vitaltime = currentTime;
        _isBpAdded = true;
        break;
      case 'pulse':
        vitals.pulse = controller.text;
        vitals.vitaltime = currentTime;
        _isPulseAdded = true;
        break;
      case 'temperature':
        vitals.temperature = controller.text;
        vitals.vitaltime = currentTime;
        _isTempAdded = true;
        break;
      case 'spo2':
        vitals.spo2 = controller.text;
        vitals.vitaltime = currentTime;
        _isSpo2Added = true;
        break;
      case 'exercise':
        vitals.exercise = controller.text;
        vitals.vitaltime = currentTime;
        _isExerciseAdded = true;
        break;
      case 'weight':
        vitals.weight = controller.text;
        vitals.vitaltime = currentTime;
        _isWeightAdded = true;
        break;
    }

    await box.put(date, vitals);
    setState(() {
      time = currentTime;
    }); // Refresh UI to disable field

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$key added for today!')));
  }
  

  Widget buildVitalInput(String label, TextEditingController controller,
      bool isDisabled, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          enabled: !isDisabled,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: isDisabled ? "Already added today" : "Enter $label",
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: isDisabled ? null : () => saveVital(key, controller),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDisabled ? Colors.grey : Colors.lightGreenAccent,
            minimumSize: Size(200, 40),
          ),
          child: Text(isDisabled ? "Added" : "Save"),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date'),
            Card(child: Text(date)),
            SizedBox(height: 20),
            Text('Time'),
            Card(child: Text(time)),
            SizedBox(height: 20),
            buildVitalInput(
                "Blood Pressure (BP)", bpController, _isBpAdded, 'bp'),
            buildVitalInput(
                "Pulse Rate", pulseController, _isPulseAdded, 'pulse'),
            buildVitalInput("Temperature (°C)", tempController, _isTempAdded,
                'temperature'),
            buildVitalInput("SpO2 (%)", spo2Controller, _isSpo2Added, 'spo2'),
            buildVitalInput("Exercise (min)", exerciseController,
                _isExerciseAdded, 'exercise'),
            buildVitalInput(
                "Weight (kg)", weightController, _isWeightAdded, 'weight'),
          ],
        ),
      ),
    );
  }
}
