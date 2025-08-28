import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/restaurant/restaurant.dart';

class CustomInfoItem extends StatelessWidget {
  const CustomInfoItem({super.key, required this.restaurant});
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInsideInfoItem(
              icon: const Icon(Icons.description_outlined, size: 25),
              title: 'About',
              text: restaurant.about,
            ),
            CustomInsideInfoItem(
              icon: const Icon(Icons.phone_outlined, size: 25),
              title: 'Phone',
              text: restaurant.connectInfo[0],
            ),
            restaurant.connectInfo.length > 1
                ? CustomInsideInfoItem(
                  icon: const Icon(Icons.email, size: 25),
                  title: 'Email',
                  text: 'example@gmail.com',
                )
                : const SizedBox(),
            CustomInsideInfoItem(
              icon: const Icon(Icons.watch_later_outlined, size: 25),
              title: 'Operation of work',
              text:
                  '${restaurant.operationOfWork[0].replaceRange(restaurant.operationOfWork[0].length - 3, restaurant.operationOfWork[0].length, '')}  – ${restaurant.operationOfWork[1].replaceRange(restaurant.operationOfWork[0].length - 3, restaurant.operationOfWork[0].length, '')} Daily',
            ),
            CustomInsideInfoItem(
              icon: SvgPicture.asset(
                'assets/icons/parking.svg',
                height: 25,
                width: 25,
                fit: BoxFit.cover,
              ),
              title: 'Parking',
              text: 'Street Parking',
            ),
            CustomInsideInfoItem(
              icon: const Icon(Icons.credit_card_outlined, size: 25),
              title: 'Payment options',
              text: 'Cash – Visa – MasterCard',
            ),
            CustomInsideInfoItem(
              icon: const Icon(Icons.restaurant, size: 25),
              title: 'Cusine',
              text: restaurant.category,
            ),
            CustomInsideInfoItem(
              icon: const Icon(Icons.restaurant_menu, size: 25),
              title: 'Services',
              text: restaurant.services.join(' – '),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInsideInfoItem extends StatelessWidget {
  const CustomInsideInfoItem({
    super.key,
    required this.icon,
    required this.text,
    required this.title,
  });

  final Widget icon;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 340,
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
