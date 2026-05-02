import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_managment_mobile/core/widgets/custom_icon_button.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/custom_snakbar.dart';
import '../../data/models/cart/cart.dart';
import '../bloc/cart/cart_bloc.dart';

class CustomCounter extends StatelessWidget {
  const CustomCounter({super.key, required this.cart});
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        CustomIconButton(
          icon: Icons.add,
          onTap: () {
            context.read<CartBloc>().add(PlusQuantityCartEvent(cart.menu.id));
          },
        ),
        Text(
          '${cart.quantity}',
          style: const TextStyle(
            fontSize: 18,
            color: primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        CustomIconButton(
          icon: Icons.remove,
          onTap: () {
            if (cart.quantity > 1) {
              context.read<CartBloc>().add(
                MinusQuantityCartEvent(cart.menu.id),
              );
            } else {
              showSnakbar('Quantity cart must be at lesat 1');
            }
          },
        ),
      ],
    );
  }
}
