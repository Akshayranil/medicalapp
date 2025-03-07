import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/functions/general_functions.dart';
import 'package:week7/profilemodel/model.dart';

class ViewTrends extends StatefulWidget {
  const ViewTrends({super.key});

  @override
  State<ViewTrends> createState() => _ViewTrendsState();
}

class _ViewTrendsState extends State<ViewTrends>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final box = Hive.box<VitalsModel>('vitalsBox');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TabBar inside View Trends
        TabBar(
          isScrollable: true, // Allows scrolling if there are many tabs
          controller: _tabController,
          tabs: [
            Tab(text: "BP"),
            Tab(text: "Pulse"),
            Tab(text: "Temperature"),
            Tab(text: "SpO2"),
            Tab(text: "Exercise"),
            Tab(text: "Weight"),
          ],
        ),

        // TabBarView to display vitals
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildVitalsList('bp'), // BP Tab
              _buildVitalsList('pulse'), // Pulse Tab
              _buildVitalsList('temperature'), // Temperature Tab
              _buildVitalsList('spo2'), // SpO2 Tab
              _buildVitalsList('exercise'), // Exercise Tab
              _buildVitalsList('weight'), // Weight Tab
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVitalsList(String category) {
    return ListView.builder(
      itemCount: box.length,
      itemBuilder: (context, index) {
        final vitals = box.getAt(index) as VitalsModel;

        String? value;
        String unit = "";

        switch (category) {
          case 'bp':
            value = vitals.bp;
            unit = "";
            break;
          case 'pulse':
            value = vitals.pulse;
            unit = " bpm";
            break;
          case 'temperature':
            value = vitals.temperature;
            unit = "°C";
            break;
          case 'spo2':
            value = vitals.spo2;
            unit = "%";
            break;
          case 'exercise':
            value = vitals.exercise;
            unit = " min";
            break;
          case 'weight':
            value = vitals.weight;
            unit = " kg";
            break;
        }

        if (value == null || value.isEmpty) return SizedBox.shrink();

        return Card(
  margin: EdgeInsets.all(10),
  child: ListTile(
    title: Text("$category: $value$unit"),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date: ${vitals.vitaldate}", style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
    trailing: IconButton(
      onPressed: () {
        showDeleteConfirmationDialog(
          context,
          "Are you sure you want to delete $category?",
          () {
            _deleteVital(index, category);
          },
        );
      },
      icon: Icon(Icons.delete, color: Colors.red),
    ),
  ),
);

      },
    );
  }

  void _deleteVital(int index, String category) {
  final vitals = box.getAt(index) as VitalsModel;

  switch (category) {
    case 'bp':
      vitals.bp = '';
      break;
    case 'pulse':
      vitals.pulse = '';
      break;
    case 'temperature':
      vitals.temperature = '';
      break;
    case 'spo2':
      vitals.spo2 = '';
      break;
    case 'exercise':
      vitals.exercise = '';
      break;
    case 'weight':
      vitals.weight = '';
      break;
  }

  // Update the record back to Hive
  box.putAt(index, vitals);

  setState(() {}); // Refresh UI
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$category deleted successfully!')),
  );
}

}
