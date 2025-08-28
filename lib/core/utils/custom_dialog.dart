import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

Future<bool?> customAlertDialog(
  BuildContext context, {
  required String text,
  required void Function() onPressed,
  required void Function(String?) onSave,
  String? initalValue,
}) {
  GlobalKey<FormState> formStateKey = GlobalKey();
  return showDialog<bool>(
    context: context,

    builder:
        (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color(0xffFFFFFF),
          titlePadding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          actionsPadding: const EdgeInsets.only(bottom: 5),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 0,
          ),
          title: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: Form(
            key: formStateKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    lines: 3,
                    text: 'Describe Your Special Requests',
                    onSave: onSave,
                    initialValue: initalValue,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      if (formStateKey.currentState?.validate() ?? false) {
                        formStateKey.currentState?.save();
                        onPressed();
                        context.pop();
                      }
                    },
                    text: 'Submit',
                  ),
                ],
              ),
            ),
          ),
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
          ],
        ),
  );
}
