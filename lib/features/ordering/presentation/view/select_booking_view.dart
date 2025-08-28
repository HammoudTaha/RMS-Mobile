import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/widgets/custom_wrap_selected_items.dart';
import '../widgets/custom_booking_item.dart';

class SelectBookingView extends StatelessWidget {
  const SelectBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: primary.withAlpha(10),
        scrolledUnderElevation: 0,
        title: Text(
          'Select Booking',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  children: [
                    CustomWrapSelectedItems(
                      child: (selected, item) {
                        return CustomBookingItem(selected: selected);
                      },
                      items: [1, 2, 3],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: CustomAnimatedButton(text: 'Continue', onClick: () {}),
          ),
        ],
      ),
    );
  }
}
