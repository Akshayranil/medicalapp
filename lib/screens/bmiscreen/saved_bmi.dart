import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week7/profilemodel/model.dart';

class SavedBMI extends StatelessWidget {
  const SavedBMI({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<BMIResult>('bmiBox');

    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Box<BMIResult> box, _) {
              if (box.isEmpty) {
                return Center(
                  child: Text('No BMI data saved yet'),
                );
              } else {
                return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final bmiResult = box.getAt(index);
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                              "BMI : ${bmiResult!.bmi.toStringAsFixed(1)}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                          subtitle: Text(
                              "Height: ${bmiResult.height.toInt()} cm, Weight: ${bmiResult.weight.toInt()} kg\nDate: ${bmiResult.bmidate}"),
                          trailing: IconButton(
                              onPressed: () => deleteBMI(context, box, index),
                              icon: Icon(Icons.delete)),
                        ),
                      );
                    });
              }
            }));
  }

  void deleteBMI(BuildContext context, Box<BMIResult> box, int index) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete Confirmation'),
              content: Text('Are you sure you want to delete this record?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      box.deleteAt(index);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('BMI Record deleted')));
                    },
                    child: Text("Delete",style: TextStyle(color: Colors.red),))
              ],
            ));
  }
}
