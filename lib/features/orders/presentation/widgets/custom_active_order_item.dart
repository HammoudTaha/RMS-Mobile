import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_icon_button.dart';
import '../../../../core/widgets/custom_icon_text_item.dart';
import '../../../../core/widgets/custom_order_status_item.dart';
import '../../data/models/order/order.dart';

class CustomActiveOrderItem extends StatelessWidget {
  const CustomActiveOrderItem({super.key, required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                order.createdAt,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomOrderStatusItem(status: order.status),
            ],
          ),
          const SizedBox(height: 2),
          const Divider(color: Colors.black12),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order id : ${order.id}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CustomIconTextItem(
                icon: Icons.restaurant,
                text: order.restaurantName,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 5,
                children: [
                  Text(
                    '${order.totalPrice} \$',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primary,
                    ),
                  ),
                  Text('total price', style: const TextStyle(fontSize: 16)),
                ],
              ),
              Row(
                spacing: 5,
                children: [
                  Text(
                    '${order.estimatedPreparationTime}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primary,
                    ),
                  ),
                  Text('mins', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: CustomIconButton(
                  color: const Color(0xff3DF242),
                  icon: Icons.edit,
                  onTap: () {},
                  size: 25,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 30,
                width: 30,
                child: CustomIconButton(
                  color: const Color(0xffCA1F13),
                  icon: Icons.delete,
                  size: 25,
                  onTap: () {},
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  order.orderType,
                  style: const TextStyle(
                    fontSize: 16,
                    color: primary,
                    fontWeight: FontWeight.w600,
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
