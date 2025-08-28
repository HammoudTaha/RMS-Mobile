import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/order/order.dart';
import 'custom_history_order_item.dart';
import 'custom_order_body_empty.dart';

class CustomHistoryOrderBody extends StatelessWidget {
  const CustomHistoryOrderBody({super.key, required this.orders});
  final List<Order> orders;
  @override
  Widget build(BuildContext context) {
    return orders.isNotEmpty
        ? ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () => context.push('/order-details'),
                child: const CustomHistoryOrderItem(),
              ),
            );
          },
        )
        : CustomOrderBodyEmpty();
  }
}
