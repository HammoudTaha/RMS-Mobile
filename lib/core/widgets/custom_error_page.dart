import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomErrorPage extends StatelessWidget {
  const CustomErrorPage({super.key, required this.onRetry, this.height = 150});
  final void Function() onRetry;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          spacing: 8,
          children: [
            SizedBox(height: height),
            Image.asset('assets/images/error.jpg', height: 200),
            SizedBox(
              height: 35,
              width: 80,
              child: CustomButton(onPressed: onRetry, text: 'Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
