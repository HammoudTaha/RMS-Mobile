import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField({
    super.key,
    required this.hint,
    required this.preIcon,
    required this.onSave,
    required this.validator,
    this.visibile = false,
    this.keyboardType = TextInputType.text,
    this.initailValue,
  });
  final String hint;
  final IconData? preIcon;
  final void Function(String?)? onSave;
  final String? Function(String?)? validator;
  final bool visibile;
  final TextInputType keyboardType;
  final String? initailValue;
  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool isVisibile = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextFormField(
        obscureText: widget.visibile ? !isVisibile : false,
        initialValue: widget.initailValue,
        onSaved: widget.onSave,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: Icon(widget.preIcon, color: Colors.black54),
          suffixIcon: IconButton(
            onPressed: () {
              isVisibile = !isVisibile;
              setState(() {});
            },
            icon: Icon(
              !widget.visibile
                  ? null
                  : isVisibile
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
          enabledBorder: outlineBorder(Colors.black12),
          focusedBorder: outlineBorder(primary),
          border: outlineBorder(Colors.black12),
          errorBorder: outlineBorder(Colors.red),
        ),
      ),
    );
  }

  OutlineInputBorder outlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 2),
    );
  }
}
