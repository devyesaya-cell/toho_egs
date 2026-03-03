import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/models/gps_loc.dart';
import '../../presenter/debug_presenter.dart';

class RoverDebugTab extends ConsumerStatefulWidget {
  const RoverDebugTab({super.key});

  @override
  ConsumerState<RoverDebugTab> createState() => _RoverDebugTabState();
}

class _RoverDebugTabState extends ConsumerState<RoverDebugTab> {
  final DebugPresenter _presenter = DebugPresenter();

  @override
  Widget build(BuildContext context) {
    final gpsAsync = ref.watch(gpsStreamProvider);

    return gpsAsync.when(
      data: (gpsData) => _buildDataView(gpsData),
      loading: () => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF2ECC71)),
            SizedBox(height: 16),
            Text(
              'Waiting for GPSLoc data stream...',
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

  Widget _buildDataView(GPSLoc gpsData) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Row 1: GPS 1 & GPS 2
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: _buildGpsCard(
                    'GPS 1',
                    gpsData.hAcc1,
                    gpsData.vAcc1,
                    gpsData.satelit,
                    gpsData.status,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildGpsCard(
                    'GPS 2',
                    gpsData.hAcc2,
                    gpsData.vAcc2,
                    gpsData.satelit2,
                    gpsData.status2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Row 2: Power, Radio, Position
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: _buildPowerCard(
                    gpsData.mcuVoltage,
                    gpsData.mcuTemperature,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildRadioCard(
                    gpsData.rssi,
                    gpsData.lastCorrection,
                    gpsData.lastBasePacket,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _buildPositionCard(
                    gpsData.boomLat,
                    gpsData.boomLng,
                    gpsData.trackHeight,
                  ),
                ), // Using boomLat/Lng as placeholders for Body Lat/Lng
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGpsCard(
    String title,
    int hAcc,
    int vAcc,
    int satellite,
    String status,
  ) {
    return _buildCardTemplate(
      title: title,
      icon: Icons.satellite_alt,
      mainValue: status,
      bottomWidget: Text(
        'H-Acc: $hAcc  •  V-Acc: $vAcc  •  Sat: $satellite',
        style: const TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPowerCard(double vin, double mcuTemp) {
    return _buildCardTemplate(
      title: 'Power',
      icon: Icons.battery_charging_full,
      mainValue: vin.toStringAsFixed(2),
      mainSuffix: 'V',
      bottomWidget: Text(
        'MCU Temp: ${mcuTemp.toStringAsFixed(1)} °C',
        style: const TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildRadioCard(int rssi, int lastCorrection, int lastBasePacket) {
    return _buildCardTemplate(
      title: 'Radio',
      icon: Icons.cell_tower,
      mainValue: '$rssi',
      mainSuffix: 'dBm',
      bottomWidget: Text(
        'Cor: ${_presenter.formatTime(lastCorrection)}  •  Pkg: ${_presenter.formatTime(lastBasePacket)}',
        style: const TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPositionCard(double bodyLat, double bodyLng, int trackHeight) {
    return _buildCardTemplate(
      title: 'Position',
      icon: Icons.location_on,
      mainValue: '$trackHeight',
      mainSuffix: 'mm',
      bottomWidget: Text(
        'Lat: ${bodyLat.toStringAsFixed(5)}  •  Lng: ${bodyLng.toStringAsFixed(5)}',
        style: const TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCardTemplate({
    required String title,
    required IconData icon,
    required String mainValue,
    String? mainSuffix,
    required Widget bottomWidget,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // Dark blueish tint
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
            // Right-side Accent Bar
            Positioned(
              right: 0,
              top: 24,
              bottom: 24,
              width: 20,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2ECC71), // Primary Green
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon
                  Icon(icon, color: Colors.white, size: 28),

                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Main Value
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        mainValue,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (mainSuffix != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          mainSuffix,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Bottom Info
                  bottomWidget,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
