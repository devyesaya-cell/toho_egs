import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../map_presenter.dart';

class TimesheetEndDialog extends ConsumerStatefulWidget {
  const TimesheetEndDialog({super.key});

  @override
  ConsumerState<TimesheetEndDialog> createState() => _TimesheetEndDialogState();
}

class _TimesheetEndDialogState extends ConsumerState<TimesheetEndDialog> {
  final _hmController = TextEditingController();

  void _stop() async {
    final hmText = _hmController.text;
    final hmEnd = double.tryParse(hmText) ?? 0;

    if (hmText.isEmpty || hmEnd <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid HM End')),
      );
      return;
    }

    // Stop timesheet and update hmEnd logic will be handled here or in presenter
    await ref.read(mapPresenterProvider.notifier).stopTimesheet(hmEnd: hmEnd);

    if (context.mounted) {
      Navigator.of(context).pop(true); // Return true to indicate success
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF0F1410), // Dark background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Stop Recording Activity',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please enter HM End before exiting the map.',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            const Text('HM End', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            TextField(
              controller: _hmController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter HM End Value',
                hintStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2ECC71)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2ECC71), width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false), // User cancelled
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2ECC71), // Green
            foregroundColor: Colors.white,
          ),
          onPressed: _stop,
          child: const Text(
            'STOP & EXIT',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
