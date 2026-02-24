import 'package:flutter/material.dart';

class RadioConfigPage extends StatelessWidget {
  const RadioConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1410),
      appBar: AppBar(
        title: const Text(
          'Radio Config',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0F1410),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text(
          'Radio Config Page Placeholder',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
