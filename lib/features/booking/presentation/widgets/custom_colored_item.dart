import 'package:flutter/material.dart';

class CustomColoredItem extends StatelessWidget {
  const CustomColoredItem({
    super.key,
    required this.inColor,
    required this.outColor,
    required this.text,
  });
  final Color inColor;
  final Color outColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: outColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: inColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
