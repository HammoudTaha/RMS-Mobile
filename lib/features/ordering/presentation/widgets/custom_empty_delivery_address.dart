import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class CustomEmptyDeliveryAddress extends StatelessWidget {
  const CustomEmptyDeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(flex: 2),
          Image.asset(
            'assets/images/noDeliveryAddress.png',
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
          const Text(
            'No Delivery Address Added Yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const Spacer(flex: 3),
          Container(
            height: 50,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primary.withAlpha(180),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
