import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/state/auth_state.dart';
import '../../../core/utils/app_theme.dart';

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
    final theme = AppTheme.of(context);
    final selectedIndex = ref.watch(selectedMenuProvider);

    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        color: theme.menuBackground,
        border: Border(
          right: BorderSide(color: theme.menuBorder, width: 1.5),
        ),
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
                _buildSectionHeader('Menu', theme),
                _buildMenuItem(context, ref, theme,
                    index: 0,
                    icon: Icons.folder_open,
                    label: 'Work Files',
                    isSelected: selectedIndex == 0),
                _buildMenuItem(context, ref, theme,
                    index: 1,
                    icon: Icons.dashboard_outlined,
                    label: 'Dashboard',
                    isSelected: selectedIndex == 1),
                _buildMenuItem(context, ref, theme,
                    index: 2,
                    icon: Icons.timeline,
                    label: 'Timesheet',
                    isSelected: selectedIndex == 2),
                _buildMenuItem(context, ref, theme,
                    index: 3,
                    icon: Icons.notifications_none,
                    label: 'Alarm',
                    isSelected: selectedIndex == 3),

                const SizedBox(height: 24),
                _buildSectionHeader('System', theme),
                _buildMenuItem(context, ref, theme,
                    index: 4,
                    icon: Icons.settings_outlined,
                    label: 'Setup',
                    isSelected: selectedIndex == 4),
                const SizedBox(height: 24),
                _buildSystemStatus(ref, theme),
              ],
            ),
          ),

          _DateTimeWidget(theme: theme),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, AppThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: theme.sectionHeaderColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    WidgetRef ref,
    AppThemeData theme, {
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
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: isSelected
            ? BoxDecoration(
                color: theme.menuSelectedBackground,
                borderRadius: const BorderRadius.horizontal(
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
                  ? theme.menuSelectedIcon
                  : theme.menuUnselectedIcon,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? theme.menuSelectedText
                    : theme.menuUnselectedText,
                fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemStatus(WidgetRef ref, AppThemeData theme) {
    final authState = ref.watch(authProvider);
    final mode = authState.mode;
    String modeLabel = 'UNKNOWN';
    IconData modeIcon = Icons.help_outline;
    // System mode colors are semantic — remain fixed regardless of theme
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
          // System Mode card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.cardSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.cardBorderColor),
            ),
            child: Row(
              children: [
                Icon(modeIcon, size: 16, color: modeColor),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SYSTEM MODE',
                      style: TextStyle(
                        fontSize: 10,
                        color: theme.sectionHeaderColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Text(
                      modeLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.textOnSurface,
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
  final AppThemeData theme;
  const _DateTimeWidget({required this.theme});

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
    final theme = widget.theme;
    final timeString =
        "${_now.hour.toString().padLeft(2, '0')}:${_now.minute.toString().padLeft(2, '0')}:${_now.second.toString().padLeft(2, '0')}";

    const monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    const dayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final monthString = monthNames[_now.month - 1];
    final dayString = dayNames[_now.weekday - 1];
    final dateString = "$dayString, ${_now.day} $monthString ${_now.year}";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.dateTimeGradientStart,
            theme.dateTimeGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dateTimeBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: theme.dateTimeClockColor,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dateString,
                style: TextStyle(
                  color: theme.dateTimeDateColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.dateTimeIconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.access_time_filled,
              color: theme.dateTimeClockColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
