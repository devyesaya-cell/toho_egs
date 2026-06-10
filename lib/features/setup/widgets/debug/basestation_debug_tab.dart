import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/models/base_status.dart';
import '../../../../core/utils/app_theme.dart';

class BasestationDebugTab extends ConsumerWidget {
  const BasestationDebugTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final bsData = ref.watch(bsProvider);

    if (bsData == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: theme.appBarAccent),
            const SizedBox(height: 16),
            Text(
              'Waiting for Basestatus data stream...',
              style: TextStyle(color: theme.textSecondary, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row 1: Basestation Identity & GNSS Status and Position & Attitude
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildIdentityAndGnssCard(bsData, theme),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: _buildPositionAndAttitudeCard(bsData, theme),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Row 2: Power & Battery Diagnostics (full width)
            _buildPowerDiagnosticsCard(bsData, theme),
          ],
        ),
      ),
    );
  }

  // --- Identity & GNSS Card Builder ---
  Widget _buildIdentityAndGnssCard(Basestatus data, AppThemeData theme) {
    // Dynamic mapping for RTK/GNSS status colors
    Color statusColor = Colors.redAccent;
    final statusUpper = data.status.toUpperCase();
    if (statusUpper.contains('FIX') || statusUpper == 'RTK ON') {
      statusColor = const Color(0xFF2ECC71); // Green for healthy fixes
    } else if (statusUpper.contains('RECKONING') || statusUpper == 'FLOAT') {
      statusColor = Colors.orangeAccent;
    }

    return _buildCardTemplate(
      title: 'Basestation GNSS Status',
      icon: Icons.satellite_alt,
      theme: theme,
      child: Column(
        children: [
          _buildInfoRow('Fix Status', data.status, theme: theme, valueColor: statusColor, isBold: true),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Satellites', '${data.satelit}', theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Accuracy', data.accuracyFormatted, theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Distance to Rover', data.distanceFormatted, theme: theme, valueColor: const Color(0xFF2ECC71)),
        ],
      ),
    );
  }

  // --- Position & Attitude Card Builder ---
  Widget _buildPositionAndAttitudeCard(Basestatus data, AppThemeData theme) {
    return _buildCardTemplate(
      title: 'Position & Attitude',
      icon: Icons.location_on,
      theme: theme,
      child: Column(
        children: [
          _buildInfoRow('Latitude', data.latFormatted, theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Longitude', data.longFormatted, theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Altitude', data.altitudeFormatted, theme: theme),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Pitch', data.pitchFormatted, theme: theme, valueColor: const Color(0xFF2ECC71)),
          Divider(color: theme.dividerColor),
          _buildInfoRow('Roll', data.rollFormatted, theme: theme, valueColor: const Color(0xFF2ECC71)),
        ],
      ),
    );
  }

  // --- Power & Battery Diagnostics Card Builder (Full Width) ---
  Widget _buildPowerDiagnosticsCard(Basestatus data, AppThemeData theme) {
    // Dynamic charge type color
    final Color chargeColor = data.isCharging ? const Color(0xFF2ECC71) : Colors.orangeAccent;

    return _buildCardTemplate(
      title: 'Power & Battery Diagnostics',
      icon: Icons.battery_charging_full,
      theme: theme,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column 1: Battery Levels
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BATTERY LEVELS',
                  style: TextStyle(
                    color: theme.textSecondary.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow('Current Capacity (BCC)', data.bccFormatted, theme: theme, isBold: true),
                Divider(color: theme.dividerColor),
                _buildInfoRow('Max Capacity (BMC)', data.bmcFormatted, theme: theme),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Container(width: 1, height: 100, color: theme.dividerColor),
          const SizedBox(width: 32),
          // Column 2: Electrical measurements
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ELECTRICAL STATS',
                  style: TextStyle(
                    color: theme.textSecondary.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow('Battery Voltage', data.batteryVoltageFormatted, theme: theme, valueColor: const Color(0xFF2ECC71)),
                Divider(color: theme.dividerColor),
                _buildInfoRow('Battery Current', data.batteryCurrentFormatted, theme: theme, valueColor: const Color(0xFF2ECC71)),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Container(width: 1, height: 100, color: theme.dividerColor),
          const SizedBox(width: 32),
          // Column 3: Charger Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CHARGER STATUS',
                  style: TextStyle(
                    color: theme.textSecondary.withOpacity(0.6),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow('Charging Mode', data.chargetype, theme: theme, valueColor: chargeColor, isBold: true),
                Divider(color: theme.dividerColor),
                _buildInfoRow('Status Label', data.isCharging ? 'Charging' : 'Discharging', theme: theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Card Template (Uniform with RoverDebugTab) ---
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
}
