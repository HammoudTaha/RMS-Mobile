import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_managment_mobile/core/widgets/custom_error_page.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/booking/booking_bloc.dart';
import '../widgets/custom_booking_item.dart';
import '../../../../core/utils/enum.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  @override
  void initState() {
    context.read<BookingBloc>().add(FetchBookingsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Bookings',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: primary.withAlpha(10),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              onTap: (value) {},
              labelColor: primary,
              indicatorColor: primary,
              labelStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [Tab(text: 'Active'), Tab(text: 'History')],
            ),
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TabBarView(
                      children: [
                        if (state is FetchedBookingsState)
                          if (state.bookings
                              .where(
                                (element) =>
                                    element.status == BookStatus.active,
                              )
                              .toList()
                              .isNotEmpty)
                            ListView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount:
                                  state.bookings
                                      .where(
                                        (element) =>
                                            element.status == BookStatus.active,
                                      )
                                      .toList()
                                      .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: CustomBookingItem(
                                    booking:
                                        state.bookings
                                            .where(
                                              (element) =>
                                                  element.status ==
                                                  BookStatus.active,
                                            )
                                            .toList()[index],
                                  ),
                                );
                              },
                            )
                          else
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Image.asset(
                                  'assets/images/no_booking.png',
                                  height: 120,
                                ),
                                Text(
                                  'You have no booking active\n available yet',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                        else if (state is FailedBookingState)
                          CustomErrorPage(onRetry: () {})
                        else
                          Center(
                            child: CircularProgressIndicator(color: primary),
                          ),
                        if (state is FetchedBookingsState)
                          if (state.bookings
                              .where(
                                (element) =>
                                    element.status != BookStatus.active,
                              )
                              .toList()
                              .isNotEmpty)
                            ListView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount:
                                  state.bookings
                                      .where(
                                        (element) =>
                                            element.status != BookStatus.active,
                                      )
                                      .toList()
                                      .length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: CustomBookingItem(
                                    booking:
                                        state.bookings
                                            .where(
                                              (element) =>
                                                  element.status !=
                                                  BookStatus.active,
                                            )
                                            .toList()[index],
                                  ),
                                );
                              },
                            )
                          else
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                Image.asset(
                                  'assets/images/no_booking.png',
                                  height: 120,
                                ),
                                Text(
                                  'You have no booking history\n booked already',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                        else if (state is FailedBookingState)
                          CustomErrorPage(onRetry: () {})
                        else
                          Center(
                            child: CircularProgressIndicator(color: primary),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
