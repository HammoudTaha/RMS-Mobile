import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/widgets/custom_wrap_selected_items.dart';
import '../../../bookings/data/models/booking/booking.dart';
import '../bloc/pass_data/pass_data_bloc.dart';
import 'custom_booking_item.dart';
import 'custom_select_payment_method_bottom_sheet.dart';

class CustomFullBookingsItem extends StatelessWidget {
  const CustomFullBookingsItem({super.key, required this.bookings});
  final List<Booking> bookings;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: CustomWrapSelectedItems<Booking>(
              child: (selected, item) {
                return CustomBookingItem(selected: selected, booking: item);
              },
              items: bookings,
              initial:
                  bookings.indexWhere(
                            (element) =>
                                element ==
                                context.read<PassDataBloc>().state.booking,
                          ) >
                          -1
                      ? bookings.indexWhere(
                        (element) =>
                            element ==
                            context.read<PassDataBloc>().state.booking,
                      )
                      : 0,
              onTap: (item) {
                context.read<PassDataBloc>().add(PassDataEvent(booking: item));
              },
            ),
          ),
        ),
        CustomAnimatedButton(
          text: 'Continue',
          onClick: () {
            context.read<PassDataBloc>().state.booking ??
                context.read<PassDataBloc>().add(
                  PassDataEvent(booking: bookings[0]),
                );
            customSelectPaymentMethodBottomSheet(context);
          },
        ),
      ],
    );
  }
}
