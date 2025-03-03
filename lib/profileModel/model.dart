import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0) // Unique typeId for your model User Model
class Profile {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phoneNumber;

  @HiveField(2)
  final String dateOfBirth;

  @HiveField(3)
  final String gender;

  @HiveField(4)
  final String bloodGroup;

  @HiveField(5)
   String photoPath;
  @HiveField(6)
  final String city;

  Profile({
    required this.name,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodGroup,
    required this.photoPath,
    required this.city,
  });
}

@HiveType(typeId: 2) // Use a new typeId if needed
class MedicineData {
  @HiveField(0)
  String name;

  @HiveField(1)
  int count;

  @HiveField(2)
  bool morning;

  @HiveField(3)
  bool afternoon;

  @HiveField(4)
  bool night;

  MedicineData({
    required this.name,
    required this.count,
    required this.morning,
    required this.afternoon,
    required this.night,
  });
}

@HiveType(typeId: 3)
class BloodGlucoseRecord {
  @HiveField(0)
  final String date;

  @HiveField(1)
  final String time;

  @HiveField(2)
  final double glucoseLevel;

  @HiveField(3)
  final int foodIntakeStatus;

  BloodGlucoseRecord({
    required this.date,
    required this.time,
    required this.glucoseLevel,
    required this.foodIntakeStatus,
  });
}

@HiveType(typeId: 4)
class VitalsModel {
  @HiveField(0)
  String vitaldate;
  @HiveField(1)
  String vitaltime;
  @HiveField(2)
  String bp;
  @HiveField(3)
  String pulse;
  @HiveField(4)
  String temperature;
  @HiveField(5)
  String spo2;
  @HiveField(6)
  String exercise;
  @HiveField(7)
  String weight;

  VitalsModel(
      {required this.vitaldate,
      required this.vitaltime,
      required this.bp,
      required this.pulse,
      required this.temperature,
      required this.spo2,
      required this.exercise,
      required this.weight});
}

@HiveType(typeId: 5)
class BMIResult {
  @HiveField(0)
  double bmi;
  @HiveField(1)
  double weight;
  @HiveField(2)
  double height;
  @HiveField(3)
  String bmidate;
  BMIResult(
      {required this.bmi,
      required this.weight,
      required this.height,
      required this.bmidate});
}

@HiveType(typeId: 6)
class AppointmentData {
  @HiveField(0)
  String doctorname;
  @HiveField(1)
  String clinicname;
  @HiveField(2)
  String placename;
  @HiveField(3)
  DateTime appointmentDateTime;
  @HiveField(4)
  int? remainderTime;
  @HiveField(5)
  String? prescriptionimage;
  AppointmentData({
    required this.doctorname,
    required this.clinicname,
    required this.placename,
    required this.appointmentDateTime,
    this.remainderTime,
    this.prescriptionimage
  });
}

@HiveType(typeId: 7)
class Records extends HiveObject {
  @HiveField(0)
  String recordPath;
  @HiveField(1)
  String recordDate;
  @HiveField(2)
  String recordName;
  @HiveField(3)
  String recordType;

  Records(
      {required this.recordPath,
      required this.recordDate,
      required this.recordName,
      required this.recordType});
}
