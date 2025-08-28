import '../../../../../core/utils/enum.dart';
import 'order_item/order_item.dart';
import 'payment/payment.dart';
import 'restaurant/restaurant.dart';

class OrderDetails {
  final String id;
  final Restaurant restaurant;
  final OrderType orderType;
  final OrderStatus status;
  final Payment payment;
  final List<OrderItem> items;
  final String? deliveryAddress;
  final String createdAt;
  final int estimatedPreparationTime;

  OrderDetails({
    required this.id,
    required this.orderType,
    required this.restaurant,
    required this.status,
    required this.payment,
    required this.createdAt,
    required this.estimatedPreparationTime,
    required this.items,
    required this.deliveryAddress,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    final List<OrderItem> items = [];
    for (var element in json['items']) {
      items.add(OrderItem.fromJson(element));
    }
    return OrderDetails(
      id: json['id'].toString(),
      restaurant: Restaurant.fromJson(json['restaurant']),
      orderType:
          json['order_type'] == 'Pickup'
              ? OrderType.pickUp
              : json['order_type'] == 'Delivery'
              ? OrderType.delivery
              : OrderType.dineIn,
      status:
          json['status'] == 'Pending'
              ? OrderStatus.pending
              : json['status'] == 'Cancelled'
              ? OrderStatus.cancelled
              : OrderStatus.complated,
      payment: Payment.fromJson(json['payment']),
      createdAt: json['timing']['created_at'],
      estimatedPreparationTime: json['timing']['estimated_preparation_time'],
      items: items,
      deliveryAddress: json['delivery_address'],
    );
  }
}
