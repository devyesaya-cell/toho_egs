import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/management/person_tab.dart';
import '../widgets/management/workfile_tab.dart';
import '../widgets/management/contractor_tab.dart';
import '../widgets/management/equipment_tab.dart';
import '../widgets/management/area_tab.dart';
import '../widgets/management/timesheet_data_tab.dart';

class ManagementPage extends ConsumerWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F1410), // Dark background
        appBar: AppBar(
          title: const Text(
            'MANAGEMENT',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
          ),
          backgroundColor: const Color(0xFF0F1410), // Dark background
          foregroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color(0xFF2ECC71), // Green
            labelColor: Color(0xFF2ECC71), // Green
            unselectedLabelColor: Colors.white54,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'PERSON', icon: Icon(Icons.person)),
              Tab(text: 'WORKFILE', icon: Icon(Icons.folder)),
              Tab(text: 'CONTRACTOR', icon: Icon(Icons.business)),
              Tab(text: 'EQUIPMENT', icon: Icon(Icons.handyman)),
              Tab(text: 'AREA', icon: Icon(Icons.map)),
              Tab(text: 'TIMESHEET', icon: Icon(Icons.timer)),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF1E3A2A))),
          ),
          child: const TabBarView(
            children: [
              PersonTab(),
              WorkfileTab(),
              ContractorTab(),
              EquipmentTab(),
              AreaTab(),
              TimesheetDataTab(),
            ],
          ),
        ),
      ),
    );
  }
}
