import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../../../core/utils/dialog_utils.dart';
import '../map_presenter.dart';

class MapInfoPanel extends ConsumerWidget {
  const MapInfoPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mapPresenterProvider);

    // Color Logic for RTK
    Color rtkColor = Colors.red;
    if (mapState.rtkStatus == 'RTK') {
      rtkColor = Colors.green;
    } else if (mapState.rtkStatus == 'FLOAT') {
      rtkColor = Colors.orange; // Yellow/Orange for Float
    }
    // NO RTK is Red

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 1. Alert Widget
          _buildPanelItem(
            context: context,
            icon: Icons.warning_amber_rounded,
            label: mapState.lastError?.alertType ?? '-',
            color: mapState.lastError != null ? Colors.red : Colors.grey,
            onTap: () => _showAlertDetail(context, mapState),
          ),
          _buildDivider(),

          // 2. Progress Widget
          // Tree Icon (Progress) | 0/0 / 0%
          // Also Add Lat/Lng? User said "tambahkan lat/lng ambil dari nilai bucketLat and BucketLong"
          // Maybe separate lines or compact? "0/0 | 0% \n Lat: ... Lng: ..."
          _buildPanelItem(
            context: context,
            icon: Icons.forest_rounded,
            label: '0/0 | 0%',
            color: Colors.green,
            width: 160,
            onTap: () => _showProgressDetail(context),
          ),
          _buildDivider(),

          // 3. RTK Status (Instead of just Satellites)
          // User: "Widget GPS status... Logic RTK... Warna Hijau..."
          // This seems to refer to the widget that SHOWS status.
          // Let's show "RTK" or "NO RTK" text clearly.
          _buildPanelItem(
            context: context,
            label: mapState.rtkStatus,
            color: rtkColor,
            isTextOnly: true,
            onTap: () => _showGpsDetail(context, mapState),
          ),
          _buildDivider(),

          // 4. Heading
          _buildPanelItem(
            context: context,
            icon: Icons.explore,
            label: '${mapState.heading?.toStringAsFixed(0) ?? '--'}°',
            color: Colors.orange,
          ),
          _buildDivider(),

          // 5. Arm Length (Bucket/Arm Icon?)
          _buildPanelItem(
            context: context,
            icon: Icons.construction, // Placeholder icon for Arm
            label: '${mapState.armLength.toStringAsFixed(1)} m',
            color: Colors.orange,
          ),
          _buildDivider(),

          // 6. Pitch / Roll with IMAGES
          InkWell(
            onTap: () => _showPitchRollDetail(context, mapState),
            child: Row(
              children: [
                // Pitch (Side View) -> Left Color
                _buildRotatedImage(
                  'images/exca_left_color.png',
                  mapState.fullGps?.pitch ?? 0,
                ),
                const SizedBox(width: 4),
                Text((mapState.fullGps?.pitch ?? 0).toStringAsFixed(1)),
                const SizedBox(width: 12),
                // Roll (Back View) -> Back Color
                _buildRotatedImage(
                  'images/exca_back_color.png',
                  mapState.fullGps?.roll ?? 0,
                ),
                const SizedBox(width: 4),
                Text((mapState.fullGps?.roll ?? 0).toStringAsFixed(1)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRotatedImage(String assetPath, double degrees) {
    return Transform.rotate(
      angle: degrees * (math.pi / 180),
      child: Image.asset(assetPath, height: 30, width: 30),
    );
  }

  Widget _buildPanelItem({
    required BuildContext context,
    IconData? icon,
    String? label,
    Widget? labelWidget,
    Color color = Colors.black,
    double? width,
    bool isTextOnly = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isTextOnly && icon != null) ...[
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
            ],
            labelWidget ??
                Text(
                  label ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isTextOnly ? color : Colors.black87,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  // --- Dialogs ---

  void _showAlertDetail(BuildContext context, MapState state) {
    if (state.lastError == null) return;
    DialogUtils.showDetailDialog(
      context: context,
      title: 'Current Alert',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DialogUtils.buildKeyValue("Source ID", state.lastError!.sourceID),
          DialogUtils.buildKeyValue("Type", state.lastError!.alertType),
          DialogUtils.buildKeyValue("Message", state.lastError!.message),
          DialogUtils.buildKeyValue(
            "Time",
            state.lastError!.timestamp.toString(),
          ),
        ],
      ),
    );
  }

  void _showProgressDetail(BuildContext context) {
    DialogUtils.showDetailDialog(
      context: context,
      title: 'Work Progress',
      content: const Text('Not Implemented Yet'),
    );
  }

  void _showGpsDetail(BuildContext context, MapState state) {
    if (state.fullGps == null && state.fullBase == null) return;

    // Determine Status Color for Dialog
    Color statusColor = Colors.red;
    if (state.rtkStatus == 'RTK')
      statusColor = Colors.green;
    else if (state.rtkStatus == 'FLOAT')
      statusColor = Colors.orange;

    DialogUtils.showDetailDialog(
      context: context,
      title: 'GPS & Base Status',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: statusColor.withOpacity(0.1),
            child: DialogUtils.buildKeyValue(
              "Overall Status",
              state.rtkStatus,
              valueColor: statusColor,
            ),
          ),
          const SizedBox(height: 8),
          // Bucket Position
          DialogUtils.buildKeyValue(
            "Bucket Position",
            "${state.fullGps?.bucketLat.toStringAsFixed(5) ?? 0}, ${state.fullGps?.bucketLong.toStringAsFixed(5) ?? 0}",
          ),

          // GPS 1
          DialogUtils.buildSection("GPS 1"),
          DialogUtils.buildKeyValue("Status", state.fullGps?.status ?? '-'),
          DialogUtils.buildKeyValue(
            "Accuracy (H/V)",
            '${state.fullGps?.hAcc1 ?? '-'} / ${state.fullGps?.vAcc1 ?? '-'} mm',
          ),
          DialogUtils.buildKeyValue(
            "Satellites",
            '${state.fullGps?.satelit ?? 0}',
          ),

          // GPS 2
          DialogUtils.buildSection("GPS 2"),
          DialogUtils.buildKeyValue("Status", state.fullGps?.status2 ?? '-'),
          DialogUtils.buildKeyValue(
            "Accuracy (H/V)",
            '${state.fullGps?.hAcc2 ?? '-'} / ${state.fullGps?.vAcc2 ?? '-'} mm',
          ),
          DialogUtils.buildKeyValue(
            "Satellites",
            '${state.fullGps?.satelit2 ?? 0}',
          ),

          // Base Station
          DialogUtils.buildSection("Base Station"),
          DialogUtils.buildKeyValue("Status", state.fullBase?.status ?? '-'),
          DialogUtils.buildKeyValue(
            "Accuracy",
            '${state.fullBase?.akurasi ?? '-'} mm',
          ),
          DialogUtils.buildKeyValue(
            "Distance",
            '${state.fullGps?.bsDistance ?? '-'} m',
          ),
          DialogUtils.buildKeyValue(
            "Satellites",
            '${state.fullBase?.satelit ?? '-'}',
          ),
          DialogUtils.buildKeyValue("RSSI", '${state.fullGps?.rssi ?? '-'}'),
          DialogUtils.buildKeyValue(
            "Voltage",
            '${state.fullBase?.batteryVoltage.toStringAsFixed(2) ?? '-'} V',
          ),
          DialogUtils.buildKeyValue(
            "Current",
            '${state.fullBase?.batteryCurrent.toStringAsFixed(2) ?? '-'} A',
          ),
        ],
      ),
    );
  }

  void _showPitchRollDetail(BuildContext context, MapState state) {
    DialogUtils.showDetailDialog(
      context: context,
      title: 'Inclination',
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("Pitch"),
                  const SizedBox(height: 8),
                  _buildRotatedImage(
                    'images/exca_left_color.png',
                    state.fullGps?.pitch ?? 0,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${state.fullGps?.pitch.toStringAsFixed(2)}°',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Roll"),
                  const SizedBox(height: 8),
                  _buildRotatedImage(
                    'images/exca_back_color.png',
                    state.fullGps?.roll ?? 0,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${state.fullGps?.roll.toStringAsFixed(2)}°',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
