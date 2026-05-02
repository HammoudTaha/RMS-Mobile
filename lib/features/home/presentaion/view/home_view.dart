import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/category/category_bloc.dart';
import '../bloc/topRestaurant/top_restaurant_bloc.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_categories.dart';
import '../widgets/custom_top_rated_restaurant.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          CustomAppbar(),
          RefreshIndicator(
            onRefresh: () async {
              context.read<CategoryBloc>().add(FetchCategoriesEvent());
              context.read<TopRestarantBloc>().add(FetchTopRestarantsEvent());
            },
            child: Column(
              children: [
                CustomCategories(),
                CustomTopRatedRestaurant(),
                CustomTopRatedRestaurant(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
