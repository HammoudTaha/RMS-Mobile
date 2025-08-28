import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/enum.dart';
import '../../../cart/data/models/cart/cart.dart';
import '../bloc/pass_data/pass_data_bloc.dart';

class CustomOrderPaymentInfo extends StatelessWidget {
  const CustomOrderPaymentInfo({super.key, required this.orderItems});
  final List<Cart> orderItems;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          const Row(
            children: [
              Expanded(child: Divider(color: Colors.black26, endIndent: 10)),
              Text(
                'Payment Info  ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Expanded(child: Divider(color: Colors.black26)),
            ],
          ),
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payment Method : ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                paymentMethodText(
                  context.read<PassDataBloc>().state.paymentMethod!,
                ),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: primary,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Payments : ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                totalPrice(orderItems),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String paymentMethodText(PaymentMethod paymentMethod) {
    return paymentMethod == PaymentMethod.payPal
        ? 'Paypal'
        : paymentMethod == PaymentMethod.googlePay
        ? 'Dine-In'
        : paymentMethod == PaymentMethod.masrtCard
        ? 'Master Card'
        : 'Cash';
  }

  String totalPrice(List<Cart> orderItems) {
    double totalParice = 0.0;
    for (int i = 0; i < orderItems.length; i++) {
      totalParice += orderItems[i].quantity * orderItems[i].menu.price;
    }
    return totalParice.toString();
  }
}
