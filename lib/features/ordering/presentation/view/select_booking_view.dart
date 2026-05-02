import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_page.dart';
import '../../../bookings/prestantation/bloc/booking/booking_bloc.dart';
import '../bloc/pass_data/pass_data_bloc.dart';
import '../widgets/custom_full_bookings_item.dart';

class SelectBookingView extends StatelessWidget {
  const SelectBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Select Booking'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              if (state is FetchedBookingsState) {
                return state.bookings
                        .where(
                          (element) =>
                              element.status == BookStatus.active &&
                              element.restaurant.id ==
                                  context
                                      .read<PassDataBloc>()
                                      .state
                                      .restaurantId,
                        )
                        .toList()
                        .isNotEmpty
                    ? CustomFullBookingsItem(
                      bookings:
                          state.bookings
                              .where(
                                (element) =>
                                    element.status == BookStatus.active &&
                                    element.restaurant.id ==
                                        context
                                            .read<PassDataBloc>()
                                            .state
                                            .restaurantId,
                              )
                              .toList(),
                    )
                    : Column(
                      spacing: 10,
                      children: [
                        Spacer(flex: 2),
                        Image.asset(
                          'assets/images/no_booking.png',
                          height: 120,
                        ),
                        Text(
                          'You have no booking active available\n yet in this restaurant',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(flex: 3),
                      ],
                    );
              } else if (state is FailedBookingState) {
                return CustomErrorPage(onRetry: () {});
              } else {
                return Center(child: CircularProgressIndicator(color: primary));
              }
            },
          ),
        ),
      ),
    );
  }
}
