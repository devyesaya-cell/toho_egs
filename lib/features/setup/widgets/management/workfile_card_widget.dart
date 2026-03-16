import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/models/workfile.dart';
import '../../../../core/utils/app_theme.dart';

class WorkfileCardWidget extends StatelessWidget {
  final WorkFile workfile;
  final VoidCallback onDelete;
  final bool showDelete;

  const WorkfileCardWidget({
    super.key,
    required this.workfile,
    required this.onDelete,
    this.showDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    // Open/Done status is semantic/data-driven
    bool isOpen = workfile.status?.toLowerCase() == 'open';
    Color statusColor =
        isOpen ? const Color(0xFF2ECC71) : const Color(0xFFB0BEC5);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardSurface,
        border: Border.all(color: theme.cardBorderColor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Area Name + Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.cardSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.folder,
                  color: Color(0xFFF1C40F), // Amber folder — kept semantic
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workfile.areaName ?? 'UNKNOWN AREA',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: theme.textOnSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: statusColor.withValues(alpha: 0.5)),
                      ),
                      child: Text(
                        (workfile.status ?? 'UNKNOWN').toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: theme.dividerColor, height: 1),
          const SizedBox(height: 16),

          // Details Grid
          _buildDetailRow(theme, 'CONTRACTOR', workfile.contractor),
          const SizedBox(height: 8),
          _buildDetailRow(theme, 'UID', workfile.uid?.toString()),
          const SizedBox(height: 8),
          _buildDetailRow(theme, 'CREATED', _formatDate(workfile.createAt)),

          const Spacer(),

          if (showDelete) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 32,
              child: OutlinedButton(
                onPressed: onDelete,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444), // kept semantic red
                  side: const BorderSide(color: Color(0xFFEF4444), width: 1),
                  backgroundColor: Colors.transparent,
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('DELETE WORKFILE'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(AppThemeData theme, String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value ?? '-',
          style: TextStyle(color: theme.textOnSurface, fontSize: 11),
        ),
      ],
    );
  }

  String _formatDate(int? millis) {
    if (millis == null) return '-';
    return DateFormat(
      'dd MMM yyyy',
    ).format(DateTime.fromMillisecondsSinceEpoch(millis));
  }
}
