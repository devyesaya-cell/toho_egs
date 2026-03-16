import 'package:flutter/material.dart';
import '../../../core/utils/app_theme.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: theme.pageBackground,
      appBar: AppBar(
        title: Text('About Us', style: TextStyle(color: theme.appBarForeground)),
        backgroundColor: theme.appBarBackground,
        iconTheme: IconThemeData(color: theme.appBarForeground),
      ),
      body: Center(
        child: Text(
          'About Us Page Placeholder',
          style: TextStyle(color: theme.textOnSurface),
        ),
      ),
    );
  }
}
