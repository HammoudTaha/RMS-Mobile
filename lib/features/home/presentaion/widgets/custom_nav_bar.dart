import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 10),
      child: GNav(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        tabBorderRadius: 15,
        iconSize: 30,
        gap: 10,
        selectedIndex: controller.initialPage,
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            iconActiveColor: Color(0xff88329F),
            text: 'home_label'.tr(),
            backgroundColor: Color(0xffE9D4EF),
            textColor: Color(0xff88329F),
            onPressed: () {
              controller.animateToPage(
                0,
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            },
          ),
          GButton(
            icon: Icons.menu_book_sharp,
            text: 'Bookings',
            backgroundColor: Color(0xffD4E9EB),
            iconActiveColor: Color(0xff439288),
            textColor: Color(0xff439288),
            onPressed: () {
              controller.animateToPage(
                1,
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            },
          ),
          GButton(
            icon: Icons.favorite_border,
            text: 'favorite_label'.tr(),
            backgroundColor: Color(0xffF6D3E1),
            iconActiveColor: Color(0xffBA335F),
            textColor: Color(0xffBA335F),
            onPressed: () {
              controller.animateToPage(
                2,
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            },
          ),
          GButton(
            icon: Icons.restaurant,
            text: 'orders_label'.tr(),
            backgroundColor: Color(0xffFDF0D2),
            iconActiveColor: Color(0xffE9BA57),
            textColor: Color(0xffE9BA57),
            onPressed: () {
              controller.animateToPage(
                3,
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            },
          ),
          GButton(
            icon: Icons.person_outline,
            text: 'profile_label'.tr(),
            backgroundColor: Color(0xffD4E9EB),
            iconActiveColor: Color(0xff439288),
            textColor: Color(0xff439288),
            onPressed: () {
              controller.animateToPage(
                4,
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            },
          ),
        ],
      ),
    );
  }
}
