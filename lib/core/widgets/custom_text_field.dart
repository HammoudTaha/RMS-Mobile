import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.lines,
    this.text = '',
    required this.onSave,
    this.initialValue,
  });
  final int lines;
  final String text;
  final void Function(String?) onSave;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: lines,
      initialValue: initialValue,
      textAlign: TextAlign.start,
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return "Can't be empty";
        } else {
          return null;
        }
      },
      onSaved: onSave,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        hintText: text,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: outLine(),
        focusedBorder: outLine(),
        errorBorder: outLine(color: Colors.red),
        focusedErrorBorder: outLine(color: Colors.red),
      ),
    );
  }

  outLine({Color color = primary}) {
    return OutlineInputBorder(borderSide: BorderSide(color: color, width: 2));
  }
}
