import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_error_page.dart';
import '../bloc/cart/cart_bloc.dart';
import '../widgets/custom_body_cart_empty.dart';
import '../widgets/custom_body_cart_full.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        scrolledUnderElevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is FetchedCartState) {
            if (state.carts.isEmpty) {
              return CustomBodyCartEmpty();
            } else {
              return CustomBodyCartFull(carts: state.carts);
            }
          } else if (state is FailedCartState) {
            return CustomErrorPage(onRetry: () {});
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
