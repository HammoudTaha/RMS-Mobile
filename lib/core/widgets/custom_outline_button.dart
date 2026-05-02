import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomOutLineButton extends StatelessWidget {
  final String text;
  const CustomOutLineButton({
    super.key,
    required this.text,
    required this.onTap,
    this.fontSize = 16,
  });
  final void Function() onTap;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: primary),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
