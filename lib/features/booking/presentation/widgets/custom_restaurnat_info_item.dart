import 'package:flutter/material.dart';
import 'package:restaurant_managment_mobile/core/constants/colors.dart';
import 'package:restaurant_managment_mobile/core/widgets/custom_location_item.dart';
import '../../../../core/widgets/custom_star_rate.dart';
import '../../../restaurant/data/models/restaurant/restaurant.dart';

class CustomRestaurantInfoItem extends StatelessWidget {
  const CustomRestaurantInfoItem({super.key, required this.restaurant});
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/A.png',
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurant.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              restaurant.category,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: primary,
              ),
            ),
            const CustomStarRate(rating: 3, size: 18),
            CustomLocationItem(
              width: 220,
              location: 'hfsgg ,Maza St,Mazzah, Damascus, Syria',
              overflow: false,
            ),
          ],
        ),
      ],
    );
  }
}
