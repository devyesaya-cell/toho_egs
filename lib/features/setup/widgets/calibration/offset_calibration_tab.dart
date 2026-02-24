import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/utils/notification_service.dart';
import '../../presenter/calibration_presenter.dart';

class OffsetCalibrationTab extends ConsumerStatefulWidget {
  const OffsetCalibrationTab({super.key});

  @override
  ConsumerState<OffsetCalibrationTab> createState() =>
      _OffsetCalibrationTabState();
}

class _OffsetCalibrationTabState extends ConsumerState<OffsetCalibrationTab> {
  @override
  Widget build(BuildContext context) {
    final calibAsync = ref.watch(calibStreamProvider);
    final calibData = calibAsync.asData?.value;

    // Get heading and convert to radians for rotation
    // Assuming heading is in degrees
    final double heading = calibData?.heading ?? 0.0;
    final double rotationRadians = heading * (pi / 180.0);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Image and Buttons
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Rotating Image
                Expanded(
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Keep image size small enough that when it rotates its
                        // corners don't clip outside the container.
                        final minAxis = min(
                          constraints.maxWidth,
                          constraints.maxHeight,
                        );
                        final imageSize = minAxis * 0.70;

                        return SizedBox(
                          width: imageSize,
                          height: imageSize,
                          child: Transform.rotate(
                            angle: rotationRadians,
                            child: Image.asset(
                              'images/exca2_top.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final port = ref.read(comServiceProvider).port;
                        if (port != null) {
                          final presenter = CalibrationPresenter();
                          final command = presenter.calibrateCommand(
                            value1: 0.0,
                            mode: 7,
                          );
                          await port.write(Uint8List.fromList(command));
                          if (context.mounted) {
                            NotificationService.showCommandNotification(
                              context,
                              title: 'OFFSET',
                              message: 'Offset Calibration Started',
                              modeStr: 'START',
                              icon: Icons.check_circle,
                              iconColor: const Color(0xFF2ECC71),
                              headerColor: const Color(0xFF1E3A2A),
                            );
                          }
                        } else {
                          NotificationService.showCommandNotification(
                            context,
                            title: 'OFFSET',
                            message: 'Port not connected',
                            modeStr: 'ERROR',
                            icon: Icons.error,
                            iconColor: const Color(0xFFEF4444),
                            headerColor: const Color(0xFF3F1D1D),
                          );
                        }
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('START'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2ECC71),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final port = ref.read(comServiceProvider).port;
                        if (port != null) {
                          final presenter = CalibrationPresenter();
                          final command = presenter.calibrateCommand(
                            value1: 0.0,
                            mode: 8,
                          );
                          await port.write(Uint8List.fromList(command));
                          if (context.mounted) {
                            NotificationService.showCommandNotification(
                              context,
                              title: 'OFFSET',
                              message: 'Offset Calibration Stopped',
                              modeStr: 'STOP',
                              icon: Icons.stop_circle,
                              iconColor: const Color(0xFFEF4444),
                              headerColor: const Color(0xFF3F1D1D),
                            );
                          }
                        } else {
                          NotificationService.showCommandNotification(
                            context,
                            title: 'OFFSET',
                            message: 'Port not connected',
                            modeStr: 'ERROR',
                            icon: Icons.error,
                            iconColor: const Color(0xFFEF4444),
                            headerColor: const Color(0xFF3F1D1D),
                          );
                        }
                      },
                      icon: const Icon(Icons.stop),
                      label: const Text('STOP'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          const SizedBox(width: 32),

          // Right Side: Heading Value & Notes
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Heading Display
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B), // Dark surface
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF1E3A2A)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'HEADING',
                        style: TextStyle(
                          color: Color(0xFFB0BEC5),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            heading.toStringAsFixed(1).padLeft(5, '0'),
                            style: const TextStyle(
                              color: Color(0xFF2ECC71),
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              '°',
                              style: TextStyle(
                                color: Color(0xFF2ECC71),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Notes Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF3F1D1D,
                    ).withOpacity(0.3), // Highlight tint
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF2ECC71).withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.info_outline, color: Color(0xFF2ECC71)),
                          SizedBox(width: 8),
                          Text(
                            'NOTES',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Color(0xFF1E3A2A), height: 32),
                      _buildNoteStep('1', 'Arahkan Arm searah dengan track'),
                      _buildNoteStep('2', 'Tekan tombol start'),
                      _buildNoteStep(
                        '3',
                        'Putar arm excavator searah jarum jam 180 derajat',
                      ),
                      _buildNoteStep(
                        '4',
                        'Tekan stop dan tunggu sampai notifikasi muncul',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteStep(String stepNumber, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Text(
              stepNumber,
              style: const TextStyle(
                color: Color(0xFF2ECC71),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFFB0BEC5),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
