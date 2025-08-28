import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/colors.dart';
import '../widgets/custom_button.dart';

Future<bool?> customConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required void Function() onPressed,
}) {
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
            vertical: 5,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                onPressed();
                context.pop();
              },
              text: 'Yes',
              size: Size(60, 30),
            ),
          ],
        ),
  );
}
