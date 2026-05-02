import 'package:flutter/material.dart';

class CustomLocationItem extends StatelessWidget {
  const CustomLocationItem({
    super.key,
    required this.width,
    required this.location,
    this.overflow = true,
  });
  final double width;
  final String location;
  final bool overflow;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        const Icon(Icons.location_on_rounded, color: Colors.red),
        SizedBox(
          width: width,
          child: Text(
            location,
            style: TextStyle(
              fontSize: 16,
              overflow: overflow ? TextOverflow.ellipsis : TextOverflow.visible,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
