import 'package:flutter/material.dart';
import '../../../../core/models/contractor.dart';
import '../../../../core/utils/app_theme.dart';

class ContractorCardWidget extends StatelessWidget {
  final Contractor contractor;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ContractorCardWidget({
    super.key,
    required this.contractor,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.pageBackground,
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
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.cardSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.business, color: theme.iconBoxIcon, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contractor.name ?? 'UNKNOWN',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: theme.textOnSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    if (contractor.sector != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        contractor.sector!.toUpperCase(),
                        style: TextStyle(
                          color: theme.appBarAccent,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(color: theme.dividerColor, height: 1),
          const SizedBox(height: 12),

          // Details
          _buildDetailRow(theme, Icons.map_outlined, 'AREA', contractor.area),
          const SizedBox(height: 6),
          _buildDetailRow(
            theme,
            Icons.handyman_outlined,
            'EQUIPMENT',
            contractor.numberEquipment?.toStringAsFixed(0),
          ),
          const SizedBox(height: 6),
          _buildDetailRow(
            theme,
            Icons.person_outline,
            'OPERATORS',
            contractor.numberOperator?.toStringAsFixed(0),
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
                      backgroundColor: theme.primaryButtonBackground,
                      foregroundColor: theme.primaryButtonText,
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
                    foregroundColor: const Color(0xFFEF4444), // destructive
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

  Widget _buildDetailRow(
      AppThemeData theme, IconData icon, String label, String? value) {
    return Row(
      children: [
        Icon(icon, size: 12, color: theme.textSecondary),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: theme.textSecondary,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          value ?? '-',
          style: TextStyle(color: theme.textOnSurface, fontSize: 11),
        ),
      ],
    );
  }
}
