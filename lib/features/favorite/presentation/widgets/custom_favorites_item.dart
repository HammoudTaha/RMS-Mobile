import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/custom_confirm_dialog.dart';
import '../../../../core/widgets/custom_icon_text_Item.dart';
import '../../../../core/widgets/custom_location_item.dart';
import '../../../../core/widgets/custom_star_rate.dart';
import '../../../restaurant/data/models/restaurant/restaurant.dart';
import '../bloc/favorite/favorite_bloc.dart';

class CustomFavoritesItem extends StatelessWidget {
  const CustomFavoritesItem({super.key, required this.restaurant});
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/restaurant', extra: restaurant.id);
      },
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffF0EFEF),
              offset: Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/images/t1.png',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: InkWell(
                      onTap: () {
                        customConfirmDialog(
                          context,
                          message: 'Are you sure to unfavorite restaurant',
                          onPressed: () {
                            context.read<FavoriteBloc>().add(
                              RemoveFavoriteEvent(int.parse(restaurant.id)),
                            );
                            context.read<FavoriteBloc>().add(
                              FetchFavoriteEvent(),
                            );
                          },
                          title: 'Unfavorite Restaurant',
                        );
                      },
                      child: const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomStarRate(rating: restaurant.rating, size: 20),
                      CustomIconTextItem(
                        icon: Icons.restaurant,
                        text: restaurant.category,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomLocationItem(width: 300, location: restaurant.address),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
