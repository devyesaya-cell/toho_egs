import 'package:flutter/material.dart';
import '../../core/utils/app_theme.dart';
import 'pages/management_page.dart';
import 'pages/calibration_page.dart';
import 'pages/sync_page.dart';
import 'pages/radio_page.dart';
import 'pages/debug_page.dart';
import 'pages/about_us_page.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Management',
        'icon': Icons.folder,
        'color': Colors.amber,
        'page': const ManagementPage(),
      },
      {
        'title': 'Calibration',
        'icon': Icons.settings,
        'color': Colors.orange,
        'page': const CalibrationPage(),
      },
      {
        'title': 'Synchronize',
        'icon': Icons.sync_alt_rounded,
        'color': Colors.lightGreen,
        'page': const SyncPage(),
      },
      {
        'title': 'Radio',
        'icon': Icons.signal_cellular_alt,
        'color': Colors.blueGrey,
        'page': const RadioPage(),
      },
      {
        'title': 'Debug',
        'icon': Icons.device_hub,
        'color': Colors.blue,
        'page': const DebugPage(),
      },
      {
        'title': 'About',
        'icon': Icons.info,
        'color': Colors.grey,
        'page': const AboutUsPage(),
      },
    ];

    return Scaffold(
      backgroundColor: theme.pageBackground,
      appBar: AppBar(
        title: Text(
          'SETUP',
          style: TextStyle(
            color: theme.appBarForeground,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: theme.appBarBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.appBarForeground),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return _buildMenuCard(context, item, theme);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, Map<String, dynamic> item, AppThemeData theme) {
    return Material(
      color: theme.cardSurface,
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item['page']),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item['icon'], size: 64, color: item['color']),
            const SizedBox(height: 16),
            Text(
              item['title'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: theme.textOnSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
