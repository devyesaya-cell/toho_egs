import 'package:flutter/material.dart';
import 'app_theme.dart';

class DialogUtils {
  static Future<void> showDetailDialog({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(child: content),
          actions:
              actions ??
              [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
        );
      },
    );
  }

  static Future<bool> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    final theme = AppTheme.of(context);
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.dialogBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: theme.textOnSurface),
          ),
          content: Text(
            message,
            style: TextStyle(color: theme.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel', style: TextStyle(color: theme.textSecondary)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444), // Red for destructive actions
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    ) ?? false;
  }

  static Widget buildKeyValue(String key, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const Divider(),
      ],
    );
  }

  static Future<void> showDelayConfigDialog({
    required BuildContext context,
    required double currentDelay,
    required Function(double) onSave,
  }) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E3020) : Colors.orange.shade50;
    final textColor = isDark ? Colors.white : Colors.black87;
    final options = [2.0, 3.0, 5.0, 7.0, 10.0];
    double selectedDelay = currentDelay;

    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Spot Completion Delay',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select the duration (in seconds) the bucket must remain within 10cm of the target spot.',
                    style: TextStyle(color: textColor, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  ...options.map((val) => RadioListTile<double>(
                        title: Text('${val.toInt()} seconds',
                            style: TextStyle(color: textColor)),
                        value: val,
                        groupValue: selectedDelay,
                        activeColor: isDark ? Colors.greenAccent : Colors.orange,
                        onChanged: (double? newValue) {
                          setState(() {
                            selectedDelay = newValue!;
                          });
                        },
                      )),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel',
                      style: TextStyle(
                          color: isDark ? Colors.white54 : Colors.black54)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.green : Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    onSave(selectedDelay);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
