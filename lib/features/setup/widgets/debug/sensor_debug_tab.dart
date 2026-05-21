import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/models/sensor_node_data.dart';
import '../../../../core/utils/app_theme.dart';

class SensorDebugTab extends ConsumerWidget {
  const SensorDebugTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final sensorAsync = ref.watch(sensorStreamProvider);

    return sensorAsync.when(
      data: (sensorData) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row 1: Identity & Health
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildNodeInfoCard(sensorData, theme),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: _buildHealthStatusCard(sensorData, theme),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Row 2: Motion Data & Calibration
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: _buildMotionCard(sensorData, theme),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 3,
                    child: _buildCalibrationOffsetsCard(sensorData, theme),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Row 3: Counters & Power
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildCountersCard(sensorData, theme),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: _buildPowerAndAdcCard(sensorData, theme),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      loading: () => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF2ECC71)),
            SizedBox(height: 16),
            Text(
              'Waiting for Sensor Node data stream (Opcode 0xD7)...',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      ),
      error: (err, stack) => Center(
        child: Text(
          'Error loading stream: $err',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  // --- Identity & Health Card Builders ---

  Widget _buildNodeInfoCard(SensorNodeData data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Sensor Node Identity',
      icon: Icons.info_outline,
      theme: theme,
      child: Column(
        children: [
          _buildInfoRow('Source ID', data.sourceIDLabel, isBold: true),
          const Divider(color: Colors.white10),
          _buildInfoRow('Sensor Type', data.sensorTypeLabel),
          const Divider(color: Colors.white10),
          _buildInfoRow('Sensor ID', '${data.sensorID}'),
          const Divider(color: Colors.white10),
          _buildInfoRow('Uptime', data.uptimeFormatted, valueColor: const Color(0xFF2ECC71)),
          const Divider(color: Colors.white10),
          _buildInfoRow('Reset Reason', data.resetReasonLabel),
          const Divider(color: Colors.white10),
          _buildInfoRow('Restart Number', '${data.restartNumber} times'),
        ],
      ),
    );
  }

  Widget _buildHealthStatusCard(SensorNodeData data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Sensor Health & Diagnostics',
      icon: Icons.health_and_safety_outlined,
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'SYSTEM BITWISE ERRORS',
            style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildErrorChip('ESP32 System', data.hasESP32Error),
              _buildErrorChip('IMU Sensor', data.hasSensorError),
              _buildErrorChip('CAN Network', data.hasCANError),
              _buildErrorChip('Voltage Input', data.hasInputVoltError),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          const SizedBox(height: 8),
          _buildInfoRow('CAN RX Timeout Counter', '${data.canRxTimeout}', valueColor: data.canRxTimeout > 0 ? Colors.redAccent : Colors.white70),
          const Divider(color: Colors.white10),
          _buildInfoRow(
            'Integrity Check (CRC16)', 
            '0x${data.crc16.toRadixString(16).toUpperCase().padLeft(4, '0')}',
            valueColor: const Color(0xFF2ECC71),
          ),
        ],
      ),
    );
  }

  // --- Motion & Measurement Card Builders ---

  Widget _buildMotionCard(SensorNodeData data, AppThemeData theme) {
    // VISUAL ANGLE/TILT CAPPING CONSTRAINT (Calibration Layout Rule #5)
    final double rawTilt = data.tilt;
    final double cappedTilt = rawTilt > 360.0 ? 360.0 : rawTilt;
    final String formattedTilt = '${cappedTilt.toStringAsFixed(2)}°';

    return _buildCardTemplate(
      title: 'Motion & Inertial Data',
      icon: Icons.screen_rotation,
      theme: theme,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Accelerometer values
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ACCELERATION (mg)',
                  style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                ),
                const SizedBox(height: 12),
                _buildInfoRow('X-Axis', '${data.accelX} mg', isBold: true),
                const Divider(color: Colors.white10),
                _buildInfoRow('Y-Axis', '${data.accelY} mg', isBold: true),
                const Divider(color: Colors.white10),
                _buildInfoRow('Z-Axis', '${data.accelZ} mg', isBold: true),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Container(width: 1, height: 110, color: Colors.white10),
          const SizedBox(width: 32),
          // Physics/Degrees
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ORIENTATION & TEMP',
                  style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                ),
                const SizedBox(height: 12),
                // Tilt uses formattedTilt with Degree symbol and visual capping constraint
                _buildInfoRow('Capped Tilt', formattedTilt, valueColor: const Color(0xFF2ECC71), isBold: true),
                const Divider(color: Colors.white10),
                _buildInfoRow('Temperature', '${data.temperature.toStringAsFixed(2)} °C', valueColor: Colors.orangeAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalibrationOffsetsCard(SensorNodeData data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Calibration Offsets & Scales',
      icon: Icons.tune,
      theme: theme,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('OFFSETS', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildInfoRow('X', '${data.offsetX}'),
                    _buildInfoRow('Y', '${data.offsetY}'),
                    _buildInfoRow('Z', '${data.offsetZ}'),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Container(width: 1, height: 80, color: Colors.white10),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('SCALES (1E-02)', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildInfoRow('X', data.scaleX.toStringAsFixed(2)),
                    _buildInfoRow('Y', data.scaleY.toStringAsFixed(2)),
                    _buildInfoRow('Z', data.scaleZ.toStringAsFixed(2)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Counters & Power Card Builders ---

  Widget _buildCountersCard(SensorNodeData data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Pulse Counters & Sensor Errs',
      icon: Icons.pin_end,
      theme: theme,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Activity Counters
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('PULSE COUNTERS', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                const SizedBox(height: 8),
                _buildInfoRow('Main', '${data.mainCounter}'),
                _buildInfoRow('Boom', '${data.boomCounter}'),
                _buildInfoRow('Stick', '${data.stickCounter}'),
                _buildInfoRow('Bucket', '${data.bucketCounter}'),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Container(width: 1, height: 110, color: Colors.white10),
          const SizedBox(width: 24),
          // Sensor Error Counters
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('HARDWARE ERRS', style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                const SizedBox(height: 8),
                _buildInfoRow('Sensor Read', '${data.errSensorRead}', valueColor: data.errSensorRead > 0 ? Colors.redAccent : Colors.white70),
                _buildInfoRow('Uncalibrated', '${data.errSensorUncalib}', valueColor: data.errSensorUncalib > 0 ? Colors.redAccent : Colors.white70),
                _buildInfoRow('CAN Send Fail', '${data.errCANSendFail}', valueColor: data.errCANSendFail > 0 ? Colors.redAccent : Colors.white70),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPowerAndAdcCard(SensorNodeData data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Hardware ADC Voltages',
      icon: Icons.battery_charging_full_outlined,
      theme: theme,
      child: Column(
        children: [
          _buildInfoRow('3.3V ADC Rail', '${data.adc3V3.toStringAsFixed(2)} V', valueColor: const Color(0xFF2ECC71), isBold: true),
          const Divider(color: Colors.white10),
          _buildInfoRow('5.0V ADC Rail', '${data.adc5V.toStringAsFixed(2)} V', valueColor: const Color(0xFF2ECC71), isBold: true),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.02),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.flash_on, color: Colors.orangeAccent, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Voltage rail tolerances: ±5% ideal operating bounds.',
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Card Template ---

  Widget _buildCardTemplate({
    required String title,
    required IconData icon,
    required AppThemeData theme,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF2ECC71).withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 24,
              bottom: 24,
              width: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2ECC71),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: Colors.white, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: child,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label, 
    String value, {
    Color valueColor = Colors.white70,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorChip(String label, bool hasError) {
    final Color bgColor = hasError ? Colors.red.withOpacity(0.1) : const Color(0xFF2ECC71).withOpacity(0.1);
    final Color textColor = hasError ? Colors.redAccent : const Color(0xFF2ECC71);
    final Color borderColor = hasError ? Colors.redAccent.withOpacity(0.3) : const Color(0xFF2ECC71).withOpacity(0.3);
    final IconData icon = hasError ? Icons.error_outline : Icons.check_circle_outline;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
