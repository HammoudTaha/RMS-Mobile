import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomDeliveryAddressText extends StatelessWidget {
  const CustomDeliveryAddressText({
    super.key,
    required this.text1,
    required this.text2,
    this.width = 200,
  });
  final String text1;
  final String text2;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: primary,
          ),
        ),
        SizedBox(
          width: width,
          child: Text(
            text2,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
