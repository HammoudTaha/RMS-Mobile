import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/order/order.dart';
import 'custom_active_order_item.dart';
import 'custom_order_body_empty.dart';

class CustomActiveOrderBodyFull extends StatelessWidget {
  const CustomActiveOrderBodyFull({super.key, required this.orders});
  final List<Order> orders;
  @override
  Widget build(BuildContext context) {
    return orders.isNotEmpty
        ? ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 5, left: 5),
              child: InkWell(
                onTap:
                    () =>
                        context.push('/order-details', extra: orders[index].id),
                child: CustomActiveOrderItem(order: orders[index]),
              ),
            );
          },
        )
        : CustomOrderBodyEmpty();
  }
}
