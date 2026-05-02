import 'package:flutter/material.dart';
import 'package:restaurant_managment_mobile/core/utils/enum.dart';

import '../../../../core/widgets/custom_tow_text.dart';
import '../../data/models/order_details/payment/payment.dart';

class CustomPaymentsDetailsItem extends StatelessWidget {
  const CustomPaymentsDetailsItem({super.key, required this.payment});
  final Payment payment;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffF0EFEF),
            offset: Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 3,
        children: [
          const Text(
            'Payment Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          CustomTowText(
            text1: 'Payment Method',
            text2:
                payment.paymentMethod == PaymentMethod.cash
                    ? 'Cash'
                    : payment.paymentMethod == PaymentMethod.googlePay
                    ? 'Google Pay'
                    : payment.paymentMethod == PaymentMethod.masrtCard
                    ? 'Master Card'
                    : 'PayPal',
          ),
          const Divider(color: Colors.black26, thickness: 1.5),
          CustomTowText(
            text1: 'Total Price : ',
            text2: '\$ ${payment.subTotal}',
          ),
          CustomTowText(
            text1: 'Delivery Fee : ',
            text2: '\$ ${payment.deliveryFee}',
          ),
          CustomTowText(text1: 'Discounts : ', text2: '\$ 0.0'),
          CustomTowText(text1: 'Taxes : ', text2: '\$ ${payment.tax}'),
          const Divider(color: Colors.black26, thickness: 1.5),
          CustomTowText(
            text1: 'Total Payments : ',
            text2: '\$ ${payment.total}',
          ),
        ],
      ),
    );
  }
}
