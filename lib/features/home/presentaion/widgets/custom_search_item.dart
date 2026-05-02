import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_location_item.dart';
import '../../../../core/widgets/custom_star_rate.dart';
import '../../data/models/restaurant/restaurant.dart';

class CustomSearchItem extends StatelessWidget {
  const CustomSearchItem({super.key, required this.restaurant});
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/restaurant', extra: restaurant.id),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 3),
              blurRadius: 3,
            ),
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
                height: 120,
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
                  restaurant.category,
                  style: TextStyle(
                    fontSize: 16,
                    color: primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomStarRate(rating: restaurant.rating, size: 18),
                CustomLocationItem(width: 180, location: restaurant.address),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
