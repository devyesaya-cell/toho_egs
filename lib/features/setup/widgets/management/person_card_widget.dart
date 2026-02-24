import 'package:flutter/material.dart';
import '../../../../core/models/person.dart';

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
    bool isActive =
        (person.loginState?.toUpperCase() == 'ON' ||
        person.loginState?.toUpperCase() == 'ACTIVE'); // Changed condition
    Color statusColor = isActive ? const Color(0xFF2ECC71) : const Color(0xFFB0BEC5);
    Color glowColor = isActive
        ? const Color(0xFF2ECC71).withOpacity(0.3)
        : Colors.transparent;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1410), // Very dark logic
        border: Border.all(color: const Color(0xFF1E3A2A), width: 1.5),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 4)),
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
                width: 70, // Smaller
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
                  // Fallback or actual image
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
                bottom: -8, // Overlap slightly
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

          // Authenticated Operator Tick
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
                  // if (person.preset != null)
                  //   Text(
                  //     person.preset!.toUpperCase(),
                  //     style: const TextStyle(
                  //       color: Colors.white54,
                  //       fontSize: 8,
                  //     ),
                  //   ),
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          // ID
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.badge, size: 12, color: const Color(0xFFB0BEC5)),
              const SizedBox(width: 4),
              Text(
                person.driverID ?? '---',
                style: const TextStyle(color: const Color(0xFFB0BEC5), fontSize: 10),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Info Grid
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B), // Darker inner box
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem('ROLE', person.role ?? 'N/A'),
                Container(width: 1, height: 20, color: Colors.white10),
                _buildInfoItem('EQUIPMENT', person.equipment ?? 'N/A'),
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
                backgroundColor: const Color(0xFF2ECC71),
                foregroundColor: Colors.black,
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
                  foregroundColor: Colors.white38,
                  side: const BorderSide(color: Colors.white12),
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

  Widget _buildInfoItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: const Color(0xFFB0BEC5),
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
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
