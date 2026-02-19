import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/side_menu.dart';
import '../dashboard/dashboard_page.dart';
import '../timesheet/timesheet_page.dart';
import '../workfile/workfile_page.dart';
import '../setup/setup_page.dart';
import '../../core/coms/com_service.dart';

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
    // Trigger Auto Connect via ComService
    // "CP2102N" is the filter string
    final comService = ref.read(comServiceProvider.notifier);
    await comService.autoConnect('CP2102N');

    // Check connection status after attempt
    final isConnected = ref.read(comServiceProvider).isConnected;
    // UsbPort doesn't expose productName directly easily without device wrapper,
    // but the state has the list of devices.
    // For now, let's just confirm connection.
    const deviceName = "USB Device";

    if (mounted && isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Device connected: $deviceName'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Map selected index to Feature Pages
    // 0: Workfile, 1: Dashboard, 2: Timesheet, 3: Alarm (Placeholder), 4: Setup
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
        content = const Scaffold(
          body: Center(child: Text('Alarm Page')),
        ); // Placeholder
        break;
      case 4:
        content = const SetupPage();
        break;
      default:
        content = const DashboardPage();
    }

    return Scaffold(
      backgroundColor: const Color(
        0xFFE2EFF7,
      ), // Light Blue background for content
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE2EFF7),
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
