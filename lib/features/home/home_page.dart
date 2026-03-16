import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/side_menu.dart';
import '../workfile/workfile_page.dart';
import '../dashboard/dashboard_page.dart';
import '../timesheet/timesheet_page.dart';
import '../alarm/alarm_page.dart';
import '../setup/setup_page.dart';
import '../../core/coms/com_service.dart';
import '../../core/utils/app_theme.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoConnectUsb();
    });
  }

  Future<void> _autoConnectUsb() async {
    final comService = ref.read(comServiceProvider.notifier);
    await comService.autoConnect('CP2102N');

    final isConnected = ref.read(comServiceProvider).isConnected;
    const deviceName = "USB Device";

    if (mounted && isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Device connected: $deviceName'),
          backgroundColor: Colors.green, // semantic — always green
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final selectedIndex = ref.watch(selectedMenuProvider);

    Widget content;
    switch (selectedIndex) {
      case 0:
        content = const WorkfilePage();
        break;
      case 1:
        content = const DashboardPage();
        break;
      case 2:
        content = const TimesheetPage();
        break;
      case 3:
        content = const AlarmPage();
        break;
      case 4:
        content = const SetupPage();
        break;
      default:
        content = const DashboardPage();
    }

    return Scaffold(
      backgroundColor: theme.surfaceColor,
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.pageBackground,
                borderRadius: BorderRadius.circular(24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
