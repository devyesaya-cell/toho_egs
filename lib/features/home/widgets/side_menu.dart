import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_widget.dart';
import '../../../core/coms/com_service.dart';
import '../../../core/state/auth_state.dart';

// Provider to manage the selected menu index
class MenuNotifier extends Notifier<int> {
  @override
  int build() {
    return 1; // Default to Dashboard
  }

  void setIndex(int index) {
    state = index;
  }
}

final selectedMenuProvider = NotifierProvider<MenuNotifier, int>(
  MenuNotifier.new,
);

class SideMenu extends ConsumerWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedMenuProvider);

    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          // Logo Area
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: const [
                Icon(Icons.location_on, color: Colors.amber, size: 32),
                SizedBox(width: 12),
                Text(
                  'Toho',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildSectionHeader('Menu'),
                _buildMenuItem(
                  context,
                  ref,
                  index: 0,
                  icon: Icons.folder_open,
                  label: 'Work Files',
                  isSelected: selectedIndex == 0,
                ),
                _buildMenuItem(
                  context,
                  ref,
                  index: 1,
                  icon: Icons.dashboard_outlined,
                  label: 'Dashboard',
                  isSelected: selectedIndex == 1,
                ),
                _buildMenuItem(
                  context,
                  ref,
                  index: 2,
                  icon: Icons.timeline,
                  label: 'Timesheet',
                  isSelected: selectedIndex == 2,
                ),
                _buildMenuItem(
                  context,
                  ref,
                  index: 3,
                  icon: Icons.notifications_none,
                  label: 'Alarm',
                  isSelected: selectedIndex == 3,
                ),

                const SizedBox(height: 24),
                _buildSectionHeader('System'),
                _buildMenuItem(
                  context,
                  ref,
                  index: 4,
                  icon: Icons.settings_outlined,
                  label: 'Setup',
                  isSelected: selectedIndex == 4,
                ),
                // Dark Mode Toggle (Placeholder)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.dark_mode_outlined,
                        color: Color(0xFF94A3B8),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Dark Mode',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Switch(
                        value: false,
                        onChanged: (val) {},
                        activeTrackColor: Colors.blue,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                _buildSectionHeader('Status'),
                _buildSystemStatus(ref),
              ],
            ),
          ),

          // Date Time Placeholder
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '2\nFeb',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      '17:20',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Mon, 2026',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(),
          const ProfileWidget(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    WidgetRef ref, {
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        ref.read(selectedMenuProvider.notifier).setIndex(index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16), // Gap for rounded selection
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: isSelected
            ? const BoxDecoration(
                color: Color(0xFFF1F5F9), // Light background for selected
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(30),
                ),
              )
            : null,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? const Color(0xFF1E293B)
                  : const Color(0xFF94A3B8),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF1E293B)
                    : const Color(0xFF94A3B8),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemStatus(WidgetRef ref) {
    // 1. USB Status
    final usbState = ref.watch(comServiceProvider);
    bool hasDataStream = false;
    if (usbState.lastDataReceived != null) {
      final diff = DateTime.now().difference(usbState.lastDataReceived!);
      if (diff.inSeconds < 2) {
        hasDataStream = true;
      }
    }
    final bool isUsbActive = usbState.isConnected && hasDataStream;

    // 2. System Mode
    final authState = ref.watch(authProvider);
    final mode = authState.mode;
    String modeLabel = 'UNKNOWN';
    IconData modeIcon = Icons.help_outline;
    Color modeColor = Colors.grey;

    switch (mode) {
      case SystemMode.spot:
        modeLabel = 'SPOT';
        modeIcon = Icons.settings_suggest;
        modeColor = Colors.orange;
        break;
      case SystemMode.crumbling:
        modeLabel = 'CRUMBLING';
        modeIcon = Icons.school;
        modeColor = Colors.blue;
        break;
      case SystemMode.maintenance:
        modeLabel = 'MAINT';
        modeIcon = Icons.build;
        modeColor = Colors.red;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          // USB Status
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUsbActive
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isUsbActive
                    ? Colors.green.withOpacity(0.3)
                    : Colors.red.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.usb,
                  size: 16,
                  color: isUsbActive ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'RS232 Connection',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            isUsbActive ? 'Active' : 'Inactive',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isUsbActive ? Colors.green : Colors.red,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isUsbActive ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: isUsbActive
                                  ? [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.6),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // System Mode
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Icon(modeIcon, size: 16, color: modeColor),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'System Mode',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      modeLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
