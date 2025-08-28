import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color = primary,
    this.size = 30,
  });

  final IconData icon;
  final void Function() onTap;
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(color: Color(0xffF0EFEF), blurRadius: 6, spreadRadius: 3),
          ],
        ),
        child: Icon(icon, size: size, color: Colors.white),
      ),
    );
  }
}
