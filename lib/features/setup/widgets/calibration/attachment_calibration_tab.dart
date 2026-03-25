import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/services/notification_service.dart';
import '../../presenter/calibration_presenter.dart';

class AttachmentCalibrationTab extends ConsumerStatefulWidget {
  const AttachmentCalibrationTab({super.key});

  @override
  ConsumerState<AttachmentCalibrationTab> createState() =>
      _AttachmentCalibrationTabState();
}

class _AttachmentCalibrationTabState
    extends ConsumerState<AttachmentCalibrationTab> {
  final CalibrationPresenter _presenter = CalibrationPresenter();

  Future<void> _showSetParamDialog(
    BuildContext context,
    String title,
    int type,
    int currentValue,
  ) async {
    final TextEditingController controller = TextEditingController(
      text: currentValue.toString(),
    );

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final theme = AppTheme.of(context);
        return AlertDialog(
          backgroundColor: theme.dialogBackground,
          title: Text('Set $title',
              style: TextStyle(color: theme.textOnSurface)),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: TextStyle(color: theme.textOnSurface),
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.inputFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter new value',
              hintStyle: TextStyle(color: theme.textSecondary),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
                  style: TextStyle(color: theme.textSecondary)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryButtonBackground,
                foregroundColor: theme.primaryButtonText,
              ),
              child: const Text('Set'),
              onPressed: () async {
                final port = ref.read(comServiceProvider).port;
                if (port != null && controller.text.isNotEmpty) {
                  final int? newValue = int.tryParse(controller.text);
                  if (newValue != null) {
                    final command = _presenter.setParam(newValue, type);
                    await port.write(Uint8List.fromList(command));
                    if (context.mounted) {
                      NotificationService.showCommandNotification(
                        context,
                        title: 'SET PARAM',
                        message: '$title updated!',
                        modeStr: '$newValue',
                        icon: Icons.check_circle,
                        iconColor: const Color(0xFF2ECC71),
                        headerColor: const Color(0xFF1E3A2A),
                      );
                      Navigator.of(context).pop();
                    }
                  }
                } else if (port == null && context.mounted) {
                  NotificationService.showCommandNotification(
                    context,
                    title: 'ERROR',
                    message: 'Port not connected',
                    modeStr: 'ERROR',
                    icon: Icons.error,
                    iconColor: const Color(0xFFEF4444),
                    headerColor: const Color(0xFF3F1D1D),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildParamCard(
    BuildContext context,
    String title,
    String abbreviation,
    int type,
    int value,
  ) {
    final theme = AppTheme.of(context);
    return Card(
      color: theme.cardSurface,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.cardBorderColor),
      ),
      child: InkWell(
        onTap: () => _showSetParamDialog(context, title, type, value),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(abbreviation,
                      style: TextStyle(
                        color: theme.textOnSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  Text(title,
                      style: TextStyle(
                          color: theme.textSecondary, fontSize: 12)),
                ],
              ),
              Text(
                value.toString(),
                style: TextStyle(
                  color: theme.appBarAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final calibAsync = ref.watch(calibStreamProvider);

    final theme = AppTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: calibAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: theme.appBarAccent),
        ),
        error: (err, stack) => Center(
          child: Text('Error: $err',
              style: const TextStyle(color: Color(0xFFEF4444))),
        ),
        data: (data) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT COLUMN (3/4 of width)
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // TOP LEFT (3/4 of height of left column) - IMAGE
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.cardSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.cardBorderColor),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'images/calibrate_3.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // BOTTOM LEFT (1/4 of height of left column) - CONTROLS
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF1E3A2A)),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Bucket Tilt Control
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'BUCKET TILT: ',
                                    style: TextStyle(
                                      color: theme.textSecondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${(data.bucketTilt > 360 ? 360.0 : data.bucketTilt).toStringAsFixed(2)}°',
                                    style: TextStyle(
                                      color: theme.textOnSurface,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ElevatedButton(
                                onPressed: () async {
                                  final port = ref
                                      .read(comServiceProvider)
                                      .port;
                                  if (port != null) {
                                    // Calibrate Bucket tilt mode 4
                                    final command = _presenter.calibrateCommand(
                                      value1: 0.0,
                                      mode: 4,
                                    );
                                    await port.write(
                                      Uint8List.fromList(command),
                                    );
                                    if (context.mounted) {
                                      NotificationService.showCommandNotification(
                                        context,
                                        title: 'CALIBRATE',
                                        message: 'Bucket Tilt calibrated',
                                        modeStr: 'Completed',
                                        icon: Icons.check_circle,
                                        iconColor: const Color(0xFF2ECC71),
                                        headerColor: const Color(0xFF1E3A2A),
                                      );
                                    }
                                  } else if (context.mounted) {
                                    NotificationService.showCommandNotification(
                                      context,
                                      title: 'ERROR',
                                      message: 'Port not connected',
                                      modeStr: 'ERROR',
                                      icon: Icons.error,
                                      iconColor: const Color(0xFFEF4444),
                                      headerColor: const Color(0xFF3F1D1D),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryButtonBackground,
                                  foregroundColor: theme.primaryButtonText,
                                  minimumSize: const Size(100, 36),
                                ),
                                child: const Text('Calibrate'),
                              ),
                            ],
                          ),
                          // Vertical Divider
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: theme.dividerColor,
                          ),
                          // I-Link Tilt Control
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'I-LINK TILT: ',
                                    style: TextStyle(
                                      color: theme.textSecondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${(data.iLinkTilt > 360 ? 360.0 : data.iLinkTilt).toStringAsFixed(2)}°',
                                    style: TextStyle(
                                      color: theme.textOnSurface,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ElevatedButton(
                                onPressed: () async {
                                  final port = ref
                                      .read(comServiceProvider)
                                      .port;
                                  if (port != null) {
                                    // Calibrate I-Link tilt mode 5
                                    final command = _presenter.calibrateCommand(
                                      value1: 0.0,
                                      mode: 5,
                                    );
                                    await port.write(
                                      Uint8List.fromList(command),
                                    );
                                    if (context.mounted) {
                                      NotificationService.showCommandNotification(
                                        context,
                                        title: 'CALIBRATE',
                                        message: 'I-Link Tilt calibrated',
                                        modeStr: 'Completed',
                                        icon: Icons.check_circle,
                                        iconColor: const Color(0xFF2ECC71),
                                        headerColor: const Color(0xFF1E3A2A),
                                      );
                                    }
                                  } else if (context.mounted) {
                                    NotificationService.showCommandNotification(
                                      context,
                                      title: 'ERROR',
                                      message: 'Port not connected',
                                      modeStr: 'ERROR',
                                      icon: Icons.error,
                                      iconColor: const Color(0xFFEF4444),
                                      headerColor: const Color(0xFF3F1D1D),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primaryButtonBackground,
                                  foregroundColor: theme.primaryButtonText,
                                  minimumSize: const Size(100, 36),
                                ),
                                child: const Text('Calibrate'),
                              ),
                            ],
                          ),
                          // Vertical Divider
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: theme.dividerColor,
                          ),
                          // Accelero Controls
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ACCELERO',
                                style: TextStyle(
                                  color: theme.textSecondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      final port = ref
                                          .read(comServiceProvider)
                                          .port;
                                      if (port != null) {
                                        final command = _presenter.calibrateCommand(
                                          value1: 0.0,
                                          mode:
                                              23, // Mode 23 for Start Bucket Accelero
                                        );
                                        await port.write(
                                          Uint8List.fromList(command),
                                        );
                                        if (context.mounted) {
                                          NotificationService.showCommandNotification(
                                            context,
                                            title: 'ACCELERO',
                                            message: 'Calibration Started',
                                            modeStr: 'START',
                                            icon: Icons.play_arrow,
                                            iconColor: const Color(0xFF2ECC71),
                                            headerColor: const Color(
                                              0xFF1E3A2A,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      size: 16,
                                    ),
                                    label: const Text(
                                      'START',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.primaryButtonBackground,
                                      foregroundColor: theme.primaryButtonText,
                                      minimumSize: const Size(80, 36),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      final port = ref
                                          .read(comServiceProvider)
                                          .port;
                                      if (port != null) {
                                        final command = _presenter.calibrateCommand(
                                          value1: 0.0,
                                          mode:
                                              43, // Mode 43 for Stop Bucket Accelero
                                        );
                                        await port.write(
                                          Uint8List.fromList(command),
                                        );
                                        if (context.mounted) {
                                          NotificationService.showCommandNotification(
                                            context,
                                            title: 'ACCELERO',
                                            message: 'Calibration Stopped',
                                            modeStr: 'STOP',
                                            icon: Icons.stop,
                                            iconColor: const Color(0xFFEF4444),
                                            headerColor: const Color(
                                              0xFF3F1D1D,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.stop, size: 16),
                                    label: const Text(
                                      'STOP',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFEF4444),
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(80, 36),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // RIGHT COLUMN (1/4 of width)
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.cardSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.cardBorderColor),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'PARAMETERS',
                        style: TextStyle(
                          color: theme.textOnSurface,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(color: theme.dividerColor),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildParamCard(
                            context,
                            'Bucket Length',
                            'BCL',
                            2,
                            data.bucketLenght,
                          ),
                          _buildParamCard(
                            context,
                            'Bucket Width',
                            'BCW',
                            4,
                            data.bucketWidth,
                          ),
                          _buildParamCard(
                            context,
                            'I-Link Length',
                            'ILK',
                            6,
                            data.iLink,
                          ),
                          _buildParamCard(
                            context,
                            'H-Link Length',
                            'HLK',
                            7,
                            data.hLink,
                          ),
                          _buildParamCard(
                            context,
                            'Bucket Pivot Disc',
                            'BPD',
                            8,
                            data.bpd,
                          ),
                          _buildParamCard(
                            context,
                            'Stick Pivot Disc',
                            'SPD',
                            9,
                            data.spd,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
