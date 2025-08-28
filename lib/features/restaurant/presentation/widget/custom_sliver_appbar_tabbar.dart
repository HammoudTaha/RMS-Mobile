import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class CustomSliverAppBarWithTabBar extends StatelessWidget {
  const CustomSliverAppBarWithTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const SizedBox(),
      pinned: true,
      scrolledUnderElevation: .0,
      backgroundColor: Colors.white,
      expandedHeight: 0,
      flexibleSpace: TabBar(
        onTap: (value) {},
        labelColor: primary,
        indicatorColor: primary,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        tabs: const [Tab(text: 'Info'), Tab(text: 'Menu')],
      ),
      toolbarHeight: 0,
    );
  }
}
