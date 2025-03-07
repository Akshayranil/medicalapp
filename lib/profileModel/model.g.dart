// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final int typeId = 0;

  @override
  Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      name: fields[0] as String,
      phoneNumber: fields[1] as String,
      dateOfBirth: fields[2] as String,
      gender: fields[3] as String,
      bloodGroup: fields[4] as String,
      photoPath: fields[5] as String,
      city: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phoneNumber)
      ..writeByte(2)
      ..write(obj.dateOfBirth)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.bloodGroup)
      ..writeByte(5)
      ..write(obj.photoPath)
      ..writeByte(6)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MedicineDataAdapter extends TypeAdapter<MedicineData> {
  @override
  final int typeId = 2;

  @override
  MedicineData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineData(
      name: fields[0] as String,
      count: fields[1] as double,
      morningDosage: fields[2] as double,
      afternoonDosage: fields[3] as double,
      nightDosage: fields[4] as double,
      morning: fields[5] as bool,
      afternoon: fields[6] as bool,
      night: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.morningDosage)
      ..writeByte(3)
      ..write(obj.afternoonDosage)
      ..writeByte(4)
      ..write(obj.nightDosage)
      ..writeByte(5)
      ..write(obj.morning)
      ..writeByte(6)
      ..write(obj.afternoon)
      ..writeByte(7)
      ..write(obj.night);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BloodGlucoseRecordAdapter extends TypeAdapter<BloodGlucoseRecord> {
  @override
  final int typeId = 3;

  @override
  BloodGlucoseRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodGlucoseRecord(
      date: fields[0] as String,
      time: fields[1] as String,
      glucoseLevel: fields[2] as double,
      foodIntakeStatus: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BloodGlucoseRecord obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.glucoseLevel)
      ..writeByte(3)
      ..write(obj.foodIntakeStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodGlucoseRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VitalsModelAdapter extends TypeAdapter<VitalsModel> {
  @override
  final int typeId = 4;

  @override
  VitalsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VitalsModel(
      vitaldate: fields[0] as String,
      vitaltime: fields[1] as String,
      bp: fields[2] as String,
      pulse: fields[3] as String,
      temperature: fields[4] as String,
      spo2: fields[5] as String,
      exercise: fields[6] as String,
      weight: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VitalsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.vitaldate)
      ..writeByte(1)
      ..write(obj.vitaltime)
      ..writeByte(2)
      ..write(obj.bp)
      ..writeByte(3)
      ..write(obj.pulse)
      ..writeByte(4)
      ..write(obj.temperature)
      ..writeByte(5)
      ..write(obj.spo2)
      ..writeByte(6)
      ..write(obj.exercise)
      ..writeByte(7)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VitalsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BMIResultAdapter extends TypeAdapter<BMIResult> {
  @override
  final int typeId = 5;

  @override
  BMIResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BMIResult(
      bmi: fields[0] as double,
      weight: fields[1] as double,
      height: fields[2] as double,
      bmidate: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BMIResult obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.bmi)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.bmidate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BMIResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AppointmentDataAdapter extends TypeAdapter<AppointmentData> {
  @override
  final int typeId = 6;

  @override
  AppointmentData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppointmentData(
      doctorname: fields[0] as String,
      clinicname: fields[1] as String,
      placename: fields[2] as String,
      appointmentDateTime: fields[3] as DateTime,
      remainderTime: fields[4] as int?,
      prescriptionimage: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AppointmentData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.doctorname)
      ..writeByte(1)
      ..write(obj.clinicname)
      ..writeByte(2)
      ..write(obj.placename)
      ..writeByte(3)
      ..write(obj.appointmentDateTime)
      ..writeByte(4)
      ..write(obj.remainderTime)
      ..writeByte(5)
      ..write(obj.prescriptionimage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppointmentDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecordsAdapter extends TypeAdapter<Records> {
  @override
  final int typeId = 7;

  @override
  Records read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Records(
      recordPath: fields[0] as String,
      recordDate: fields[1] as String,
      recordName: fields[2] as String,
      recordType: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Records obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.recordPath)
      ..writeByte(1)
      ..write(obj.recordDate)
      ..writeByte(2)
      ..write(obj.recordName)
      ..writeByte(3)
      ..write(obj.recordType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
