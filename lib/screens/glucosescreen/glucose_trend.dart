import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/profilemodel/model.dart';

class GlucoseTrendScreen extends StatefulWidget {
  @override
  _GlucoseTrendScreenState createState() => _GlucoseTrendScreenState();
}

class _GlucoseTrendScreenState extends State<GlucoseTrendScreen> {
  late Box<BloodGlucoseRecord> _box;
  List<BloodGlucoseRecord> _records = [];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  // Load records from Hive
  void _loadRecords() async {
    _box = await Hive.openBox<BloodGlucoseRecord>('bloodGlucoseRecords');
    setState(() {
      _records = _box.values.toList(); // Get all records
    });
  }

  // Delete a record from Hive
  void _deleteRecord(int index) async {
    await _box.deleteAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Record deleted successfully')),
    );
    _loadRecords(); // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _records.length,
      itemBuilder: (context, index) {
        final record = _records[index];
        return Card(
          margin: EdgeInsets.all(8),
          elevation: 4,
          child: ListTile(
            
            title: Text('Date: ${record.date}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( 'Time: ${record.time}'),
                Text('Glucose Level: ${record.glucoseLevel} mg/dL',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                Text('Food Intake: ${_getFoodIntakeStatus(record.foodIntakeStatus)}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteRecord(index),
            ),
          ),
        );
      },
    );
  }

  String _getFoodIntakeStatus(int status) {
    switch (status) {
      case 1:
        return 'Fasting Blood Sugar';
      case 2:
        return 'Before Meal';
      case 3:
        return 'After Meals (2hrs)';
      case 4:
        return 'Random Blood Sugar';
      default:
        return 'Unknown';
    }
  }
}
