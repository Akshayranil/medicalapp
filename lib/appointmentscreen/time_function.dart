// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'prescription_model.dart';

// class ViewPrescriptionsScreen extends StatefulWidget {
//   @override
//   _ViewPrescriptionsScreenState createState() => _ViewPrescriptionsScreenState();
// }

// class _ViewPrescriptionsScreenState extends State<ViewPrescriptionsScreen> {
//   late Box<Prescription> _prescriptionBox;

//   @override
//   void initState() {
//     super.initState();
//     _prescriptionBox = Hive.box<Prescription>('prescriptions');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('View Prescriptions'), backgroundColor: Colors.lightGreenAccent),
//       body: _prescriptionBox.isEmpty
//           ? Center(child: Text("No prescriptions added."))
//           : GridView.builder(
//               padding: EdgeInsets.all(10),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: _prescriptionBox.length,
//               itemBuilder: (context, index) {
//                 final prescription = _prescriptionBox.getAt(index);
//                 return GestureDetector(
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => PrescriptionDetailScreen(prescription: prescription!),
//                     ),
//                   ),
//                   child: Card(
//                     elevation: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Image.file(File(prescription!.imagePath), fit: BoxFit.cover, width: double.infinity),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Dr. ${prescription.doctorName}", style: TextStyle(fontWeight: FontWeight.bold)),
//                               Text(prescription.date, style: TextStyle(fontSize: 12, color: Colors.grey)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
