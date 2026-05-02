import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_location_item.dart';
import '../../data/models/order_details/restaurant/restaurant.dart';

class CustomRestaurantItem extends StatelessWidget {
  const CustomRestaurantItem({super.key, required this.restaurant});
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 3),
        ],
      ),
      child: Row(
        spacing: 8,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(10),
            ),
            child: Image.asset(
              'assets/images/t1.png',
              height: 90,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                restaurant.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                restaurant.phone,
                style: TextStyle(
                  fontSize: 16,
                  color: primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomLocationItem(width: 180, location: restaurant.address),
            ],
          ),
        ],
      ),
    );
  }
}
