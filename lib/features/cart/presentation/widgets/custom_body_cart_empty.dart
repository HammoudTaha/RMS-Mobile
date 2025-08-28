import 'package:flutter/material.dart';

class CustomBodyCartEmpty extends StatelessWidget {
  const CustomBodyCartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Center(child: Image.asset('assets/images/emoty_cart.jpg', height: 250)),
        const Text(
          'Your Cart is Empty',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const Spacer(flex: 4),
      ],
    );
  }
}
