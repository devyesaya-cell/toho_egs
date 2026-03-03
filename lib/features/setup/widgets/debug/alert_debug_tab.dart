import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/models/error_alert.dart';

class AlertDebugTab extends ConsumerWidget {
  const AlertDebugTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertData = ref.watch(errorProvider);

    if (alertData == null) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, size: 48, color: Colors.white24),
            SizedBox(height: 16),
            Text(
              'No active alerts received.',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return _buildDataView(alertData);
  }

  Widget _buildDataView(ErrorAlert alert) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Row 1: Source & Type
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: _buildSourceCard(alert)),
                const SizedBox(width: 24),
                Expanded(child: _buildTypeCard(alert)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Row 2: Message & Timestamp
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(child: _buildMessageCard(alert)),
                const SizedBox(width: 24),
                Expanded(child: _buildTimestampCard(alert)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceCard(ErrorAlert alert) {
    return _buildCardTemplate(
      title: 'Error Source',
      icon: Icons.radar,
      mainValue: alert.sourceID.toUpperCase(),
      bottomWidget: const Text(
        'Originating Subsystem Parameter',
        style: TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      isErrorVariant: alert.sourceID != 'N/A',
    );
  }

  Widget _buildTypeCard(ErrorAlert alert) {
    return _buildCardTemplate(
      title: 'Alert Type',
      icon: Icons.running_with_errors,
      mainValue: alert.alertType,
      bottomWidget: const Text(
        'Error Classification Category',
        style: TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      isErrorVariant: alert.alertType != 'N/A',
    );
  }

  Widget _buildMessageCard(ErrorAlert alert) {
    return _buildCardTemplate(
      title: 'Message Details',
      icon: Icons.message,
      mainValue: alert.message,
      bottomWidget: const Text(
        'System Exception Description',
        style: TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      isErrorVariant: alert.message != 'N/A',
    );
  }

  Widget _buildTimestampCard(ErrorAlert alert) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm:ss');

    return _buildCardTemplate(
      title: 'Log Timestamp',
      icon: Icons.access_time_filled,
      mainValue: timeFormat.format(alert.timestamp),
      bottomWidget: Text(
        'Date Recorded: ${dateFormat.format(alert.timestamp)}',
        style: const TextStyle(color: Colors.white70, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      isErrorVariant: false,
    );
  }

  Widget _buildCardTemplate({
    required String title,
    required IconData icon,
    required String mainValue,
    required Widget bottomWidget,
    bool isErrorVariant = false,
  }) {
    // If it's an active error value, color it Red instead of Green
    final accentColor = isErrorVariant
        ? const Color(0xFFE74C3C) // Red accent for real errors
        : const Color(0xFF2ECC71); // Green accent for default/timestamps

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // Dark blueish tint
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accentColor.withOpacity(0.3), width: 2),
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
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.only(
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
                  // Icon & Title
                  Row(
                    children: [
                      Icon(icon, color: Colors.white, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // Main Value
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        mainValue,
                        style: TextStyle(
                          color: isErrorVariant ? accentColor : Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
