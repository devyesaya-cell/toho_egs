import 'package:flutter/material.dart';
import '../../../core/models/workfile.dart';
import '../../../core/utils/app_theme.dart';

class WorkfileCard extends StatelessWidget {
  final WorkFile workfile;
  final VoidCallback? onTap;

  const WorkfileCard({Key? key, required this.workfile, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    // Progress calculation
    final total = workfile.totalSpot ?? 0;
    final done = workfile.spotDone ?? 0;
    final progress = total > 0 ? done / total : 0.0;
    final spacing = '${workfile.panjang}x${workfile.lebar}';

    // Status color is data-driven / semantic — kept fixed
    final Color statusColor = workfile.status == 'Done'
        ? const Color(0xFF2ECC71)
        : const Color(0xFF3B82F6);

    return Card(
      margin: EdgeInsets.zero,
      color: theme.cardSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.cardBorderColor, width: 1.5),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: theme.textOnSurface,
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
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      (workfile.status ?? 'Open').toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
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
              _buildDetailRow(theme, Icons.business, 'Contractor',
                  workfile.contractor ?? '-'),
              const SizedBox(height: 8),
              _buildDetailRow(theme, Icons.grid_on, 'Spacing', spacing),
              const SizedBox(height: 8),
              _buildDetailRow(
                theme,
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
                      Text(
                        'PROGRESS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: theme.textSecondary,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toStringAsFixed(1)}% ($done/$total)',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.textOnSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: theme.pageBackground,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        // Progress bar stays semantic green
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

  Widget _buildDetailRow(
      AppThemeData theme, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: theme.textSecondary),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(fontSize: 12, color: theme.textSecondary),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: theme.textOnSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
