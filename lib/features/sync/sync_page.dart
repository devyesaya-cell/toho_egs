import 'package:flutter/material.dart';
import '../../core/widgets/global_app_bar_actions.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: const Icon(Icons.sync, color: Color(0xFF2ECC71), size: 24),
            ),
            const SizedBox(width: 16),
            // Titles
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SYNCHRONIZE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'EGS SYNCHRONIZE V4.0.0',
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
      ),
      body: Center(
        child: Image.asset('images/under_cons.png', fit: BoxFit.contain),
      ),
    );
  }
}
