import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_managment_mobile/core/utils/enum.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../bloc/delivery_address/delivery_address_bloc.dart';
import '../bloc/pass_data/pass_data_bloc.dart';
import '../widgets/custom_order_delivery_info.dart';
import '../widgets/custom_list_order_item.dart';

class ReviewSummaryOrderingView extends StatelessWidget {
  const ReviewSummaryOrderingView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<DeliveryAddressBloc>().add(FetchDeliveryAddressesEvent());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(title: 'Review Summary'),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Type : ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      orderTypeText(
                        context.read<PassDataBloc>().state.orderType!,
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primary,
                      ),
                    ),
                  ],
                ),
              ),

              context.read<PassDataBloc>().state.orderType == OrderType.delivery
                  ? const CustomOrderDeliveryInfoItem()
                  : const SizedBox(),
              const CustomListOrderItem(),
            ],
          ),
        ),
      ),
    );
  }

  String orderTypeText(OrderType orderType) {
    return orderType == OrderType.delivery
        ? 'Delivery'
        : orderType == OrderType.dineIn
        ? 'Dine-In'
        : 'Pick-up';
  }
}
