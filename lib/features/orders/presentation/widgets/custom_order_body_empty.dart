import 'package:flutter/material.dart';

class CustomOrderBodyEmpty extends StatelessWidget {
  const CustomOrderBodyEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 3),
        Image.asset('assets/images/emptyOrder.png'),
        SizedBox(height: 5),
        const Text(
          'You have no order yet',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Spacer(flex: 4),
      ],
    );
  }
}
