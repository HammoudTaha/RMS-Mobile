import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_categories.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            CustomAppbar(),
            CustomCategories(),
            //CustomRestaurants(text: 'new_restaurant'.tr()),
            //CustomRestaurants(text: 'top_rated_restaurant'.tr()),
          ],
        ),
      ),
    );
  }
}
