import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_managment_mobile/core/utils/custom_snakbar.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../cart/presentation/bloc/cart/cart_bloc.dart';
import '../../../orders/data/data_source/remote/order_remote_data_source.dart';
import '../../../orders/presentation/bloc/order/order_bloc.dart';
import '../../../orders/presentation/widgets/custom_order_item_shimmer.dart';
import '../bloc/pass_data/pass_data_bloc.dart';
import 'custom_order_item.dart';
import 'custom_order_payment_info.dart';

class CustomListOrderItem extends StatelessWidget {
  const CustomListOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is FailedOrderState) {
          showSnakbar(state.message);
          EasyLoading.dismiss();
        } else if (state is CreatedOrderState) {
          context.go('/review-order', extra: state.data);
          EasyLoading.dismiss();
        } else {
          EasyLoading.show(status: 'loading...');
        }
      },
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.black26, endIndent: 10),
                  ),
                  Text(
                    'Order Items  ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: Divider(color: Colors.black26)),
                ],
              ),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is FetchedCartState) {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: List.generate(
                                state.carts.length,
                                (index) =>
                                    CustomOrderItem(item: state.carts[index]),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomOrderPaymentInfo(orderItems: state.carts),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomAnimatedButton(
                            text: 'Checkout',
                            onClick: () {
                              context.read<OrderBloc>().add(
                                CreateOrderEvent(
                                  OrderParams(
                                    restaurantId:
                                        state.carts.first.menu.restaurantId,
                                    orderType:
                                        context
                                            .read<PassDataBloc>()
                                            .state
                                            .orderType!,
                                    paymentMethod:
                                        context
                                            .read<PassDataBloc>()
                                            .state
                                            .paymentMethod!,
                                    deliveryAddress:
                                        context
                                            .read<PassDataBloc>()
                                            .state
                                            .deliveryInfo
                                            ?.address,
                                    reservationId:
                                        context
                                            .read<PassDataBloc>()
                                            .state
                                            .reservationId,
                                    items: List.generate(
                                      state.carts.length,
                                      (index) => {
                                        'item_id': state.carts[index].menu.id,
                                        'quantity': state.carts[index].quantity,
                                        'special_instructions':
                                            state.carts[index].note,
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      spacing: 20,
                      children: [
                        CustomOrderItemShimmer(),
                        CustomOrderItemShimmer(),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
