import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/management/person_tab.dart';
import '../widgets/management/workfile_tab.dart';
import '../widgets/management/contractor_tab.dart';
import '../widgets/management/equipment_tab.dart';
import '../widgets/management/area_tab.dart';

class ManagementPage extends ConsumerWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F5F9), // Light grey background
        appBar: AppBar(
          title: const Text('Management'),
          backgroundColor: const Color(0xFF0D2C54), // Dark Blue
          foregroundColor: Colors.white,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.amber,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Person', icon: Icon(Icons.person)),
              Tab(text: 'Workfile', icon: Icon(Icons.folder)),
              Tab(text: 'Contractor', icon: Icon(Icons.business)),
              Tab(
                text: 'Equipment',
                icon: Icon(Icons.handyman),
              ), // or construction
              Tab(text: 'Area', icon: Icon(Icons.map)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PersonTab(),
            WorkfileTab(),
            ContractorTab(),
            EquipmentTab(),
            AreaTab(),
          ],
        ),
      ),
    );
  }
}
