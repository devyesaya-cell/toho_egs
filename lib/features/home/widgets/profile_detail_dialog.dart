import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/person.dart';
import 'person_edit_dialog.dart';

class ProfileDetailDialog extends ConsumerWidget {
  final Person person;

  const ProfileDetailDialog({super.key, required this.person});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine shift
    final hour = DateTime.now().hour;
    final isMorning = hour >= 6 && hour < 18;
    final shiftName = isMorning ? 'Morning' : 'Night';
    final shiftTime = isMorning ? '06:00 - 18:00' : '18:00 - 06:00';

    final hasImage = person.picURL != null && person.picURL!.isNotEmpty;

    return Dialog(
      backgroundColor: const Color(0xFF111812), // Very Dark Green/Black
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF1E3A20), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Close Button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            // Avatar Region
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.greenAccent, width: 2),
                    image: hasImage
                        ? DecorationImage(
                            image: AssetImage(person.picURL!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey[800],
                  ),
                  child: !hasImage
                      ? Center(
                          child: Text(
                            person.firstName?[0].toUpperCase() ?? '?',
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'ONLINE',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Authenticated Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.verified_user,
                  color: Colors.greenAccent,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'AUTHENTICATED OPERATOR',
                  style: TextStyle(
                    color: Colors.greenAccent.withOpacity(0.8),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Name & ID
            Text(
              '${person.firstName} ${person.lastName ?? ""}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.badge_outlined,
                  color: Colors.white54,
                  size: 14,
                ),
                const SizedBox(width: 8),
                Text(
                  'Employee ID: ${person.driverID ?? "N/A"}',
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Info Cards
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    'CURRENT ROLE',
                    person.role?.toUpperCase() ?? 'OPERATOR',
                    person.kontraktor?.toUpperCase() ?? '',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    'CURRENT SHIFT',
                    shiftName,
                    '($shiftTime)',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Status Bullets
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusBullet('Excavator Unit\n04-A Active'),
                _buildStatusBullet('Safety Protocols\nVerified'),
              ],
            ),

            const SizedBox(height: 32),

            // Customize Button (Green)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Switch to Edit Dialog
                  Navigator.pop(context); // Close detail
                  showDialog(
                    context: context,
                    builder: (context) => PersonEditDialog(person: person),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981), // Emerald Green
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.settings, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'CUSTOMIZE PROFILE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Close Button (Grey)
            // SizedBox(
            //   width: double.infinity,
            //   height: 50,
            //   child: OutlinedButton(
            //     onPressed: () => Navigator.of(context).pop(),
            //     style: OutlinedButton.styleFrom(
            //       backgroundColor: Colors.white.withOpacity(0.05),
            //       foregroundColor: Colors.white,
            //       side: BorderSide(color: Colors.white.withOpacity(0.1)),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const [
            //         Icon(Icons.logout, size: 20),
            //         SizedBox(width: 8),
            //         Text(
            //           'CLOSE DIALOG',
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // const SizedBox(height: 12),
            const Text(
              'v4.2.0',
              style: TextStyle(
                color: Colors.white24,
                fontSize: 10,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, String subValue) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A261C), // Dark Greenish Grey
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subValue.isNotEmpty)
            Text(
              subValue,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusBullet(String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.greenAccent,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
