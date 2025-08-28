import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class CustomIconTextItem extends StatelessWidget {
  const CustomIconTextItem({
    super.key,
    required this.icon,
    required this.text,
    this.fontSize = 16,
  });
  final IconData icon;
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: primary),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
