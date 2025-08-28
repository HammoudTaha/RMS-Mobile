import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_animated_button.dart';
import '../../data/models/cart/cart.dart';
import 'custom_cart_item.dart';
import 'custom_order_type_bottom_sheet.dart';

class CustomBodyCartFull extends StatelessWidget {
  const CustomBodyCartFull({super.key, required this.carts});
  final List<Cart> carts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: carts.length,
            itemBuilder: (context, index) {
              return CustomItemCart(cart: carts[index]);
            },
          ),
        ),
        Container(
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(
              top: BorderSide(color: Colors.black12, width: 2),
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Price : ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$ ${totalPrice(carts)} ',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              CustomAnimatedButton(
                text: 'Place Order',
                onClick: () {
                  customOrderTypeBottomSheet(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  double totalPrice(List<Cart> carts) {
    double price = 0.0;
    for (var element in carts) {
      price += element.menu.price * element.quantity;
    }
    return (price * 100).toInt() / 100;
  }
}
