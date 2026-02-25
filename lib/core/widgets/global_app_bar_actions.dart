import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../coms/com_service.dart';
import '../state/auth_state.dart';
// Note: If you need to stop timesheet on logout globally, you might need
// to add a callback or handle it in the provider.
// Given global usage, let's handle TimesheetProvider from here.
import '../../features/timesheet/presenter/timesheet_presenter.dart';

class GlobalAppBarActions extends ConsumerWidget {
  final bool showStreamStatus;

  const GlobalAppBarActions({super.key, this.showStreamStatus = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usbState = ref.watch(comServiceProvider);

    // Check if calibStreamProvider exists or is needed.
    // If we are not on calibration page, calibStreamProvider might not be active or even imported here.
    // Let's abstract the stream status or just ignore it for the generic global one.
    // Since we want this to be generic, the stream status might need to be passed in
    // or just removed if it's only on calibration page. The user asked for the Timesheet AppBar design,
    // so we'll just stick to RS232 status.

    bool hasDataStream = false;
    if (usbState.lastDataReceived != null) {
      final diff = DateTime.now().difference(usbState.lastDataReceived!);
      if (diff.inSeconds < 2) {
        hasDataStream = true;
      }
    }
    final bool isActive = usbState.isConnected && hasDataStream;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Connection Status
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(
                  Icons.usb,
                  color: isActive ? Colors.greenAccent : Colors.red,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  isActive ? 'RS232 Active' : 'RS232 Inactive',
                  style: TextStyle(
                    color: isActive ? Colors.greenAccent : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 16),
        Container(width: 1, height: 24, color: const Color(0xFF1E3A2A)),
        const SizedBox(width: 16),
        // Profile Widget
        Builder(
          builder: (context) {
            final authState = ref.watch(authProvider);
            final person = authState.currentUser;
            final name = person != null
                ? '${person.firstName} ${person.lastName}'
                : 'Unknown';
            final contractor = person?.kontraktor ?? 'Unknown';
            final photoUrl = person?.picURL;

            return InkWell(
              onTap: () {
                _showLogoutDialog(context, ref);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: photoUrl != null && photoUrl.isNotEmpty
                          ? AssetImage(photoUrl)
                          : const AssetImage('images/avatar_person.png'),
                      backgroundColor: const Color(0xFF1E293B),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          contractor,
                          style: const TextStyle(
                            color: Color(0xFF2ECC71),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.orange),
            SizedBox(width: 8),
            Text('Sign Out', style: TextStyle(color: Colors.white)),
          ],
        ),
        content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              // Stop timesheet if running before logging out
              final notifier = ref.read(timesheetProvider.notifier);
              final state = ref.read(timesheetProvider);
              if (state.isRunning) {
                await notifier.stopActivity();
              }
              // Unauthenticate
              ref.read(authProvider.notifier).logout();
              // Navigation to login is handled automatically by the GoRouter redirect in app.dart based on authProvider state
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('SIGN OUT'),
          ),
        ],
      ),
    );
  }
}
