class Restaurant {
  final String id;
  final String name;
  final String? image;
  final String address;
  final String phone;

  Restaurant({
    required this.id,
    required this.name,
    this.image,
    required this.address,
    required this.phone,
  });

  factory Restaurant.fromJson(Map<String, dynamic> jsonData) {
    return Restaurant(
      id: jsonData['id'].toString(),
      name: jsonData['name'],
      image: jsonData['image'],
      address: jsonData['address'],
      phone: jsonData['phone'],
    );
  }
}
