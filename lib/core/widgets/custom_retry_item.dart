
import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomRetryItem extends StatelessWidget {
  const CustomRetryItem({
    super.key,
    required this.height,
    required this.onPress,
  });
  final double height;
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          const Text(
            'Somthing went wrong',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 30,
            width: 60,
            child: CustomButton(onPressed: onPress, text: 'Retry'),
          ),
        ],
      ),
    );
  }
}
