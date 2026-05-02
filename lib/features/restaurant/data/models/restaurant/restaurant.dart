import 'package:hive/hive.dart';
part 'restaurant.g.dart';

@HiveType(typeId: 1)
class Restaurant {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double rating;
  @HiveField(3)
  String? image;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String category;
  @HiveField(6)
  final String about;
  @HiveField(7)
  final List<String> connectInfo;
  @HiveField(8)
  final List<String> operationOfWork;
  @HiveField(9)
  final List<String> parkings;
  @HiveField(10)
  final List<String> paymentOptions;
  @HiveField(11)
  final List<String> services;

  @HiveField(7)
  Restaurant({
    required this.id,
    required this.name,
    required this.rating,
    required this.address,
    required this.category,
    this.image,
    required this.about,
    required this.connectInfo,
    required this.operationOfWork,
    required this.parkings,
    required this.paymentOptions,
    required this.services,
  });
  factory Restaurant.formJson(Map<String, dynamic> jsonData) {
    final List<String> services = [];
    jsonData['services'].forEach((key, value) {
      if (value) services.add(key);
    });
    return Restaurant(
      id: jsonData['id'].toString(),
      name: jsonData['name'],
      rating: jsonData['average_rating'],
      address: jsonData['address'],
      category: jsonData['category'],
      image: jsonData['cover_image'],
      about: jsonData['description'],
      connectInfo:
          [jsonData['phone'], jsonData['email']].nonNulls.toList().cast(),
      operationOfWork: [jsonData['opening_time'], jsonData['closing_time']],
      parkings: [],
      paymentOptions: [],
      services: services,
    );
  }
}
