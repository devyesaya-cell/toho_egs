import 'package:flutter/material.dart';
import 'pages/management_page.dart';
import 'pages/calibration_page.dart';
import '../sync/sync_page.dart';
import '../radio/radio_page.dart';
import '../debug/debug_page.dart';
import 'pages/about_us_page.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the menu items
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Management',
        'icon': Icons.folder, // Placeholder icon
        'color': Colors.amber, // Placeholder color
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
        'color': Colors.black87,
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
      backgroundColor: const Color(0xFF0F1410), // Main Background
      appBar: AppBar(
        title: const Text(
          'SETUP',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF0F1410),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Ensure back button is visible
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate grid cross axis count based on width, but use 3 as default for landscape/tablet
            // Ideally 3 items per row as per image
            return GridView.builder(
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.3, // Adjust for card shape
              ),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return _buildMenuCard(context, item);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, Map<String, dynamic> item) {
    return Material(
      color: const Color(0xFF1E293B), // Surface Dark
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
            // Icon Container - Replace with Image assets later if needed
            Icon(item['icon'], size: 64, color: item['color']),
            const SizedBox(height: 16),
            Text(
              item['title'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
