import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_managment_mobile/features/profile/presentation/bloc/profile/profile_bloc.dart';
import '../../bookings/prestantation/view/bookings_view.dart';
import '../../favorite/presentation/bloc/favorite/favorite_bloc.dart';
import '../../favorite/presentation/view/favorite_view.dart';
import '../../home/presentaion/bloc/category/category_bloc.dart';
import '../../home/presentaion/view/home_view.dart';
import '../../home/presentaion/widgets/custom_nav_bar.dart';
import '../../orders/presentation/view/orders_view.dart';
import '../../profile/presentation/view/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, this.initialPage = 0});
  final int initialPage;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List screens = [
    () => const HomeView(),
    () => const BookingsView(),
    () => BlocProvider(
      create: (context) => FavoriteBloc(),
      child: const FavoritesView(),
    ),
    () => const OrdersView(),
    () => const ProfileView(),
  ];
  late final PageController _controller;
  @override
  void initState() {
    context.read<CategoryBloc>().add(FetchCategoriesEvent());
    context.read<ProfileBloc>().add(LoadProfileEvent());
    _controller = PageController(initialPage: widget.initialPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        itemCount: screens.length,
        itemBuilder: (context, index) {
          return screens[index]();
        },
      ),
      bottomNavigationBar: CustomNavBar(controller: _controller),
    );
  }
}
