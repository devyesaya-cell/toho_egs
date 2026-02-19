import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/state/auth_state.dart';
import 'profile_detail_dialog.dart';

class ProfileWidget extends ConsumerWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.currentUser;

    if (user == null) {
      return const SizedBox.shrink(); // Should not happen in Home
    }

    final fullName = '${user.firstName} ${user.lastName ?? ""}';
    final company = user.kontraktor ?? 'Unknown Contractor';
    // Use asset image if available, otherwise fallback
    final hasImage = user.picURL != null && user.picURL!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Row (Clickable for Edit)
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => ProfileDetailDialog(person: user),
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[800],
                  backgroundImage: hasImage ? AssetImage(user.picURL!) : null,
                  child: !hasImage
                      ? Text(
                          user.firstName?[0].toUpperCase() ?? '?',
                          style: const TextStyle(color: Colors.white),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1E293B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        company.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Logout Button
          InkWell(
            onTap: () {
              ref.read(authProvider.notifier).logout();
              // Navigation back to login is handled by LandingPage watching auth state
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.logout_rounded,
                    size: 20,
                    color: Color(0xFF64748B),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
