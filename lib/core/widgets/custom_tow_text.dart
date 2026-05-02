import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomTowText extends StatelessWidget {
  const CustomTowText({
    super.key,
    required this.text1,
    required this.text2,
    this.fontSize = 16,
  });
  final String text1;
  final String text2;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: TextStyle(
            fontSize: fontSize,
            color: primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          text2,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
