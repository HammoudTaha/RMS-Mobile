import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_page.dart';
import '../bloc/order/order_bloc.dart';
import '../widgets/custom_order_items.dart';
import '../widgets/custom_basic_order_details_item.dart';
import '../widgets/custom_delivery_details_item.dart';
import '../widgets/custom_payment_details_item.dart';
import '../widgets/custom_restaurant_item.dart';

class OrderDetailsView extends StatefulWidget {
  const OrderDetailsView({super.key, required this.orderId});
  final String orderId;

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  @override
  void initState() {
    context.read<OrderBloc>().add(FetchOrdersDetailsEvent(widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Order Details'),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is FetchedOrderDetailsState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBasicOrderDetailsItem(order: state.order),
                    const SizedBox(height: 5),
                    CustomRestaurantItem(restaurant: state.order.restaurant),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: List.generate(
                            state.order.items.length,
                            (index) =>
                                CustomOrderItem(item: state.order.items[index]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (state.order.orderType == OrderType.delivery)
                      CustomDeliveryDetailsItem(
                        deliveryAddress: state.order.deliveryAddress!,
                      ),
                    CustomPaymentsDetailsItem(payment: state.order.payment),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else if (state is FailedOrderState) {
            return CustomErrorPage(onRetry: () {});
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
