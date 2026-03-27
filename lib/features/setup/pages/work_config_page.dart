import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/state/auth_state.dart';
import '../../../../core/coms/com_service.dart';
import '../../../../core/services/notification_service.dart';
import 'work_config_presenter.dart';

class WorkConfigPage extends ConsumerStatefulWidget {
  const WorkConfigPage({super.key});

  @override
  ConsumerState<WorkConfigPage> createState() => _WorkConfigPageState();
}

class _WorkConfigPageState extends ConsumerState<WorkConfigPage> {
  int _selectedIndex = 0;
  int _selectedValue = 0;

  final Map<int, String> _indexNames = {
    0: '0 - GNSS Altitude Ref',
    1: '1 - Altitude Reference',
    2: '2 - Bucket Length Ref',
    3: '3 - Bucket Horiz Ref',
    4: '4 - Pitch Compensation',
  };

  final Map<int, Map<int, String>> _valueOptions = {
    0: {0: '0 - MSL', 1: '1 - Ellipsoid'},
    1: {0: '0 - GNSS', 1: '1 - OGL'},
    2: {0: '0 - Teeth', 1: '1 - Back'},
    3: {0: '0 - Center', 1: '1 - Left', 2: '2 - Right'},
    4: {0: '0 - No', 1: '1 - Yes'},
  };

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Dynamic theme colors for the Calibration layout strictly following the rule but adapting to dual theme
    final panelBg = isDark ? const Color(0xFF1E293B) : Colors.orange.shade50;
    final panelBorderColor = isDark
        ? const Color(0xFF1E3A2A)
        : Colors.orange.shade200;
    final textColor = isDark ? Colors.white : Colors.black87;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;

    final configState = ref.watch(workConfigProvider);

