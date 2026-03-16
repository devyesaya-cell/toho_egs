import 'package:flutter/material.dart';
import '../../../../core/models/person.dart';
import '../../../../core/utils/app_theme.dart';

class PersonCardWidget extends StatelessWidget {
  final Person person;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool showDelete;

  const PersonCardWidget({
    super.key,
    required this.person,
    required this.onEdit,
    required this.onDelete,
    this.showDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    // active/inactive is data-driven semantic color
    bool isActive =
        (person.loginState?.toUpperCase() == 'ON' ||
        person.loginState?.toUpperCase() == 'ACTIVE');
    Color statusColor =
        isActive ? const Color(0xFF2ECC71) : const Color(0xFFB0BEC5);
    Color glowColor = isActive
        ? const Color(0xFF2ECC71).withValues(alpha: 0.3)
        : Colors.transparent;

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image / Avatar Frame
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: glowColor,
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                  image: person.picURL != null
                      ? DecorationImage(
                          image: AssetImage(person.picURL!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: person.picURL == null
                    ? Icon(Icons.person, size: 50, color: statusColor)
                    : null,
              ),
              Positioned(
                bottom: -8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isActive ? 'ACTIVE' : 'INACTIVE',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: statusColor, size: 12),
              const SizedBox(width: 4),
              Column(
                children: [
                  Text(
                    '${person.preset?.toUpperCase()} OPERATOR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            '${person.firstName} ${person.lastName}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: theme.textOnSurface,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          // ID
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.badge, size: 12, color: theme.textSecondary),
              const SizedBox(width: 4),
              Text(
                person.driverID ?? '---',
                style: TextStyle(color: theme.textSecondary, fontSize: 10),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Info Grid
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              color: theme.cardSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(theme, 'ROLE', person.role ?? 'N/A'),
                Container(width: 1, height: 20, color: theme.dividerColor),
                _buildInfoItem(theme, 'EQUIPMENT', person.equipment ?? 'N/A'),
              ],
            ),
          ),

          const Spacer(),

          // Buttons
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.settings, size: 14),
              label: const Text('CUSTOMIZE PROFILE'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryButtonBackground,
                foregroundColor: theme.primaryButtonText,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
                padding: const EdgeInsets.symmetric(vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          if (showDelete) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: OutlinedButton(
                onPressed: onDelete,
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.textSecondary,
                  side: BorderSide(color: theme.dividerColor),
                  textStyle: const TextStyle(fontSize: 10),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('DELETE'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoItem(AppThemeData theme, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: theme.textSecondary,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: theme.textOnSurface, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
