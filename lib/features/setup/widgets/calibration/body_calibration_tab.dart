import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/services/notification_service.dart';
import '../../presenter/calibration_presenter.dart';

class BodyCalibrationTab extends ConsumerStatefulWidget {
  const BodyCalibrationTab({super.key});

  @override
  ConsumerState<BodyCalibrationTab> createState() => _BodyCalibrationTabState();
}

class _BodyCalibrationTabState extends ConsumerState<BodyCalibrationTab> {
  final CalibrationPresenter _presenter = CalibrationPresenter();

  // Dialog for setting parameters
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
          title: Text(
            'Set $title',
            style: TextStyle(color: theme.textOnSurface),
          ),
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
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: AppTheme.of(context).textSecondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
                        message: '$title updated to $newValue',
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

  // Dialog for calibration modes (Pitch/Roll)
  Future<void> _showCalibrateDialog(
    BuildContext context,
    String title,
    int mode,
    double currentValue,
  ) async {
    final TextEditingController controller = TextEditingController(
      text: currentValue.toStringAsFixed(2),
    );

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final theme = AppTheme.of(context);
        return AlertDialog(
          backgroundColor: theme.dialogBackground,
          title: Text(
            'Calibrate $title',
            style: TextStyle(color: theme.textOnSurface),
          ),
          content: TextField(
            controller: controller,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(color: theme.textOnSurface),
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.inputFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter reference value',
              hintStyle: TextStyle(color: theme.textSecondary),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: theme.textSecondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
              ),
              child: const Text(
                'Calibrate',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final port = ref.read(comServiceProvider).port;
                if (port != null && controller.text.isNotEmpty) {
                  final double? newValue = double.tryParse(controller.text);
                  if (newValue != null) {
                    final command = _presenter.calibrateCommand(
                      value1: newValue,
                      mode: mode,
                    );
                    await port.write(Uint8List.fromList(command));
                    if (context.mounted) {
                      NotificationService.showCommandNotification(
                        context,
                        title: 'CALIBRATE',
                        message: '$title calibrated',
                        modeStr: 'with $newValue',
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
                  Text(
                    abbreviation,
                    style: TextStyle(
                      color: theme.textOnSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: theme.textSecondary, fontSize: 12),
                  ),
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
                        'images/calibrate_1.png',
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
                        color: theme.cardSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.cardBorderColor),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Pitch Control
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'PITCH: ',
                                    style: TextStyle(
                                      color: theme.textSecondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${(data.pitch > 360 ? 360.0 : data.pitch).toStringAsFixed(2)}°',
                                    style: TextStyle(
                                      color: theme.textOnSurface,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _showCalibrateDialog(
                                      context,
                                      'Pitch',
                                      0, // Mode 0 according to user provided values
                                      data.pitch,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2ECC71),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Calibrate'),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: () async {
                                      final confirm = await DialogUtils.showConfirmationDialog(
                                        context: context,
                                        title: 'Confirm Reset',
                                        message: 'Are you sure you want to reset Pitch Calibration?',
                                      );
                                      if (!confirm) return;

                                      final port = ref.read(comServiceProvider).port;
                                      if (port != null) {
                                        final command = _presenter.calibrateCommand(value1: 0.0, mode: 64);
                                        await port.write(Uint8List.fromList(command));
                                        if (context.mounted) {
                                          NotificationService.showCommandNotification(
                                            context,
                                            title: 'RESET',
                                            message: 'Pitch Berhasil di reset',
                                            modeStr: 'Completed',
                                            icon: Icons.refresh,
                                            iconColor: theme.appBarAccent,
                                            headerColor: theme.cardSurface,
                                          );
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.refresh),
                                    color: theme.appBarAccent,
                                    tooltip: 'Reset Pitch',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Roll Control
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'ROLL: ',
                                    style: TextStyle(
                                      color: theme.textSecondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${(data.roll > 360 ? 360.0 : data.roll).toStringAsFixed(2)}°',
                                    style: TextStyle(
                                      color: theme.textOnSurface,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _showCalibrateDialog(
                                      context,
                                      'Roll',
                                      1, // Mode 1 according to user provided values
                                      data.roll,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2ECC71),
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Calibrate'),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: () async {
                                      final confirm = await DialogUtils.showConfirmationDialog(
                                        context: context,
                                        title: 'Confirm Reset',
                                        message: 'Are you sure you want to reset Roll Calibration?',
                                      );
                                      if (!confirm) return;

                                      final port = ref.read(comServiceProvider).port;
                                      if (port != null) {
                                        final command = _presenter.calibrateCommand(value1: 0.0, mode: 65);
                                        await port.write(Uint8List.fromList(command));
                                        if (context.mounted) {
                                          NotificationService.showCommandNotification(
                                            context,
                                            title: 'RESET',
                                            message: 'Roll Berhasil di reset',
                                            modeStr: 'Completed',
                                            icon: Icons.refresh,
                                            iconColor: theme.appBarAccent,
                                            headerColor: theme.cardSurface,
                                          );
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.refresh),
                                    color: theme.appBarAccent,
                                    tooltip: 'Reset Roll',
                                  ),
                                ],
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
                                'ACCELERO CALIBRATION',
                                style: TextStyle(
                                  color: theme.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      final port = ref
                                          .read(comServiceProvider)
                                          .port;
                                      if (port != null) {
                                        final command = _presenter
                                            .calibrateCommand(
                                              value1: 0.0,
                                              mode:
                                                  20, // Mode 20 for Start Body
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
                                    icon: const Icon(Icons.play_arrow),
                                    label: const Text('START'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2ECC71),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      final port = ref
                                          .read(comServiceProvider)
                                          .port;
                                      if (port != null) {
                                        final command = _presenter
                                            .calibrateCommand(
                                              value1: 0.0,
                                              mode: 40, // Mode 40 for Stop Body
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
                                    icon: const Icon(Icons.stop),
                                    label: const Text('STOP'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFEF4444),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    onPressed: () async {
                                      final confirm = await DialogUtils.showConfirmationDialog(
                                        context: context,
                                        title: 'Confirm Reset',
                                        message: 'Are you sure you want to reset Body Accelero?',
                                      );
                                      if (!confirm) return;

                                      final port = ref.read(comServiceProvider).port;
                                      if (port != null) {
                                        final command = _presenter.calibrateCommand(value1: 0.0, mode: 60);
                                        await port.write(Uint8List.fromList(command));
                                        if (context.mounted) {
                                          NotificationService.showCommandNotification(
                                            context,
                                            title: 'RESET',
                                            message: 'Body Accelero Berhasil di reset',
                                            modeStr: 'Completed',
                                            icon: Icons.refresh,
                                            iconColor: theme.appBarAccent,
                                            headerColor: theme.cardSurface,
                                          );
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.refresh),
                                    color: theme.appBarAccent,
                                    tooltip: 'Reset Body Accelero',
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
                          // Divider separating the two panels with theme color
                          Divider(
                            color: theme.dividerColor,
                          ),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildParamCard(
                            context,
                            'Antenna Height',
                            'Ant Height',
                            15, // Type 15
                            data.antHeight,
                          ),
                          _buildParamCard(
                            context,
                            'Boom Center X',
                            'BCX',
                            11, // Type 11
                            data.bcx,
                          ),
                          _buildParamCard(
                            context,
                            'Boom Center Y',
                            'BCY',
                            12, // Type 12
                            data.bcy,
                          ),
                          _buildParamCard(
                            context,
                            'Axis Center X',
                            'ACX',
                            13, // Type 13
                            data.acx,
                          ),
                          _buildParamCard(
                            context,
                            'Axis Center Y',
                            'ACY',
                            14, // Type 14
                            data.acy,
                          ),
                          _buildParamCard(
                            context,
                            'Antenna Pole',
                            'Ant Pole Height',
                            16, // Type 16
                            data.antPole,
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
