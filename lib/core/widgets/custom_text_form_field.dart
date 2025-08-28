import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.text = 'Search Items',
    this.onSubmit,
    this.onChange,
  });
  final String text;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        decoration: InputDecoration(
          hintText: text,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              'assets/icons/nav_search.svg',
              fit: BoxFit.cover,
            ),
          ),
          enabledBorder: outlineBorder(),
          focusedBorder: outlineBorder(),
          errorBorder: outlineBorder(),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.white),
    );
  }
}
