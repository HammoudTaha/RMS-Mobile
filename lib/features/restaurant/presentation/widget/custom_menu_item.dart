import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/services/di/service_locator.dart';
import '../../../../core/widgets/custom_error_page.dart';
import '../bloc/menu/menu_bloc.dart';
import 'custom_food_item.dart';
import 'custom_food_details_bottom_sheet.dart';

class CustomMenuItem extends StatefulWidget {
  const CustomMenuItem({super.key, required this.restaurantId});
  final int restaurantId;
  @override
  State<CustomMenuItem> createState() => _CustomMenuItemState();
}

class _CustomMenuItemState extends State<CustomMenuItem> {
  @override
  void initState() {
    getIt<MenuBloc>().add(FetchMenuEvent(widget.restaurantId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        if (state is FetchedMenuState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' (${state.menu.length} Items)',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.menu.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                        ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          customFoodDetailsBottomSheet(
                            context,
                            menu: state.menu[index],
                          );
                        },
                        child: CustomFoodItem(menu: state.menu[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is FailedMenuState) {
          return SingleChildScrollView(
            child: CustomErrorPage(
              onRetry: () {
                getIt<MenuBloc>().add(FetchMenuEvent(widget.restaurantId));
              },
              height: 50,
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
