import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/widgets/custom_wrap_selected_items.dart';
import '../../data/models/delivery_address/delivery_info.dart';
import '../bloc/pass_data/pass_data_bloc.dart';
import 'custom_delivery_address_item.dart';
import 'custom_select_payment_method_bottom_sheet.dart';

class CustomFullDeliveryAddress extends StatelessWidget {
  const CustomFullDeliveryAddress({super.key, required this.deliveryAddresses});
  final List<DeliveryInfo> deliveryAddresses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomWrapSelectedItems<DeliveryInfo>(
          child: (selected, item) {
            return CustomDeliveryAddressItem(
              selected: selected,
              deliverAddress: item,
            );
          },
          onTap: (item) {
            context.read<PassDataBloc>().add(PassDataEvent(deliveryInfo: item));
          },
          initial:
              deliveryAddresses.indexWhere(
                        (element) =>
                            element.id ==
                            context.read<PassDataBloc>().state.deliveryInfo?.id,
                      ) >
                      -1
                  ? deliveryAddresses.indexWhere(
                    (element) =>
                        element.id ==
                        context.read<PassDataBloc>().state.deliveryInfo?.id,
                  )
                  : 0,
          items: deliveryAddresses,
        ),
        Spacer(flex: 1),
        CustomAnimatedButton(
          text: 'Continue',
          onClick: () {
            context.read<PassDataBloc>().state.deliveryInfo ??
                context.read<PassDataBloc>().add(
                  PassDataEvent(deliveryInfo: deliveryAddresses.first),
                );
            customSelectPaymentMethodBottomSheet(context);
          },
        ),
      ],
    );
  }
}
