import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_managment_mobile/core/widgets/custom_error_page.dart';
import '../../../../core/services/di/service_locator.dart';
import '../bloc/restaurant/restaurant_bloc.dart';
import '../widgets/custom_restaurant_item_shimmer.dart';
import '../widgets/custom_restaurnt_item.dart';

class CategoryRestaurantView extends StatefulWidget {
  const CategoryRestaurantView({super.key, required this.categoryId});
  final int categoryId;

  @override
  State<CategoryRestaurantView> createState() => _CategoryRestaurantViewState();
}

class _CategoryRestaurantViewState extends State<CategoryRestaurantView> {
  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    getIt<RestaurantBloc>().add(
      FetchRestaurantsEvent(widget.categoryId.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is LoadingRestaurantState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Row(
                spacing: 21,
                children: [
                  Column(
                    spacing: 20,
                    children: [
                      CustomRestaurantItemShimmer(),
                      CustomRestaurantItemShimmer(),
                      CustomRestaurantItemShimmer(),
                      CustomRestaurantItemShimmer(),
                    ],
                  ),
                  Column(
                    spacing: 20,
                    children: [
                      CustomRestaurantItemShimmer(),
                      CustomRestaurantItemShimmer(),
                      CustomRestaurantItemShimmer(),
                      CustomRestaurantItemShimmer(),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is FetchedRestaurantsState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: Text(
                state.restaurants[0].category,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
            ),
            body: GridView.builder(
              itemCount: state.restaurants.length,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 30,
              ),
              itemBuilder:
                  (context, index) =>
                      CustomRestaurntItem(restaurant: state.restaurants[index]),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
            ),
            body: CustomErrorPage(
              onRetry: () {
                getIt<RestaurantBloc>().add(
                  FetchRestaurantsEvent(widget.categoryId.toString()),
                );
              },
              height: 150,
            ),
          );
        }
      },
    );
  }
}
