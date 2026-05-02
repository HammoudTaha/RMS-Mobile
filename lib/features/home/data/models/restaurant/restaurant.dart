class Restaurant {
  final String id;
  final String name;
  final String category;
  String? image;
  final double rating;
  final String address;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.rating,
    required this.address,
  });

  factory Restaurant.formJson(Map<String, dynamic> jsonData) {
    return Restaurant(
      id: jsonData['id'].toString(),
      name: jsonData['name'],
      category: jsonData['category'],
      image: jsonData['cover_image'],
      rating: jsonData['average_rating'],
      address: jsonData['address'],
    );
  }
}
