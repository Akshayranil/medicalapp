import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:week7/profilemodel/model.dart';

class BloodGlucoseScreen extends StatefulWidget {
  @override
  BloodGlucoseScreenState createState() => BloodGlucoseScreenState();
}

class BloodGlucoseScreenState extends State<BloodGlucoseScreen> {
 final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _glucoseController = TextEditingController();
  int _selectedRadioValue = 1;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    // Automatically set the current date and time when the screen is loaded
    DateTime now = DateTime.now();
    _dateController.text = DateFormat('yyyy-MM-dd').format(now);
    _timeController.text = DateFormat('HH:mm:ss').format(now);
  }

  void _saveBloodGlucoseRecord() async {
    // Get the values from the controllers and radio buttons
    if (_formKey.currentState!.validate()) {
      String date = _dateController.text;
      String time = _timeController.text;
      double glucoseLevel =
          double.parse(_glucoseController.text); // Convert to double
      int foodIntakeStatus = _selectedRadioValue; // Get food intake status

      // Create a new BloodGlucoseRecord object
      BloodGlucoseRecord record = BloodGlucoseRecord(
        date: date,
        time: time,
        glucoseLevel: glucoseLevel,
        foodIntakeStatus: foodIntakeStatus,
      );

      // Open the box
      var box = await Hive.openBox<BloodGlucoseRecord>('bloodGlucoseRecords');

      // Add the record to the box
      await box.add(record);

      // Optionally show a confirmation message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Record saved successfully')));
      // _retrieveBloodGlucoseRecords();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                readOnly: true,
                // Make it read-only to prevent editing
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time'),
                readOnly: true, // Make it read-only to prevent editing
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Glucose Reading',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _glucoseController,
                        decoration: InputDecoration(hintText: 'eg-110 mg/dL',
                        border: InputBorder.none
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a glucose reading';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Food intake Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRadioOption('Fasting Blood Sugar', 1),
                  _buildRadioOption('Before Meal', 2),
                  _buildRadioOption('After Meals(2hrs)', 3),
                  _buildRadioOption('Random Blood Sugar', 4),
                ],
              ),
              SizedBox(
                height: 120,
              ),
              // Add other fields for blood glucose value, etc.
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        _saveBloodGlucoseRecord();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 60),
                          backgroundColor: Colors.lightGreenAccent),
                      child: Text('Save'))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String title, int value) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: _selectedRadioValue,
          onChanged: (int? newValue) {
            setState(() {
              _selectedRadioValue = newValue!;
            });
          },
        ),
        Text(title),
      ],
    );
  }

  // void _retrieveBloodGlucoseRecords() async {
  //   var box = await Hive.openBox<BloodGlucoseRecord>('bloodGlucoseRecords');
  //   List<BloodGlucoseRecord> records = box.values.toList(); // Get all records

  //   // Print or display the records
  //   for (var record in records) {
  //     print(record.date);
  //     print(record.time);
  //     print(record.glucoseLevel);
  //     print(record.foodIntakeStatus);
  //   }
  // }
}
