import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/management/person_tab.dart';
import '../widgets/management/workfile_tab.dart';
import '../widgets/management/contractor_tab.dart';
import '../widgets/management/equipment_tab.dart';
import '../widgets/management/area_tab.dart';
import '../widgets/management/timesheet_data_tab.dart';
import '../../../core/utils/app_theme.dart';

class ManagementPage extends ConsumerWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: theme.pageBackground,
        appBar: AppBar(
          title: Text(
            'MANAGEMENT',
            style: TextStyle(
              color: theme.appBarForeground,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
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
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: theme.cardBorderColor)),
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
