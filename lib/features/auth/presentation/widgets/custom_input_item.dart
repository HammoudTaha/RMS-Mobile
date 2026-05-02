import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/colors.dart';

class CustomIntputItem extends StatelessWidget {
  const CustomIntputItem({super.key, required this.onSave});

  final void Function(String?) onSave;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 60,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextFormField(
          textAlign: TextAlign.center,
          cursorHeight: 30,
          textAlignVertical: TextAlignVertical.top,
          validator: (value) {
            if (value!.isEmpty) {
              return '';
            }
            return null;
          },
          onSaved: onSave,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          style: Theme.of(context).textTheme.headlineLarge,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(5),
            filled: true,
            enabledBorder: outlineBorder(Colors.grey),
            focusedBorder: outlineBorder(primary),
            errorBorder: outlineBorder(Colors.red),
            focusedErrorBorder: outlineBorder(primary),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder outlineBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: color),
    );
  }
}
