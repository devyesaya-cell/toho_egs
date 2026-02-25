import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/state/auth_state.dart';
import '../../features/home/home_page.dart';
import '../../features/auth/login_page.dart';
import '../../features/setup/presenter/calibration_presenter.dart';
import '../../core/coms/com_service.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  void initState() {
    super.initState();
    // Auto-connect to USB on app start (empty filter matches all)
    // Using Future.microtask to avoid build phase issues, though initState is usually fine for read.
    Future.microtask(() async {
      await ref.read(comServiceProvider.notifier).autoConnect("CP2102N");
      final port = ref.read(comServiceProvider).port;
      if (port != null && mounted) {
        final presenter = CalibrationPresenter();
        presenter.setNormal(port); // Inform MCU to stream normal operation data
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    if (authState.currentUser != null) {
      return const HomePage();
    } else {
      return const LoginPage();
    }
  }
}
