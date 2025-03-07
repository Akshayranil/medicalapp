import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:week7/functions/general_functions.dart';
import 'package:week7/functions/recordscreenfunctions/records_function.dart';

import 'package:week7/profilemodel/model.dart';
import 'package:week7/screens/recordscreen/add_record.dart';

class MyRecords extends StatefulWidget {
  const MyRecords({super.key});

  @override
  State<MyRecords> createState() => _MyRecordsState();
}

class _MyRecordsState extends State<MyRecords>
    with SingleTickerProviderStateMixin {
  List<Records> allRecords = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadRecords();
  }

  int _selectedIndex = 1;

  Future<void> _loadRecords() async {
    final box = Hive.box<Records>('records');
    setState(() {
      allRecords = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding: EdgeInsets.only(left: 20), child: Text('My Records')),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          tabs: [
            Tab(text: 'X-Ray'),
            Tab(text: 'Scans'),
            Tab(text: 'Reports'),
            Tab(text: 'Others'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecordList('X-Ray'),
          _buildRecordList('Scans'),
          _buildRecordList('Medical Reports'),
          _buildRecordList('Others'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddRecordScreen()));
          _loadRecords(); // Refresh records after adding
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: ButtonNavigation(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            NavigateScreen(context, index);
          }),
    );
  }

  Widget _buildRecordList(String category) {
    List<Records> filteredRecords =
        allRecords.where((record) => record.recordType == category).toList();

    if (filteredRecords.isEmpty) {
      return Center(child: Text("No records found for $category"));
    }

    return ListView.builder(
      itemCount: filteredRecords.length,
      itemBuilder: (context, index) {
        final record = filteredRecords[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: record.recordPath != null && record.recordPath.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      showFullImage(context, record.recordPath);
                    },
                    child: Image.file(File(record.recordPath),
                        width: 50, height: 50, fit: BoxFit.cover),
                  )
                : Icon(Icons.insert_drive_file),
            title: Text(record.recordName),
            subtitle: Text("Date: ${record.recordDate}"),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                showDeleteConfirmationDialog(context, record.recordName, () async{
                    final box = Hive.box<Records>('records');
  await box.deleteAt(index); // Delete from Hive
  _loadRecords(); // Refresh UI
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Record deleted successfully!")),
  );
                });
              },
            ),
          ),
        );
      },
    );
  }
}
