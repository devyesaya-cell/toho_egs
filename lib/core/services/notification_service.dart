import 'package:flutter/material.dart';

class NotificationService {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackbar(String message, {Color? backgroundColor}) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? Colors.black87,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void showError(String message) {
    showSnackbar(message, backgroundColor: Colors.red);
  }

  static void showSuccess(String message) {
    showSnackbar(message, backgroundColor: Colors.green);
  }

  static void showWarning(String message) {
    showSnackbar(message, backgroundColor: Colors.orange);
  }
}
