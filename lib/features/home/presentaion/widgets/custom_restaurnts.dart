import 'package:flutter/material.dart';

class CustomRestaurants extends StatelessWidget {
  const CustomRestaurants({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 30, bottom: 10),
                  // child: const CustomRestaurntItem(
                  // ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
