import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNoSearchItem extends StatelessWidget {
  const CustomNoSearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Center(
        child: Column(
          spacing: 15,
          children: [
            const SizedBox(height: 255),
            SvgPicture.asset('assets/icons/search-empty.svg', height: 80),
            const Text(
              'Sorry ,No search item found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
