import 'package:flutter/material.dart';
import '../../../core/widgets/global_app_bar_actions.dart';
import '../widgets/debug/rover_debug_tab.dart';
import '../widgets/debug/basestation_debug_tab.dart';
import '../widgets/debug/alert_debug_tab.dart';
import '../../../core/utils/app_theme.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: theme.pageBackground,
        appBar: AppBar(
          backgroundColor: theme.appBarBackground,
          foregroundColor: theme.appBarForeground,
          elevation: 0,
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.iconBoxBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.bug_report, color: theme.iconBoxIcon, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DEBUG',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 18,
                      color: theme.appBarForeground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'EGS DEBUG V4.0.0',
                    style: TextStyle(
                      color: theme.appBarAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: const [GlobalAppBarActions(), SizedBox(width: 16)],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: theme.appBarAccent,
            labelColor: theme.appBarAccent,
            unselectedLabelColor: theme.textSecondary,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'ROVER'),
              Tab(text: 'BASESTATION'),
              Tab(text: 'ALERT'),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: theme.cardBorderColor)),
          ),
          child: const TabBarView(
            children: [RoverDebugTab(), BasestationDebugTab(), AlertDebugTab()],
          ),
        ),
      ),
    );
  }
}
