import 'package:flutter/material.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1410),
      appBar: AppBar(
        title: const Text('Debug', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0F1410),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text(
          'Debug Page Placeholder',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
