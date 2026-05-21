import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/models/gps_loc.dart';
import '../../../../core/models/rover_node_data.dart';
import '../../../../core/utils/app_theme.dart';

class RoverDebugTab extends ConsumerWidget {
  const RoverDebugTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final roverAsync = ref.watch(roverStreamProvider);
    final gpsAsync = ref.watch(gpsStreamProvider);
    final gpsData = gpsAsync.value;

    return roverAsync.when(
      data: (roverData) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row 1: Identity & Health
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildNodeInfoCard(roverData, theme),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: _buildHealthStatusCard(roverData, theme),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Row 2: Accelerometer Calibration (full width)
              _buildAccelerometerCalibrationCard(roverData, theme),
              const SizedBox(height: 24),

              // Row 3: Counters & Hardware Info
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildCountersCard(roverData, theme),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: _buildHardwareInfoCard(roverData, theme),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Row 4: GNSS 1 Info & GNSS 2 Info
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildGnssInfoCard('GNSS 1 Info', gpsData, isGnss1: true, theme: theme),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: _buildGnssInfoCard('GNSS 2 Info', gpsData, isGnss1: false, theme: theme),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: theme.appBarAccent),
            const SizedBox(height: 16),
            Text(
              'Waiting for Rover Node data stream (Opcode 0xD6)...',
              style: TextStyle(color: theme.textSecondary, fontSize: 16),
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

  Widget _buildNodeInfoCard(RoverNodeData data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Rover Node Identity',
      icon: Icons.info_outline,
      theme: theme,
      child: Column(
        children: [
          _buildInfoRow('Sensor Type', data.sensorTypeLabel, theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Sensor ID', '${data.sensorID}', theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Uptime', data.uptimeFormatted, theme: theme, valueColor: const Color(0xFF2ECC71)),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Reset Reason', data.resetReasonLabel, theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Restart Number', '${data.restartNumber} times', theme: theme),
        ],
      ),
    );
  }

  Widget _buildHealthStatusCard(RoverNodeData data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Rover Health & Diagnostics',
      icon: Icons.health_and_safety_outlined,
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'SYSTEM BITWISE ERRORS',
            style: TextStyle(
              color: theme.textSecondary.withOpacity(0.6),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildErrorChip('ESP32 System', data.hasESP32Error, theme),
              _buildErrorChip('IMU Sensor', data.hasSensorError, theme),
              _buildErrorChip('CAN Network', data.hasCANError, theme),
              _buildErrorChip('Voltage Input', data.hasInputVoltError, theme),
            ],
          ),
          const SizedBox(height: 24),
          Divider(color: theme.dividerColor),
          const SizedBox(height: 8),
          _buildInfoRow(
            'CAN RX Timeout Counter',
            '${data.canRxTimeout}',
            theme: theme,
            valueColor: data.canRxTimeout > 0 ? Colors.redAccent : theme.textOnSurface.withOpacity(0.85),
          ),
          Divider(color: theme.dividerColor),
          _buildInfoRow(
            'Integrity Check (CRC16)',
            '0x${data.crc16.toRadixString(16).toUpperCase().padLeft(4, '0')}',
            theme: theme,
            valueColor: const Color(0xFF2ECC71),
          ),
        ],
      ),
    );
  }

  // --- Accelerometer Calibration Card ---

  Widget _buildAccelerometerCalibrationCard(RoverNodeData data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Accelerometer Calibration',
      icon: Icons.tune,
      theme: theme,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Accelerometer raw values
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ACCELERATION (mg)',
                  style: TextStyle(
                    color: theme.textSecondary.withOpacity(0.6),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow('X-Axis', '${data.accelX} mg', theme: theme, isBold: true),
                Divider(color: theme.dividerColor),
                _buildInfoRow('Y-Axis', '${data.accelY} mg', theme: theme, isBold: true),
                Divider(color: theme.dividerColor),
                _buildInfoRow('Z-Axis', '${data.accelZ} mg', theme: theme, isBold: true),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Container(width: 1, color: theme.dividerColor),
          const SizedBox(width: 32),
          // Calibration Offsets
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OFFSETS',
                  style: TextStyle(
                    color: theme.textSecondary.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoRow('X', '${data.offsetX}', theme: theme),
                _buildInfoRow('Y', '${data.offsetY}', theme: theme),
                _buildInfoRow('Z', '${data.offsetZ}', theme: theme),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Container(width: 1, color: theme.dividerColor),
          const SizedBox(width: 32),
          // Calibration Scales & Rotation
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SCALES & ROTATION',
                  style: TextStyle(
                    color: theme.textSecondary.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoRow('Scale X', data.scaleX.toStringAsFixed(2), theme: theme),
                _buildInfoRow('Scale Y', data.scaleY.toStringAsFixed(2), theme: theme),
                _buildInfoRow('Scale Z', data.scaleZ.toStringAsFixed(2), theme: theme),
                Divider(color: theme.dividerColor),
                _buildInfoRow('Pitch', _formatAngle(data.pitch), theme: theme, valueColor: const Color(0xFF2ECC71)),
                _buildInfoRow('Roll', _formatAngle(data.roll), theme: theme, valueColor: const Color(0xFF2ECC71)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Counters & Hardware Info Card Builders ---

  Widget _buildCountersCard(RoverNodeData data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Pulse & Comm Counters',
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
                Text(
                  'PULSE COUNTERS',
                  style: TextStyle(
                    color: theme.textSecondary.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoRow('Main', '${data.mainCounter}', theme: theme),
                _buildInfoRow('Boom', '${data.boomCounter}', theme: theme),
                _buildInfoRow('Stick', '${data.stickCounter}', theme: theme),
                _buildInfoRow('Bucket', '${data.bucketCounter}', theme: theme),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Container(width: 1, color: theme.dividerColor),
          const SizedBox(width: 24),
          // Comm Counters
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COMM COUNTERS',
                  style: TextStyle(
                    color: theme.textSecondary.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoRow('GNSS 1', '${data.gnss1Counter}', theme: theme),
                _buildInfoRow('GNSS 2', '${data.gnss2Counter}', theme: theme),
                _buildInfoRow('Base Stn RX', '${data.bsStationRx}', theme: theme),
                _buildInfoRow('RS485 RX', '${data.rs485Rx}', theme: theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHardwareInfoCard(RoverNodeData data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Hardware Info',
      icon: Icons.developer_board,
      theme: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Voltages
          Text(
            'SYSTEM VOLTAGE RAILS',
            style: TextStyle(
              color: theme.textSecondary.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('VIN ADC Rail', '${data.vinAdc.toStringAsFixed(2)} V', theme: theme, valueColor: const Color(0xFF2ECC71), isBold: true),
          _buildInfoRow('5.0V ADC Rail', '${data.adc5V.toStringAsFixed(2)} V', theme: theme, valueColor: const Color(0xFF2ECC71), isBold: true),
          const SizedBox(height: 12),
          Divider(color: theme.dividerColor),
          
          // Cylinder Tilt
          Text(
            'BOOM, STICK & BUCKET TILT',
            style: TextStyle(
              color: theme.textSecondary.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('Boom Tilt', _formatAngle(data.boomAngle), theme: theme, valueColor: const Color(0xFF2ECC71)),
          _buildInfoRow('Stick Tilt', _formatAngle(data.stickAngle), theme: theme, valueColor: const Color(0xFF2ECC71)),
          _buildInfoRow('Bucket Tilt', _formatAngle(data.bucketAngle), theme: theme, valueColor: const Color(0xFF2ECC71)),
          const SizedBox(height: 12),
          Divider(color: theme.dividerColor),

          // Storage & Env
          Text(
            'STORAGE & ENV',
            style: TextStyle(
              color: theme.textSecondary.withOpacity(0.6),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('SD Capacity', '${data.sdCardCapacity} MB', theme: theme),
          _buildInfoRow('SD Speed', '${data.sdCardSpeed} kHz', theme: theme),
          _buildInfoRow('Temperature', '${data.temperature.toStringAsFixed(2)} °C', theme: theme, valueColor: Colors.orangeAccent),
        ],
      ),
    );
  }

  // --- GNSS Card Builder ---

  Widget _buildGnssInfoCard(
    String title,
    GPSLoc? gps, {
    required bool isGnss1,
    required AppThemeData theme,
  }) {
    if (gps == null) {
      return _buildCardTemplate(
        title: title,
        icon: Icons.satellite_alt,
        theme: theme,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: theme.appBarAccent,
                  strokeWidth: 2,
                ),
                const SizedBox(height: 12),
                Text(
                  'Waiting for GNSS data...',
                  style: TextStyle(color: theme.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final lat = gps.bucketLat;
    final lng = gps.bucketLong;
    final alt = gps.trackHeight;
    final sat = isGnss1 ? gps.satelit : gps.satelit2;
    final hAcc = isGnss1 ? gps.hAcc1 : gps.hAcc2;
    final vAcc = isGnss1 ? gps.vAcc1 : gps.vAcc2;
    final status = isGnss1 ? gps.status : gps.status2;

    // Color dynamic mapping for RTK Status
    Color statusColor = Colors.redAccent;
    if (status.toUpperCase() == 'RTK ON') {
      statusColor = const Color(0xFF2ECC71);
    } else if (status.toUpperCase() == 'FLOAT') {
      statusColor = Colors.orangeAccent;
    }

    return _buildCardTemplate(
      title: title,
      icon: Icons.satellite_alt,
      theme: theme,
      child: Column(
        children: [
          _buildInfoRow('Latitude', lat.toStringAsFixed(7), theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Longitude', lng.toStringAsFixed(7), theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Altitude', '$alt mm', theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Satellites', '$sat', theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Accuracy H', '$hAcc mm', theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Accuracy V', '$vAcc mm', theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Status RTK', status, theme: theme, valueColor: statusColor, isBold: true),
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
        color: theme.cardSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.cardBorderColor.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
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
                decoration: BoxDecoration(
                  color: theme.appBarAccent,
                  borderRadius: const BorderRadius.only(
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
                      Icon(icon, color: theme.textOnSurface, size: 24),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: TextStyle(
                          color: theme.textOnSurface,
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
    required AppThemeData theme,
    Color? valueColor,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: theme.textSecondary, fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? theme.textOnSurface.withOpacity(0.85),
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorChip(String label, bool hasError, AppThemeData theme) {
    final Color bgColor = hasError ? Colors.red.withOpacity(0.1) : theme.appBarAccent.withOpacity(0.1);
    final Color textColor = hasError ? Colors.redAccent : theme.appBarAccent;
    final Color borderColor = hasError ? Colors.redAccent.withOpacity(0.3) : theme.appBarAccent.withOpacity(0.3);
    final IconData chipIcon = hasError ? Icons.error_outline : Icons.check_circle_outline;

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
          Icon(chipIcon, color: textColor, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _formatAngle(double rawValue) {
    // VISUAL ANGLE/TILT CAPPING CONSTRAINT (Calibration Layout Rule #5)
    final double capped = rawValue > 360.0 ? 360.0 : rawValue;
    return '${capped.toStringAsFixed(2)}°';
  }
}
