class OrderItem {
  final String id;
  final String name;
  final String? image;
  final double price;
  final double totlePrice;
  final int quantity;
  final String? note;

  const OrderItem({
    required this.id,
    required this.name,
    this.image,
    required this.price,
    required this.totlePrice,
    required this.quantity,
    this.note,
  });

  factory OrderItem.fromJson(Map<String, dynamic> jsonData) {
    return OrderItem(
      id: jsonData['id'].toString(),
      name: jsonData['name'],
      image: jsonData['image'],
      price: jsonData['price'],
      totlePrice: jsonData['total'],
      quantity: jsonData['quantity'],
      note: jsonData['special_instructions'],
    );
  }
}
