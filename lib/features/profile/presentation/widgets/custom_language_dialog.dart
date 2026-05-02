import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_button.dart';

Future<bool?> customLanguageDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder:
        (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color(0xffFFFFFF),
          titlePadding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          actionsPadding: const EdgeInsets.only(bottom: 5, right: 5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 0,
          ),
          title: Text(
            'Select Your Language',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: CustomLanguageDialogContent(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CustomButton(onPressed: () {}, text: 'Confirm', size: Size(80, 35)),
          ],
        ),
  );
}

class CustomLanguageDialogContent extends StatefulWidget {
  const CustomLanguageDialogContent({super.key});

  @override
  State<CustomLanguageDialogContent> createState() =>
      _CustomLanguageDialogContentState();
}

class _CustomLanguageDialogContentState
    extends State<CustomLanguageDialogContent> {
  int _groupValue = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 350,
      child: Column(
        children: [
          CustomLanguageItem(
            flagpath: 'assets/icons/KSA.svg',
            langName: 'Arabic(KSA)',
            index: 0,
            groupValue: _groupValue,
            onChange: (value) {
              setState(() {
                _groupValue = value!;
              });
            },
          ),
          CustomLanguageItem(
            flagpath: 'assets/icons/SAR.svg',
            langName: 'Arabic(Syria)',
            index: 1,
            groupValue: _groupValue,
            onChange: (value) {
              setState(() {
                _groupValue = value!;
              });
            },
          ),
          CustomLanguageItem(
            flagpath: 'assets/icons/USA.svg',
            langName: 'English(USA)',
            index: 2,
            groupValue: _groupValue,
            onChange: (value) {
              setState(() {
                _groupValue = value!;
              });
            },
          ),
          CustomLanguageItem(
            flagpath: 'assets/icons/UK.svg',
            langName: 'English(UK)',
            index: 3,
            groupValue: _groupValue,
            onChange: (value) {
              setState(() {
                _groupValue = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}

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
