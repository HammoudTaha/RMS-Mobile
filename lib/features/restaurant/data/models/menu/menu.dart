import 'package:hive/hive.dart';
part 'menu.g.dart';

@HiveType(typeId: 2)
class Menu {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String restaurantId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final String description;
  @HiveField(5)
  String? image;
  @HiveField(6)
  final String estimationTime;
  @HiveField(7)
  final Map<String, dynamic> dietaryInfo;

  Menu({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    required this.description,
    this.image,
    required this.estimationTime,
    required this.dietaryInfo,
  });

  factory Menu.formJson(Map<String, dynamic> jsonData) {
    return Menu(
      id: jsonData['id'].toString(),
      restaurantId: jsonData['restaurant_id'].toString(),
      name: jsonData['name'],
      price: jsonData['price'],
      description: jsonData['description'],
      image: jsonData['image'],
      estimationTime: jsonData['preparation_time'].toString(),
      dietaryInfo: jsonData['dietary_info'],
    );
  }
}
