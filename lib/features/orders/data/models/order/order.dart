import '../../../../../core/utils/enum.dart';

class Order {
  final String id;
  final String restaurantName;
  final String orderType;
  final OrderStatus status;
  final double totalPrice;
  final String createdAt;
  final int estimatedPreparationTime;

  Order({
    required this.id,
    required this.restaurantName,
    required this.orderType,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.estimatedPreparationTime,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'].toString(),
      restaurantName: json['restaurant']['name'],
      orderType: json['order_type'],
      status:
          json['status'] == 'Pending'
              ? OrderStatus.pending
              : json['status'] == 'Cancelled'
              ? OrderStatus.cancelled
              : OrderStatus.complated,
      totalPrice: json['total'],
      createdAt: json['created_at'],
      estimatedPreparationTime: json['estimated_preparation_time'],
    );
  }
}
