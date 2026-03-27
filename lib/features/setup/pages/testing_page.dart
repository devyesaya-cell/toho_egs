import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import '../../../../core/coms/com_service.dart';
import '../../../../core/services/voice_recognition_service.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/state/auth_state.dart';

class TestingPage extends ConsumerStatefulWidget {
  const TestingPage({super.key});

  @override
  ConsumerState<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends ConsumerState<TestingPage> {
  final TextEditingController _ttsController = TextEditingController();

  @override
  void dispose() {
    _ttsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final gpsAsync = ref.watch(gpsStreamProvider);
    final voiceState = ref.watch(voiceRecognitionProvider);

    return Scaffold(
      backgroundColor: theme.pageBackground,
      appBar: AppBar(
        title: Text(
          'TESTING',
          style: TextStyle(
            color: theme.appBarForeground,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: theme.appBarBackground,
        foregroundColor: theme.appBarForeground,
        elevation: 0,
        actions: [
          _buildAppBarActions(context, ref, theme),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: gpsAsync.when(
            data: (gps) {
              final headingRadians = gps.heading * (math.pi / 180.0);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Heading: ${gps.heading.toStringAsFixed(2)}°',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.textOnSurface,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: theme.cardSurface,
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.cardBorderColor, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Transform.rotate(
                        angle: headingRadians,
                        child: SvgPicture.asset(
                          'images/exca_full.svg',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // STANDBY MODE TOGGLE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.cardSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.cardBorderColor),
                      ),
                      child: SwitchListTile(
                        title: const Text('Standby Mode',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('Mendengarkan kata kunci (Jarvis)'),
                        value: voiceState.isStandbyActive,
                        activeColor: const Color(0xFF2ECC71),
                        onChanged: (val) {
                          ref
                              .read(voiceRecognitionProvider.notifier)
                              .toggleStandby(val);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // VOICE RECOGNITION DISPLAY
                  if (voiceState.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'Perintah Suara:\n"${voiceState.text}"',
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.textOnSurface,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (voiceState.error.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
                      child: Text(
                        voiceState.error,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 24),
                  FloatingActionButton(
                    heroTag: 'voice_mic',
                    backgroundColor: voiceState.isListening
                        ? Colors.red
                        : const Color(0xFF2ECC71),
                    onPressed: () {
                      final notifier = ref.read(
                        voiceRecognitionProvider.notifier,
                      );
                      if (voiceState.isListening) {
                        notifier.stopListening();
                      } else {
                        notifier.startListening();
                      }
                    },
                    child: Icon(
                      voiceState.isListening ? Icons.mic : Icons.mic_none,
                      color: Colors.white,
                    ),
                  ),
                  if (voiceState.isListening)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Mendengarkan...',
                        style: TextStyle(
                          color: theme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 48),
                  const Divider(),
                  // TEXT TO SPEECH SECTION
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TEXT TO SPEECH TEST',
                          style: TextStyle(
                            color: theme.textSecondary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _ttsController,
                          style: TextStyle(color: theme.textOnSurface),
                          decoration: InputDecoration(
                            hintText: 'Masukkan teks di sini...',
                            hintStyle: TextStyle(color: theme.textSecondary),
                            filled: true,
                            fillColor: theme.cardSurface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: theme.cardBorderColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2ECC71),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            icon: const Icon(Icons.volume_up),
                            label: const Text('UCAPKAN TEKS'),
                            onPressed: () {
                              ref
                                  .read(voiceRecognitionProvider.notifier)
                                  .speak(_ttsController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Waiting for GPS Data...'),
                ],
              ),
            ),
            error: (err, stack) => Text(
              'Error reading data: $err',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarActions(
    BuildContext context,
    WidgetRef ref,
    AppThemeData theme,
  ) {
    final usbState = ref.watch(comServiceProvider);

    bool hasDataStream = false;
    if (usbState.lastDataReceived != null) {
      final diff = DateTime.now().difference(usbState.lastDataReceived!);
      if (diff.inSeconds < 2) {
        hasDataStream = true;
      }
    }
    final bool isActive = usbState.isConnected && hasDataStream;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(
                  Icons.usb,
                  color: isActive ? Colors.greenAccent : Colors.red,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  isActive ? 'RS232 Active' : 'RS232 Inactive',
                  style: TextStyle(
                    color: isActive ? Colors.greenAccent : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 16),
        Container(width: 1, height: 24, color: theme.menuBorder),
        const SizedBox(width: 16),
        Builder(
          builder: (context) {
            final authState = ref.watch(authProvider);
            final person = authState.currentUser;
            final name = person != null
                ? '${person.firstName} ${person.lastName}'
                : 'Unknown';
            final contractor = person?.kontraktor ?? 'Unknown';
            final photoUrl = person?.picURL;

            return InkWell(
              onTap: () => _showLogoutDialog(context, ref, theme),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                          ? AssetImage(photoUrl)
                          : const AssetImage('images/driver_exca.png')
                                as ImageProvider,
                      backgroundColor: theme.surfaceColor,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: theme.appBarForeground,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          contractor,
                          style: TextStyle(
                            color: theme.appBarAccent,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(
    BuildContext context,
    WidgetRef ref,
    AppThemeData theme,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.dialogBackground,
        title: Row(
          children: [
            const Icon(Icons.logout, color: Colors.orange),
            const SizedBox(width: 8),
            Text('Sign Out', style: TextStyle(color: theme.textOnSurface)),
          ],
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: theme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('CANCEL', style: TextStyle(color: theme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(authProvider.notifier).logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryButtonBackground,
              foregroundColor: theme.primaryButtonText,
            ),
            child: const Text('SIGN OUT'),
          ),
        ],
      ),
    );
  }
}