    return Scaffold(
      backgroundColor: theme.pageBackground,
      appBar: AppBar(
        title: Text(
          'WORK CONFIG',
          style: TextStyle(
            color: theme.appBarForeground,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: theme.appBarBackground,
        foregroundColor: theme.appBarForeground,
        elevation: 0,
        actions: [
          _buildAppBarActions(context, ref, theme),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // LEFT COLUMN
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Image Region
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: panelBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: panelBorderColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'images/exca_cal.png', // Fallback image
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Bottom Control Region
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: panelBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: panelBorderColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Index Dropdown
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Parameter Type',
                                    style: TextStyle(
                                      color: secondaryTextColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  DropdownButton<int>(
                                    value: _selectedIndex,
                                    isExpanded: true,
                                    dropdownColor: panelBg,
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    underline: Container(
                                      height: 1,
                                      color: panelBorderColor,
                                    ),
                                    items: _indexNames.entries.map((e) {
                                      return DropdownMenuItem<int>(
                                        value: e.key,
                                        child: Text(e.value),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _selectedIndex = val;
                                          // Reset value if not present in new options
                                          if (!_valueOptions[val]!.containsKey(
                                            _selectedValue,
                                          )) {
                                            _selectedValue =
                                                _valueOptions[val]!.keys.first;
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: isDark ? Colors.white24 : Colors.black12,
                          ),
                          // Value Dropdown
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Value',
                                    style: TextStyle(
                                      color: secondaryTextColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  DropdownButton<int>(
                                    value: _selectedValue,
                                    isExpanded: true,
                                    dropdownColor: panelBg,
                                    style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    underline: Container(
                                      height: 1,
                                      color: panelBorderColor,
                                    ),
                                    items: _valueOptions[_selectedIndex]!
                                        .entries
                                        .map((e) {
                                          return DropdownMenuItem<int>(
                                            value: e.key,
                                            child: Text(e.value),
                                          );
                                        })
                                        .toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _selectedValue = val;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: double.infinity,
                            color: isDark ? Colors.white24 : Colors.black12,
                          ),
                          // Set Button
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2ECC71),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  ref
                                      .read(workConfigProvider.notifier)
                                      .setWorkConfigParam(
                                        _selectedIndex,
                                        _selectedValue,
                                      );
                                  NotificationService.showCommandNotification(
                                    context,
                                    title: 'Work Config Updated',
                                    message: 'Parameter Set',
                                    modeStr:
                                        '${_indexNames[_selectedIndex]}: ${_valueOptions[_selectedIndex]![_selectedValue]}',
                                    icon: Icons.settings,
                                    iconColor: Colors.white,
                                    headerColor: Colors.blueGrey,
                                  );
                                },
                                child: const Text(
                                  'SET',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // RIGHT COLUMN
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: panelBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: panelBorderColor),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'PARAMETERS',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: 16,
                      ),
                    ),
                    Divider(color: panelBorderColor),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(8.0),
                        children: [
                          _buildParamCard(
                            panelBg,
                            textColor,
                            secondaryTextColor,
                            '0',
                            'GNSS Alt Ref',
                            _valueOptions[0]![configState.config.gnssAltRef] ??
                                '0',
                          ),
                          _buildParamCard(
                            panelBg,
                            textColor,
                            secondaryTextColor,
                            '1',
                            'Altitude Ref',
                            _valueOptions[1]![configState.config.altRef] ?? '0',
                          ),
                          _buildParamCard(
                            panelBg,
                            textColor,
                            secondaryTextColor,
                            '2',
                            'Bucket Len Ref',
                            _valueOptions[2]![configState
                                    .config
                                    .bucketLenRef] ??
                                '0',
                          ),
                          _buildParamCard(
                            panelBg,
                            textColor,
                            secondaryTextColor,
                            '3',
                            'Bucket Horiz Ref',
                            _valueOptions[3]![configState
                                    .config
                                    .bucketHorizRef] ??
                                '0',
                          ),
                          _buildParamCard(
                            panelBg,
                            textColor,
                            secondaryTextColor,
                            '4',
                            'Pitch Comp',
                            _valueOptions[4]![configState.config.pitchComp] ??
                                '0',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParamCard(
    Color bg,
    Color textColor,
    Color secondaryTextColor,
    String index,
    String title,
    String valueDisplay,
  ) {
    return Card(
      color: bg,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white12, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Idx $index',
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(color: secondaryTextColor, fontSize: 12),
                ),
              ],
            ),
            Text(
              valueDisplay,
              style: const TextStyle(
                color: Color(0xFF2ECC71),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Same AppBar builder from WirelessPage
  Widget _buildAppBarActions(
    BuildContext context,
    WidgetRef ref,
    AppThemeData theme,
  ) {
    final usbState = ref.watch(comServiceProvider);

    bool hasDataStream = false;
    if (usbState.lastDataReceived != null) {
      final diff = DateTime.now().difference(usbState.lastDataReceived!);
      if (diff.inSeconds < 2) {
        hasDataStream = true;
      }
    }
    final bool isActive = usbState.isConnected && hasDataStream;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(
                  Icons.usb,
                  color: isActive ? Colors.greenAccent : Colors.red,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  isActive ? 'RS232 Active' : 'RS232 Inactive',
                  style: TextStyle(
                    color: isActive ? Colors.greenAccent : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 16),
        Container(width: 1, height: 24, color: theme.menuBorder),
        const SizedBox(width: 16),
        Builder(
          builder: (context) {
            final authState = ref.watch(authProvider);
            final person = authState.currentUser;
            final name = person != null
                ? '${person.firstName} ${person.lastName}'
                : 'Unknown';
            final contractor = person?.kontraktor ?? 'Unknown';
            final photoUrl = person?.picURL;

            return InkWell(
              onTap: () => _showLogoutDialog(context, ref, theme),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                          ? AssetImage(photoUrl)
                          : const AssetImage('images/driver_exca.png')
                                as ImageProvider,
                      backgroundColor: theme.surfaceColor,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: theme.appBarForeground,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          contractor,
                          style: TextStyle(
                            color: theme.appBarAccent,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(
    BuildContext context,
    WidgetRef ref,
    AppThemeData theme,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.dialogBackground,
        title: Row(
          children: [
            const Icon(Icons.logout, color: Colors.orange),
            const SizedBox(width: 8),
            Text('Sign Out', style: TextStyle(color: theme.textOnSurface)),
          ],
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: theme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('CANCEL', style: TextStyle(color: theme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ref.read(authProvider.notifier).logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryButtonBackground,
              foregroundColor: theme.primaryButtonText,
            ),
            child: const Text('SIGN OUT'),
          ),
        ],
      ),
    );
  }
}
