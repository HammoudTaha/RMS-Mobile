import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import 'custom_add_address_bottom_sheet.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: FloatingActionButton(
        onPressed: () {
          customAddAddressBottomSheet(context);
        },
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
