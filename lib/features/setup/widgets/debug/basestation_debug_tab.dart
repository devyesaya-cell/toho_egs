import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/models/base_status.dart';

class BasestationDebugTab extends ConsumerWidget {
  const BasestationDebugTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bsData = ref.watch(bsProvider);

    if (bsData == null) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFF2ECC71)),
            SizedBox(height: 16),
            Text(
              'Waiting for Basestatus data stream...',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return _buildDataView(bsData);
  }

  Widget _buildDataView(Basestatus bsData) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Row 1: GNSS Status & Position
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: _buildGnssStatusCard(bsData)),
                const SizedBox(width: 24),
                Expanded(child: _buildPositionCard(bsData)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Row 2: 3 Columns, each containing 2 Cards
          Expanded(
            flex: 2,
            child: Row(
              children: [
                // Column 1: Battery Voltage & Battery Current
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: _buildBatteryVoltageCard(bsData)),
                      const SizedBox(height: 24),
                      Expanded(child: _buildBatteryCurrentCard(bsData)),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Column 2: BMC & BCC
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: _buildBMCCard(bsData)),
                      const SizedBox(height: 24),
                      Expanded(child: _buildBCCCard(bsData)),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Column 3: Charging Status & BS Distance
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: _buildChargingStatusCard(bsData)),
                      const SizedBox(height: 24),
                      Expanded(child: _buildBSDistanceCard(bsData)),
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

  // Row 1 Cards
  Widget _buildGnssStatusCard(Basestatus bsData) {
    return _buildCardTemplate(
      title: 'GNSS Status',
      icon: Icons.satellite_alt,
      mainValue: bsData.status,
      bottomWidget: Text(
        'Accuracy: ${bsData.akurasi}  •  Satellite: ${bsData.satelit}',
        style: const TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPositionCard(Basestatus bsData) {
    return _buildCardTemplate(
      title: 'Position',
      icon: Icons.location_on,
      mainValue: '${bsData.altitude}',
      mainSuffix: 'mm',
      bottomWidget: Text(
        'Lat: ${bsData.lat.toStringAsFixed(7)}  •  Lng: ${bsData.long.toStringAsFixed(7)}',
        style: const TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // Row 2 Cards
  Widget _buildBatteryVoltageCard(Basestatus bsData) {
    return _buildCardTemplate(
      title: 'Battery Voltage',
      icon: Icons.electric_bolt,
      mainValue: bsData.batteryVoltage.toStringAsFixed(2),
      mainSuffix: 'V',
      bottomWidget: const Text(
        'Base station Battery Voltage',
        style: TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildBatteryCurrentCard(Basestatus bsData) {
    return _buildCardTemplate(
      title: 'Battery Current',
      icon: Icons.speed,
      mainValue: bsData.batteryCurrent.toStringAsFixed(2),
      mainSuffix: 'A',
      bottomWidget: const Text(
        'Base station Battery Current',
        style: TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildBMCCard(Basestatus bsData) {
    return _buildCardTemplate(
      title: 'BMC',
      icon: Icons.battery_full,
      mainValue: '${bsData.bmc}',
      mainSuffix: '%',
      bottomWidget: const Text(
        'Battery Max Capacity',
        style: TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildBCCCard(Basestatus bsData) {
    return _buildCardTemplate(
      title: 'BCC',
      icon: Icons.battery_charging_full,
      mainValue: '${bsData.bcc}',
      mainSuffix: '%',
      bottomWidget: const Text(
        'Battery Current Capacity',
        style: TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildChargingStatusCard(Basestatus bsData) {
    return _buildCardTemplate(
      title: 'Charging Status',
      icon: Icons.electrical_services,
      mainValue: bsData.chargetype,
      bottomWidget: const Text(
        'Battery Charging status',
        style: TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildBSDistanceCard(Basestatus bsData) {
    return _buildCardTemplate(
      title: 'BS Distance',
      icon: Icons.social_distance,
      mainValue: '${bsData.bsDistance}',
      mainSuffix: 'm',
      bottomWidget: const Text(
        'Basestation Distance',
        style: TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // The Card Template matching the design aesthetic from RoverDebugTab
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
              width: 8,
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
                      Expanded(
                        child: Text(
                          mainValue,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (mainSuffix != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          mainSuffix,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
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
