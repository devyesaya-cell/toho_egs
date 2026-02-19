import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/landing/landing_page.dart';
import 'core/services/notification_service.dart';
import 'core/database/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enforce Landscape Orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Initialize Database
  await DatabaseService().init();

  // Enable Full Screen (Immersive Sticky) - Hides Status Bar & Nav Bar
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: NotificationService.messengerKey,
      title: 'Toho EGS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(
          0xFFF1F5F9,
        ), // Light grey background
        fontFamily: 'Roboto', // Use default for now, can be updated
      ),
      home: const LandingPage(),
    );
  }
}
