import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/models/workfile.dart';

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
    bool isOpen = workfile.status?.toLowerCase() == 'open';
    Color statusColor = isOpen ? const Color(0xFF2ECC71) : Colors.grey;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1410), // Dark background
        border: Border.all(color: const Color(0xFF1E3A2A), width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 4)),
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
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.folder,
                  color: Color(0xFFF1C40F),
                  size: 24,
                ), // Amber folder
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
                      style: const TextStyle(
                        color: Colors.white,
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
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: statusColor.withOpacity(0.5)),
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
          const Divider(color: Color(0xFF1E3A2A), height: 1),
          const SizedBox(height: 16),

          // Details Grid
          _buildDetailRow('CONTRACTOR', workfile.contractor),
          const SizedBox(height: 8),
          _buildDetailRow('UID', workfile.uid?.toString()),
          const SizedBox(height: 8),
          _buildDetailRow('CREATED', _formatDate(workfile.createAt)),

          const Spacer(),

          // Footer: Stats or Actions
          if (showDelete) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 32,
              child: OutlinedButton(
                onPressed: onDelete,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444), // Red
                  side: const BorderSide(color: Color(0xFFEF4444), width: 1),
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

  Widget _buildDetailRow(String label, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value ?? '-',
          style: const TextStyle(color: Colors.white, fontSize: 11),
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
