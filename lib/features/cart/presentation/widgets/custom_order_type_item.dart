import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/enum.dart';

class CustomOrderTypeItem extends StatelessWidget {
  const CustomOrderTypeItem({
    super.key,
    required this.isSelected,
    required this.orderType,
  });
  final bool isSelected;
  final OrderType orderType;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? primary.withAlpha(15) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? primary : Colors.black12,
          width: 2,
        ),
      ),
      child: Text(
        OrderType.delivery == orderType
            ? 'Delivery'
            : (OrderType.dineIn == orderType ? 'Dine-in' : 'Pick-up'),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: primary,
        ),
      ),
    );
  }
}
