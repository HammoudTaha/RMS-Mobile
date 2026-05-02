import 'package:flutter/material.dart';
import '../../data/models/table/table.dart' as table;

class CustomTableItem extends StatelessWidget {
  const CustomTableItem({
    super.key,
    required this.selected,
    required this.tableItem,
  });
  final bool selected;
  final table.Table tableItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border:
            selected
                ? Border.all(color: Color(0xff776BC8), width: 2)
                : Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'T-${tableItem.tableNumber}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: selected ? Color(0xff776BC8) : Colors.green,
            ),
          ),
          Text(
            'Size : ${tableItem.capacity}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: selected ? Color(0xff776BC8) : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
