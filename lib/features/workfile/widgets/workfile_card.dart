import 'package:flutter/material.dart';
import '../../../core/models/workfile.dart';

class WorkfileCard extends StatelessWidget {
  final WorkFile workfile;
  final VoidCallback? onTap;

  const WorkfileCard({Key? key, required this.workfile, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Progress calculation
    final total = workfile.totalSpot ?? 0;
    final done = workfile.spotDone ?? 0;
    final progress = total > 0 ? done / total : 0.0;
    final spacing = '${workfile.panjang}x${workfile.lebar}';

    return Card(
      margin: EdgeInsets.zero,
      color: const Color(0xFF1E293B), // Surface Dark
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFF1E3A2A),
          width: 1.5,
        ), // Border Dark
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      workfile.areaName ?? 'Unknown Area',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: workfile.status == 'Done'
                          ? const Color(0xFF2ECC71).withOpacity(0.15)
                          : const Color(0xFF3B82F6).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: workfile.status == 'Done'
                            ? const Color(0xFF2ECC71).withOpacity(0.3)
                            : const Color(0xFF3B82F6).withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      (workfile.status ?? 'Open').toUpperCase(),
                      style: TextStyle(
                        color: workfile.status == 'Done'
                            ? const Color(0xFF2ECC71)
                            : const Color(0xFF3B82F6),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Details
              _buildDetailRow(
                Icons.business,
                'Contractor',
                workfile.contractor ?? '-',
              ),
              const SizedBox(height: 8),
              _buildDetailRow(Icons.grid_on, 'Spacing', spacing),
              const SizedBox(height: 8),
              _buildDetailRow(
                Icons.landscape,
                'Area',
                '${workfile.luasArea?.toStringAsFixed(2) ?? '0'} Ha',
              ),

              const Spacer(),

              // Progress Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'PROGRESS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB0BEC5),
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toStringAsFixed(1)}% ($done/$total)',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: const Color(0xFF0F1410),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress >= 1.0
                            ? const Color(0xFF10B981)
                            : const Color(0xFF2ECC71),
                      ),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF64748B)),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFFB0BEC5),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
