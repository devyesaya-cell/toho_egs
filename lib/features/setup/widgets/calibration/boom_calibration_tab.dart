import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/utils/notification_service.dart';
import '../../presenter/calibration_presenter.dart';

class BoomCalibrationTab extends ConsumerStatefulWidget {
  const BoomCalibrationTab({super.key});

  @override
  ConsumerState<BoomCalibrationTab> createState() => _BoomCalibrationTabState();
}

class _BoomCalibrationTabState extends ConsumerState<BoomCalibrationTab> {
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
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: Text(
            'Set $title',
            style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF0F1410),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter new value',
              hintStyle: const TextStyle(color: Colors.white54),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
              ),
              child: const Text('Set', style: TextStyle(color: Colors.white)),
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
                        modeStr: 'TYPE $type',
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
    return Card(
      color: const Color(0xFF1E293B),
      margin: const EdgeInsets.symmetric(vertical: 6.0),
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
                    style: const TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  color: Color(0xFF2ECC71),
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
    final data = calibAsync.asData?.value;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
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
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF1E3A2A)),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: data == null
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF2ECC71),
                            ),
                          )
                        : Image.asset(
                            'images/calibrate_2.png',
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
                        // Boom Tilt Control
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'BOOM TILT: ',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data?.boomTilt.toStringAsFixed(2) ?? '0.00',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () async {
                                final port = ref.read(comServiceProvider).port;
                                if (port != null) {
                                  // Calibrate boom tilt mode 2 with value 0.0
                                  final command = _presenter.calibrateCommand(
                                    value1: 0.0,
                                    mode: 2,
                                  );
                                  await port.write(Uint8List.fromList(command));
                                  if (context.mounted) {
                                    NotificationService.showCommandNotification(
                                      context,
                                      title: 'CALIBRATE',
                                      message: 'Boom Tilt calibrated',
                                      modeStr: 'MODE 2',
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
                                backgroundColor: const Color(0xFF2ECC71),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Calibrate'),
                            ),
                          ],
                        ),
                        // Vertical Divider
                        Container(
                          width: 1,
                          height: double.infinity,
                          color: Colors.white24,
                        ),
                        // Accelero Controls
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'ACCELERO CALIBRATION',
                              style: TextStyle(
                                color: Colors.white54,
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
                                      final command = _presenter.calibrateCommand(
                                        value1: 0.0,
                                        mode:
                                            21, // Mode 21 for Start Boom Accelero
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
                                          headerColor: const Color(0xFF1E3A2A),
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
                                      final command = _presenter.calibrateCommand(
                                        value1: 0.0,
                                        mode:
                                            41, // Mode 41 for Stop Boom Accelero
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
                                          headerColor: const Color(0xFF3F1D1D),
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
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF1E3A2A)),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'PARAMETERS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(color: Color(0xFF1E3A2A)),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildParamCard(
                          context,
                          'Boom Length',
                          'BL',
                          2, // Type 2
                          data?.boomLenght ?? 0,
                        ),
                        _buildParamCard(
                          context,
                          'Boom Base Height',
                          'BBH',
                          10, // Type 10
                          data?.boomBaseHeight ?? 0,
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
    );
  }
}
