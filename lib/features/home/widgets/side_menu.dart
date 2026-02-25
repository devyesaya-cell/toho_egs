import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: const BoxDecoration(
        color: Color(0xFF0F1410), // Main Page Backgrounds
        border: Border(right: BorderSide(color: Color(0xFF1E3A2A), width: 1.5)),
      ),
      child: Column(
        children: [
          // Logo Area
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Image.asset(
              'images/banner.png',
              height: MediaQuery.of(context).size.height * 0.1,
              fit: BoxFit.contain,
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
                const SizedBox(height: 24),
                // _buildSectionHeader('Status'),
                _buildSystemStatus(ref),
              ],
            ),
          ),

          // Real-time Date & Time
          // const _DateTimeWidget(),
          const _DateTimeWidget(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFFB0BEC5), // Text Grey
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
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
                color: Color(0xFF1E3A2A), // Light hint of green
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
                  ? const Color(0xFF2ECC71)
                  : const Color(0xFFB0BEC5),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFFB0BEC5),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
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
    Color modeColor = const Color(0xFFB0BEC5);

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
        modeLabel = 'MAINTENANCE';
        modeIcon = Icons.build;
        modeColor = Colors.red;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          // USB Status
          // Container(
          //   padding: const EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: isUsbActive
          //         ? const Color(0xFF1E3A2A) // Dark Green Hint
          //         : const Color(0xFF3F1D1D), // Dark Red Hint
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(
          //       color: isUsbActive
          //           ? const Color(0xFF2ECC71).withOpacity(0.5)
          //           : const Color(0xFFEF4444).withOpacity(0.5),
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       Icon(
          //         Icons.usb,
          //         size: 16,
          //         color: isUsbActive
          //             ? const Color(0xFF2ECC71)
          //             : const Color(0xFFEF4444),
          //       ),
          //       const SizedBox(width: 8),
          //       Expanded(
          //         child: Column(
          //           children: [
          //             const Align(
          //               alignment: Alignment.centerLeft,
          //               child: Text(
          //                 'RS232 CONNECTION',
          //                 style: TextStyle(
          //                   fontSize: 10,
          //                   color: Color(0xFFB0BEC5),
          //                   fontWeight: FontWeight.bold,
          //                   letterSpacing: 1.1,
          //                 ),
          //               ),
          //             ),
          //             Row(
          //               children: [
          //                 Text(
          //                   isUsbActive ? 'Active' : 'Inactive',
          //                   style: TextStyle(
          //                     fontSize: 12,
          //                     fontWeight: FontWeight.bold,
          //                     color: isUsbActive
          //                         ? const Color(0xFF2ECC71)
          //                         : const Color(0xFFEF4444),
          //                   ),
          //                 ),
          //                 const Spacer(),
          //                 Container(
          //                   width: 8,
          //                   height: 8,
          //                   decoration: BoxDecoration(
          //                     color: isUsbActive
          //                         ? const Color(0xFF2ECC71)
          //                         : const Color(0xFFEF4444),
          //                     shape: BoxShape.circle,
          //                     boxShadow: isUsbActive
          //                         ? [
          //                             BoxShadow(
          //                               color: const Color(
          //                                 0xFF2ECC71,
          //                               ).withOpacity(0.6),
          //                               blurRadius: 4,
          //                               spreadRadius: 1,
          //                             ),
          //                           ]
          //                         : null,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 12),

          // System Mode
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B), // Surface Dark
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF1E3A2A)),
            ),
            child: Row(
              children: [
                Icon(modeIcon, size: 16, color: modeColor),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SYSTEM MODE',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFB0BEC5),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Text(
                      modeLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

class _DateTimeWidget extends StatefulWidget {
  const _DateTimeWidget();

  @override
  State<_DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<_DateTimeWidget> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeString =
        "${_now.hour.toString().padLeft(2, '0')}:${_now.minute.toString().padLeft(2, '0')}:${_now.second.toString().padLeft(2, '0')}";

    const monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    const dayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final monthString = monthNames[_now.month - 1];
    final dayString = dayNames[_now.weekday - 1];
    final dateString = "$dayString, ${_now.day} $monthString ${_now.year}";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A2A), Color(0xFF0F1410)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2ECC71).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                timeString,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFF2ECC71),
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dateString,
                style: const TextStyle(
                  color: Color(0xFFB0BEC5),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.access_time_filled,
              color: Color(0xFF2ECC71),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
