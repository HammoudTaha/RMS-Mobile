import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class CustomGuestItem extends StatelessWidget {
  const CustomGuestItem({
    super.key,
    required this.index,
    required this.selected,
  });
  final int index;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      margin: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? primary : Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffF1F0F0),
            offset: Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Text(
        '$index',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
