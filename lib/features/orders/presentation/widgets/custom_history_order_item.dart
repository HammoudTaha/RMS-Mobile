import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/custom_order_status_item.dart';
import '../../../../core/widgets/custom_outline_button.dart';

class CustomHistoryOrderItem extends StatelessWidget {
  const CustomHistoryOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
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
              Text(
                'Order id : 48gyncb8h7d64',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const CustomOrderStatusItem(status: OrderStatus.cancelled),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Ordered At : 7th May 2024, 4:00 PM',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              const Text(
                'Type : ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'Din-In',
                style: const TextStyle(
                  fontSize: 16,
                  color: primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: CustomOutLineButton(text: 'Re-Order', onTap: () {}),
              ),
              InkWell(
                onTap: () {
                  context.push('/order-details');
                },
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
