import 'package:flutter/material.dart';

class CustomNoFavoriteItem extends StatelessWidget {
  const CustomNoFavoriteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Image.asset('assets/images/empty_wishlist.png', height: 200),
          const Text(
            'No favorite item Added',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
