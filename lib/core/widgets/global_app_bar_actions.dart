import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../coms/com_service.dart';
import '../state/auth_state.dart';
import '../../features/timesheet/presenter/timesheet_presenter.dart';
import '../utils/app_theme.dart';

class GlobalAppBarActions extends ConsumerWidget {
  final bool showStreamStatus;

  const GlobalAppBarActions({super.key, this.showStreamStatus = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final usbState = ref.watch(comServiceProvider);

    bool hasDataStream = false;
    if (usbState.lastDataReceived != null) {
      final diff = DateTime.now().difference(usbState.lastDataReceived!);
      if (diff.inSeconds < 2) {
        hasDataStream = true;
      }
    }
    final bool isActive = usbState.isConnected && hasDataStream;

    // USB status uses semantic colors — always green/red regardless of theme
    const Color usbActiveColor = Colors.greenAccent;
    const Color usbInactiveColor = Colors.red;
    final Color usbColor = isActive ? usbActiveColor : usbInactiveColor;

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
                Icon(Icons.usb, color: usbColor, size: 14),
                const SizedBox(width: 4),
                Text(
                  isActive ? 'RS232 Active' : 'RS232 Inactive',
                  style: TextStyle(
                    color: usbColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 16),
        Container(width: 1, height: 24, color: theme.menuBorder),
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
                _showLogoutDialog(context, ref, theme);
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
                          : const AssetImage('images/driver_exca.png'),
                      backgroundColor: theme.surfaceColor,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: theme.appBarForeground,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          contractor,
                          style: TextStyle(
                            color: theme.appBarAccent,
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

  void _showLogoutDialog(
      BuildContext context, WidgetRef ref, AppThemeData theme) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.dialogBackground,
        title: Row(
          children: [
            const Icon(Icons.logout, color: Colors.orange), // semantic
            const SizedBox(width: 8),
            Text('Sign Out', style: TextStyle(color: theme.textOnSurface)),
          ],
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: theme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'CANCEL',
              style: TextStyle(color: theme.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              final notifier = ref.read(timesheetProvider.notifier);
              final state = ref.read(timesheetProvider);
              if (state.isRunning) {
                await notifier.stopActivity();
              }
              ref.read(authProvider.notifier).logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange, // semantic — sign-out warning
              foregroundColor: Colors.white,
            ),
            child: const Text('SIGN OUT'),
          ),
        ],
      ),
    );
  }
}
