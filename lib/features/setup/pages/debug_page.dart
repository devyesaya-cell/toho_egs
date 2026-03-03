import 'package:flutter/material.dart';
import '../../../core/widgets/global_app_bar_actions.dart';
import '../widgets/debug/rover_debug_tab.dart';
import '../widgets/debug/basestation_debug_tab.dart';
import '../widgets/debug/alert_debug_tab.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F1410),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F1410),
          foregroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              // Green Icon Box
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A2A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.bug_report,
                  color: Color(0xFF2ECC71),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Titles
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DEBUG',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'EGS DEBUG V4.0.0',
                    style: TextStyle(
                      color: Color(0xFF2ECC71), // Primary Green
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
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color(0xFF2ECC71),
            labelColor: Color(0xFF2ECC71),
            unselectedLabelColor: Colors.white54,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'ROVER'),
              Tab(text: 'BASESTATION'),
              Tab(text: 'ALERT'),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF1E3A2A))),
          ),
          child: const TabBarView(
            children: [RoverDebugTab(), BasestationDebugTab(), AlertDebugTab()],
          ),
        ),
      ),
    );
  }
}
