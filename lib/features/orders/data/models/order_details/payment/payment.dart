import 'package:restaurant_managment_mobile/core/utils/enum.dart';

class Payment {
  final double subTotal;
  final double tax;
  final double total;
  final double deliveryFee;
  final PaymentMethod paymentMethod;

  Payment({
    required this.subTotal,
    required this.tax,
    required this.total,
    required this.deliveryFee,
    required this.paymentMethod,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    subTotal: json['subtotal'],
    tax: json['tax'],
    deliveryFee: json['delivery_fee'],
    total: json['total'].toDouble(),
    paymentMethod: PaymentMethod.cash,
  );
}
