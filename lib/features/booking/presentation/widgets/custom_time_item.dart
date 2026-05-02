import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class CustomTimeItem extends StatelessWidget {
  const CustomTimeItem({super.key, required this.selected, required this.text});
  final bool selected;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? primary : Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffF0EFEF),
            offset: Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
