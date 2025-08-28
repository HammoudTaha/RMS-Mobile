import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/di/service_locator.dart';
import '../../../../core/widgets/custom_animated_button.dart';
import '../../../../core/widgets/custom_error_page.dart';
import '../bloc/restaurant/restaurant_bloc.dart';
import '../widget/custom_info_item.dart';
import '../widget/custom_sliver_appbar_tabbar.dart';
import '../widget/custom_sliver_appbar_image.dart';
import '../widget/custom_menu_item.dart';

class RestaurantView extends StatefulWidget {
  const RestaurantView({super.key, required this.restaurantId});
  final String restaurantId;
  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  late final ScrollController controller;
  bool scrolled = false;
  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {
      if (controller.offset > 100) {
        setState(() {
          scrolled = true;
        });
      }
      if (controller.offset < 100) {
        setState(() {
          scrolled = false;
        });
      }
    });
    getIt<RestaurantBloc>().add(FetchRestaurantEvent(widget.restaurantId));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is FetchedRestaurantState) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: NestedScrollView(
                controller: controller,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    CustomSliverAppBarWithImage(
                      scrolled: scrolled,
                      restaurant: state.restaurant,
                    ),
                    const CustomSliverAppBarWithTabBar(),
                  ];
                },
                body: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        children: [
                          CustomInfoItem(restaurant: state.restaurant),
                          CustomMenuItem(
                            restaurantId: int.parse(state.restaurant.id),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomAnimatedButton(
                        text: 'Book Table',
                        onClick: () {
                          context.push(
                            '/data-time-guests',
                            extra: state.restaurant,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is FailedRestaurantState) {
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
                    FetchRestaurantEvent(widget.restaurantId),
                  );
                },
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                  const Spacer(flex: 3),
                  const Center(child: CircularProgressIndicator()),
                  const Spacer(flex: 4),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
