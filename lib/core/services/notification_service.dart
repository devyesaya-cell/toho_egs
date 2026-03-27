import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

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

  /// Displays a custom floating SnackBar notification.
  /// The [context] is used to find the Scaffold and get MediaQuery size.
  /// The sizing is fully responsive: Left/Right margin 45% of width, Bottom margin 40% of width.
  /// Duration is set to 2 seconds.
  static void showCommandNotification(
    BuildContext context, {
    required String title,
    required String message,
    required String modeStr,
    required IconData icon,
    required Color iconColor,
    required Color headerColor,
  }) {
    if (!context.mounted) return;

    final mediaQuery = MediaQuery.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Responsive Margins
    // Left/Right: 45% of screen width -> meaning the snackbar width is 10% of screen width
    // Bottom: 40% of screen width
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double leftRightMargin = screenWidth * 0.4;
    final double bottomMargin = screenHeight * 0.4;
    final theme = AppTheme.of(context);

    scaffoldMessenger.clearSnackBars();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(
          bottom: bottomMargin,
          left: leftRightMargin,
          right: leftRightMargin,
        ),
        content: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: theme.dialogBackground, // Theme content background
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header (Title)
              Container(
                width: double.infinity,
                color: headerColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Icon(icon, color: iconColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        color: theme.textOnSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Content (Message)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        color: theme.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      modeStr,
                      style: TextStyle(
                        color: theme.textOnSurface,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 2), // Changed to 2 seconds
      ),
    );
  }
}
