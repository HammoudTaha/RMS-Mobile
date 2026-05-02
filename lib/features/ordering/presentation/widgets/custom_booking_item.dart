import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_icon_text_item.dart';
import '../../../../core/widgets/custom_location_item.dart';
import '../../../bookings/data/models/booking/booking.dart';

class CustomBookingItem extends StatelessWidget {
  const CustomBookingItem({
    super.key,
    required this.selected,
    required this.booking,
  });
  final bool selected;
  final Booking booking;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? primary : Colors.grey.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          CustomIconTextItem(
            icon: Icons.calendar_month,
            text: '${booking.date} - ${booking.time}',
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
        ],
      ),
    );
  }
}
