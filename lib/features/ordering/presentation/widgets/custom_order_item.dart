import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_tow_text.dart';
import '../../../cart/data/models/cart/cart.dart';

class CustomOrderItem extends StatelessWidget {
  const CustomOrderItem({super.key, required this.item});
  final Cart item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Image.asset(
                  'assets/images/A.png',
                  fit: BoxFit.cover,
                  height: 70,
                  width: 100,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.menu.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\$ ${item.menu.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${item.quantity} items',
                    style: const TextStyle(fontSize: 15, color: Colors.black38),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CustomTowText(
              text1: 'Subtotal Price : ',
              text2: '\$ ${item.menu.price * item.quantity}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            child: SizedBox(
              width: 210,
              child: Text.rich(
                TextSpan(
                  text: 'Note : ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                  children: [
                    TextSpan(
                      text: item.note ?? 'No thing',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
