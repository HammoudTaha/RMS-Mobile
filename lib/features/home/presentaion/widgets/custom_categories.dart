import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/di/service_locator.dart';
import '../../../../core/widgets/custom_retry_item.dart';
import '../bloc/category/category_bloc.dart';
import 'custom_category_item_shimmer.dart';
import 'custom_catrgory_item.dart';

class CustomCategories extends StatelessWidget {
  const CustomCategories({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            'categories'.tr(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is FailedCategoryState) {
                return CustomRetryItem(
                  height: 110,
                  onPress: () {
                    getIt<CategoryBloc>().add(FetchCategoriesEvent());
                  },
                );
              } else if (state is FetchedCategoriesState) {
                return SizedBox(
                  height: 110,
                  child: ListView.builder(
                    itemCount: state.categories.length,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CustomCategoryItem(
                        category: state.categories[index],
                      );
                    },
                  ),
                );
              } else {
                return SizedBox(
                  height: 110,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 5,
                    ),
                    child: Row(
                      spacing: 22,
                      children: [
                        ...List.generate(
                          4,
                          (index) => const CustomCategoryItemShimmer(),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
