import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerStateKey = GlobalKey();
void showSnakbar(String message) {
  scaffoldMessengerStateKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      width: message.length * 10 > 350 ? 350 : message.length * 7 + 60,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 6),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.black,
    ),
  );
}
