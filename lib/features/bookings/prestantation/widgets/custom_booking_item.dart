import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:restaurant_managment_mobile/core/utils/custom_confirm_dialog.dart';
import 'package:restaurant_managment_mobile/core/utils/custom_snakbar.dart';
import 'package:restaurant_managment_mobile/features/bookings/prestantation/bloc/cancelBooking/cancel_booking_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/custom_booking_status_item.dart';
import '../../../../core/widgets/custom_icon_text_item.dart';
import '../../../../core/widgets/custom_location_item.dart';
import '../../../../core/widgets/custom_outline_button.dart';
import '../../data/models/booking/booking.dart';
import '../bloc/booking/booking_bloc.dart';

class CustomBookingItem extends StatelessWidget {
  const CustomBookingItem({super.key, required this.booking});
  final Booking booking;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CancelBookingBloc, CancelBookingState>(
      listener: (context, state) {
        if (state is CanceledBookingState) {
          showSnakbar(state.message);
          EasyLoading.dismiss();
          context.read<BookingBloc>().add(FetchBookingsEvent());
        } else if (state is FailedCancelBookingState) {
          showSnakbar(state.message);
          EasyLoading.dismiss();
        } else {
          EasyLoading.show(status: 'loading...');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200, width: 1),
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
          children: [
            Row(
              spacing: 5,
              children: [
                CustomIconTextItem(
                  icon: Icons.calendar_month,
                  text: '${booking.date} - ${booking.time}',
                ),
<<<<<<< HEAD
                CustomIconTextItem(
                  icon: Icons.watch_later_outlined,
                  text: '1 hour',
=======
                const Spacer(),
                CustomBookingStatusItem(status: booking.status),
              ],
            ),
            const SizedBox(width: 5),
            const Divider(color: Colors.black12, thickness: .5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/A.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
>>>>>>> 7a80950 (add read me file)
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Row(
                        children: [
                          Text(
                            booking.restaurant.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.star, color: Colors.amber),
                          Text(
                            '(${booking.restaurant.rating})',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        booking.restaurant.category,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primary,
                        ),
                      ),
                      CustomLocationItem(
                        location: booking.restaurant.address,
                        width: 200,
                        overflow: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconTextItem(
                    icon: Icons.people_alt,
                    text: booking.partySize.toString(),
                  ),
                  CustomIconTextItem(
                    icon: Icons.watch_later_outlined,
                    text: '${booking.durations} hour',
                  ),
                  CustomIconTextItem(
                    icon: Icons.table_restaurant,
                    text: 'T-${booking.table}',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child:
                  booking.status == BookStatus.active
                      ? Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: CustomOutLineButton(
                              text: 'Edit',
                              onTap: () {},
                            ),
                          ),
                          Expanded(
                            child: CustomOutLineButton(
                              text: 'Cancel',
                              onTap: () {
                                customConfirmDialog(
                                  context,
                                  title: 'Canceling Booking',
                                  message:
                                      'Are you sure you want to cancel this booking ?',
                                  onPressed: () {
                                    context.read<CancelBookingBloc>().add(
                                      CancelBookEvent(booking.id),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      )
                      : SizedBox(
                        height: 40,
                        child: CustomOutLineButton(
                          text: 'Re-Book',
                          onTap: () {},
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
