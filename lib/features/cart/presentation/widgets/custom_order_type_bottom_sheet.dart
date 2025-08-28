import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/widgets/custom_wrap_selected_items.dart';
import '../../../ordering/presentation/bloc/pass_data/pass_data_bloc.dart';
import '../../../ordering/presentation/widgets/custom_select_payment_method_bottom_sheet.dart';
import 'custom_order_type_item.dart';

Future<dynamic> customOrderTypeBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (context) {
      return Container(
        height: 400,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Order Type',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            CustomWrapSelectedItems<OrderType>(
              child: (selected, item) {
                return CustomOrderTypeItem(
                  isSelected: selected,
                  orderType: item,
                );
              },
              runSpacing: 20,
              onTap: (item) {
                context.read<PassDataBloc>().add(
                  PassDataEvent(orderType: item),
                );
              },
              initial: context.read<PassDataBloc>().state.orderType?.index ?? 0,
              items: [OrderType.delivery, OrderType.pickUp, OrderType.dineIn],
            ),
            CustomAnimatedButton(
              text: 'Continue',
              onClick: () {
                if (context.read<PassDataBloc>().state.orderType == null ||
                    context.read<PassDataBloc>().state.orderType ==
                        OrderType.delivery) {
                  context.read<PassDataBloc>().add(
                    PassDataEvent(orderType: OrderType.delivery),
                  );
                  context.push('/select-address');
                  context.pop();
                } else if (context.read<PassDataBloc>().state.orderType ==
                    OrderType.dineIn) {
                  context.push('/select-booking');
                  context.pop();
                } else {
                  context.pop();
                  customSelectPaymentMethodBottomSheet(context);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
