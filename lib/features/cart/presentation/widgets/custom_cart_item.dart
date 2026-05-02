import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_managment_mobile/core/utils/custom_confirm_dialog.dart';
import '../../../../core/widgets/custom_outline_button.dart';
import '../../data/models/cart/cart.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/cart/cart_bloc.dart';
import 'custom_cart_note_item.dart';
import 'custom_counter.dart';

class CustomItemCart extends StatelessWidget {
  const CustomItemCart({super.key, required this.cart});
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
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
        spacing: 10,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/A.png',
                  fit: BoxFit.fill,
                  width: 90,
                  height: 90,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.menu.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '\$ ${cart.menu.price}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomOutLineButton(
                      text: 'Remove',
                      onTap: () {
                        customConfirmDialog(
                          context,
                          title: 'Remove Cart',
                          message: 'Are you sure to this cart',
                          onPressed: () {
                            context.read<CartBloc>().add(
                              RemoveCartEvent(cart.menu.id),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              CustomCounter(cart: cart),
            ],
          ),
          CustomNoteCartItem(cart: cart),
        ],
      ),
    );
  }
}
