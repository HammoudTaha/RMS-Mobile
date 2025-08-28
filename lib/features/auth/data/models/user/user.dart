import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String? address;
  @HiveField(4)
  final String? image;
  @HiveField(5)
  final String? allergies;
  @HiveField(6)
  final String? dietaryPreferences;

  User({
    required this.id,
    required this.name,
    required this.phone,
    this.address,
    this.image,
    this.allergies,
    this.dietaryPreferences,
  });
  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
      id: jsonData['id'].toString(),
      name: jsonData['first_name'],
      phone: jsonData['phone'],
      image:
          jsonData['profile_image'] != null
              ? 'https://rms-production-7292.up.railway.app${jsonData['profile_image']}'
              : null,
    );
  }

  User copyWith({
    String? name,
    String? address,
    String? image,
    String? allergies,
    String? dietaryPreferences,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      phone: phone,
      address: address ?? this.address,
      image: image ?? this.image,
      allergies: allergies ?? this.allergies,
      dietaryPreferences: dietaryPreferences ?? this.dietaryPreferences,
    );
  }
}
