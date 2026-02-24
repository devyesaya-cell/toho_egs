import 'package:flutter/material.dart';
import '../../../../core/models/area.dart';

class AreaCardWidget extends StatelessWidget {
  final Area area;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AreaCardWidget({
    super.key,
    required this.area,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1410),
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
          // Header
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
                  Icons.terrain,
                  color: Color(0xFF2ECC71),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      area.areaName ?? 'UNKNOWN AREA',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (area.spacing != null) ...[
                      const SizedBox(height: 3),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2ECC71).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF2ECC71).withOpacity(0.4),
                          ),
                        ),
                        child: Text(
                          'SPACING ${area.spacing}',
                          style: const TextStyle(
                            color: Color(0xFF2ECC71),
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(color: Color(0xFF1E3A2A), height: 1),
          const SizedBox(height: 12),

          // Details
          _buildDetailRow(
            Icons.square_foot,
            'LUAS AREA',
            area.luasArea != null ? '${area.luasArea} Ha' : null,
          ),
          const SizedBox(height: 6),
          _buildDetailRow(
            Icons.schedule,
            'TARGET SELESAI',
            area.targetDone != null ? '${area.targetDone} Days' : null,
          ),

          const Spacer(),

          // Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 32,
                  child: ElevatedButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined, size: 12),
                    label: const Text('EDIT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71),
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 32,
                child: OutlinedButton(
                  onPressed: onDelete,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFEF4444),
                    side: const BorderSide(color: Color(0xFFEF4444)),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Icon(Icons.delete_outline, size: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String? value) {
    return Row(
      children: [
        Icon(icon, size: 12, color: const Color(0xFFB0BEC5)),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: const Color(0xFFB0BEC5),
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          value ?? '-',
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
      ],
    );
  }
}
