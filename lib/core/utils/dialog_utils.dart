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
    required bool isAutoEnabled,
    required Function(double, bool) onSave,
  }) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E3020) : Colors.orange.shade50;
    final textColor = isDark ? Colors.white : Colors.black87;
    final options = [1.0, 1.5, 2.0, 2.5, 3.0];
    double selectedDelay = currentDelay;
    bool autoEnabled = isAutoEnabled;

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
                'Spot Completion Setup',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: Text(
                      'Automatic Done',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      autoEnabled ? 'Enabled' : 'Disabled (Manual)',
                      style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 11),
                    ),
                    value: autoEnabled,
                    activeColor: isDark ? Colors.greenAccent : Colors.orange,
                    onChanged: (val) {
                      setState(() {
                        autoEnabled = val;
                      });
                    },
                  ),
                  const Divider(),
                  if (autoEnabled) ...[
                    Text(
                      'Wait duration (seconds) inside 10cm:',
                      style: TextStyle(color: textColor, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    ...options.map((val) => RadioListTile<double>(
                          title: Text('$val seconds',
                              style: TextStyle(color: textColor, fontSize: 14)),
                          value: val,
                          dense: true,
                          groupValue: selectedDelay,
                          activeColor: isDark ? Colors.greenAccent : Colors.orange,
                          onChanged: (double? newValue) {
                            setState(() {
                              selectedDelay = newValue!;
                            });
                          },
                        )),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Automatic status change is disabled. Target spots will not turn green automatically.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
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
                    onSave(selectedDelay, autoEnabled);
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
