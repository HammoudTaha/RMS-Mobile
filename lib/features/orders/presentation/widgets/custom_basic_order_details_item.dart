import 'package:flutter/material.dart';
import 'package:restaurant_managment_mobile/core/constants/colors.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/custom_order_status_item.dart';
import '../../../../core/widgets/custom_tow_text.dart';
import '../../data/models/order_details/order_details.dart';

class CustomBasicOrderDetailsItem extends StatelessWidget {
  const CustomBasicOrderDetailsItem({super.key, required this.order});
  final OrderDetails order;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order staus :',
                style: TextStyle(
                  fontSize: 18,
                  color: primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomOrderStatusItem(status: order.status),
            ],
          ),
          const Divider(color: Colors.black26, thickness: 1.5),
          CustomTowText(text1: 'Order Id :', text2: order.id),
          const Divider(color: Colors.black26, thickness: 1.5),
          CustomTowText(text1: 'Ordered At :', text2: order.createdAt),
          const Divider(color: Colors.black26, thickness: 1.5),
          CustomTowText(
            text1: 'Type :',
            text2:
                order.orderType == OrderType.delivery
                    ? 'Delivery'
                    : order.orderType == OrderType.dineIn
                    ? 'Dine-in'
                    : 'Pick-up',
          ),
          const Divider(color: Colors.black26, thickness: 1.5),
          CustomTowText(
            text1: 'Estimated Presparation Time :',
            text2: '${order.estimatedPreparationTime.toString()} mins',
          ),
        ],
      ),
    );
  }
}
