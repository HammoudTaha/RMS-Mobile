import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_retry_item.dart';
import '../bloc/topRestaurant/top_restaurant_bloc.dart';
import 'custom_restaurant_item_shimmer.dart';
import 'custom_restaurnt_item.dart';

class CustomTopRatedRestaurant extends StatelessWidget {
  const CustomTopRatedRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            'Top-Rated Restarants',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          BlocBuilder<TopRestarantBloc, TopRestarantState>(
            builder: (context, state) {
              if (state is FetchedTopRestarantsState) {
                return SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.restaurants.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12, bottom: 5),
                        child: CustomRestaurntItem(
                          restaurant: state.restaurants[index],
                        ),
                      );
                    },
                  ),
                );
              } else if (state is FailedTopRestarantState) {
                return CustomRetryItem(
                  height: 180,
                  onPress: () {
                    context.read<TopRestarantBloc>().add(
                      FetchTopRestarantsEvent(),
                    );
                  },
                );
              } else {
                return Row(
                  spacing: 20,
                  children: [
                    CustomRestaurantItemShimmer(),
                    CustomRestaurantItemShimmer(),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
