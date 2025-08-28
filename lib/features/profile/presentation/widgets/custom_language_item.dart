import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/colors.dart';

class CustomLanguageItem extends StatelessWidget {
  const CustomLanguageItem({
    super.key,
    required this.flagpath,
    required this.langName,
    required this.index,
    required this.groupValue,
    required this.onChange,
  });
  final String flagpath;
  final String langName;
  final int index;
  final int groupValue;
  final void Function(int?) onChange;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: index,
          groupValue: groupValue,
          onChanged: onChange,
          activeColor: primary,
        ),
        SvgPicture.asset(flagpath, height: 20, width: 20, fit: BoxFit.cover),
        const SizedBox(width: 10),
        Text(
          langName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
