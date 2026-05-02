import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../data/models/data/date.dart';

class CustomDataItem extends StatelessWidget {
  const CustomDataItem({super.key, required this.selected, required this.item});
  final bool selected;
  final DateItem item;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? primary : Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffF0EFEF),
            offset: Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            item.dayName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
          Text(
            item.date,
            style: TextStyle(
              fontSize: 16,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
