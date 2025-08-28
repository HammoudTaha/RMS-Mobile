import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class CustomPaymentMethodItem extends StatelessWidget {
  const CustomPaymentMethodItem({
    super.key,
    required this.image,
    required this.text,
    this.onChange,
    required this.indexRadio,
    required this.index,
  });
  final String image;
  final String text;
  final void Function(int?)? onChange;
  final int indexRadio;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.grey.shade300,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(image, height: 50, width: 50),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Radio(
            activeColor: primary,
            value: index,
            groupValue: indexRadio,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
