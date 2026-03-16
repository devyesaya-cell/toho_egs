import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/coms/com_service.dart';
import '../presenter/calibration_presenter.dart';
import 'package:usb_serial/usb_serial.dart';

import '../../../core/state/auth_state.dart';
import '../widgets/calibration/offset_calibration_tab.dart';
import '../widgets/calibration/body_calibration_tab.dart';
import '../widgets/calibration/boom_calibration_tab.dart';
import '../widgets/calibration/stick_calibration_tab.dart';
import '../widgets/calibration/attachment_calibration_tab.dart';
import '../../../core/utils/app_theme.dart';

class CalibrationPage extends ConsumerStatefulWidget {
  const CalibrationPage({super.key});

  @override
  ConsumerState<CalibrationPage> createState() => _CalibrationPageState();
}

class _CalibrationPageState extends ConsumerState<CalibrationPage> {
  final CalibrationPresenter _presenter = CalibrationPresenter();
  UsbPort? _activePort;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final usbState = ref.read(comServiceProvider);
      if (usbState.port != null) {
        _activePort = usbState.port;
        _presenter.setConfig(_activePort!);
      }
    });
  }

  @override
  void dispose() {
    if (_activePort != null) {
      _presenter.setNormal(_activePort!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: theme.pageBackground,
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.iconBoxBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.precision_manufacturing,
                  color: theme.iconBoxIcon,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EQUIPMENT CALIBRATION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 18,
                      color: theme.appBarForeground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'EGS CALIBRATION V4.0.0',
                    style: TextStyle(
                      color: theme.appBarAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _buildAppBarActions(context, ref, theme),
              const SizedBox(width: 16),
            ],
          ),
          backgroundColor: theme.appBarBackground,
          foregroundColor: theme.appBarForeground,
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: theme.appBarAccent,
            labelColor: theme.appBarAccent,
            unselectedLabelColor: theme.textSecondary,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'OFFSET CALIBRATION'),
              Tab(text: 'BODY CALIBRATION'),
              Tab(text: 'BOOM CALIBRATION'),
              Tab(text: 'STICK CALIBRATION'),
              Tab(text: 'ATTACHMENT CALIBRATION'),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: theme.cardBorderColor)),
          ),
          child: Consumer(
            builder: (context, ref, child) {
              return const TabBarView(
                children: [
                  OffsetCalibrationTab(),
                  BodyCalibrationTab(),
                  BoomCalibrationTab(),
                  StickCalibrationTab(),
                  AttachmentCalibrationTab(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarActions(
      BuildContext context, WidgetRef ref, AppThemeData theme) {
    final usbState = ref.watch(comServiceProvider);
    final calibAsync = ref.watch(calibStreamProvider);
    bool hasDataStream = false;
    if (usbState.lastDataReceived != null) {
      final diff = DateTime.now().difference(usbState.lastDataReceived!);
      if (diff.inSeconds < 2) {
        hasDataStream = true;
      }
    }
    final bool isActive = usbState.isConnected && hasDataStream;
    final bool isCalibActive = calibAsync.hasValue && hasDataStream;

    // Status indicators remain semantic colors (green/red)
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
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
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.stream,
                  color: isCalibActive ? Colors.greenAccent : Colors.red,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  isCalibActive ? 'Config Active' : 'Config Inactive',
                  style: TextStyle(
                    color: isCalibActive ? Colors.greenAccent : Colors.red,
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
              onTap: () => _showLogoutDialog(context, ref, theme),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: photoUrl != null && photoUrl.isNotEmpty
                          ? AssetImage(photoUrl)
                          : const AssetImage('images/avatar_person.png'),
                      backgroundColor: theme.surfaceColor,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: TextStyle(
                                color: theme.appBarForeground,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                        Text(contractor,
                            style: TextStyle(
                                color: theme.appBarAccent, fontSize: 10)),
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
            child: Text('CANCEL',
                style: TextStyle(color: theme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(authProvider.notifier).logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryButtonBackground,
              foregroundColor: theme.primaryButtonText,
            ),
            child: const Text('SIGN OUT'),
          ),
        ],
      ),
    );
  }
}
