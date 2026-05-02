class Category {
  final String id;
  final String name;
  String? image;
  final String description;
  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> jsonData) {
    return Category(
      id: jsonData['id'].toString(),
      name: jsonData['name'],
      image: jsonData['image'],
      description: jsonData['description'],
    );
  }
}
