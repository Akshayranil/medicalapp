import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0) // Unique typeId for your model
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
  final String photoPath;
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
