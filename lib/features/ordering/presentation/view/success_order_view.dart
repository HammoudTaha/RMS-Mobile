import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_animated_button.dart';

class SuccessOrderView extends StatelessWidget {
  const SuccessOrderView({super.key, required this.data});
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 150),
          const CircleAvatar(
            backgroundColor: primary,
            minRadius: 60,
            child: Icon(Icons.check, color: Colors.white, size: 70),
          ),
          const Text(
            'Successfully\n Created Your Order',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          item(title: 'Order ID : ', value: data['order_id']),
          const SizedBox(height: 10),
          item(title: 'Total Payment : ', value: '\$ ${data['total']}'),
          const SizedBox(height: 10),
          item(
            title: 'Estimated Preparation Time : ',
            value: '${data['estimated_preparation_time']} mins',
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomAnimatedButton(
              text: 'Back To Orders',
              onClick: () {
                context.go('/main', extra: 3);
              },
            ),
          ),
        ],
      ),
    );
  }

  Row item({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: primary,
          ),
        ),
      ],
    );
  }
}
