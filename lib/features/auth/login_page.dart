import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/state/auth_state.dart';
import '../../core/repositories/app_repository.dart';
import '../../core/models/person.dart';
import '../../core/services/notification_service.dart';
import '../../core/coms/com_service.dart';
import '../../core/utils/app_theme.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  Person? _selectedPerson;
  List<Person> _persons = [];
  SystemMode _selectedMode = SystemMode.spot; // Default to Spot (Op)

  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    final repo = ref.read(appRepositoryProvider);
    await repo.checkAndSeedDefaultUser();
    final persons = await repo.getAllPersons();

    if (mounted) {
      setState(() {
        _persons = persons;
        // Auto-select first if available
        if (_persons.isNotEmpty) {
          _selectedPerson = _persons.first;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ── Detect Android Dark Mode ──────────────────────────────────────────
    final theme = AppTheme.of(context);
    final isDark =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('images/login_bg.jpeg', fit: BoxFit.cover),
          ),

          // Overlay — lighter in light mode, darker in dark mode
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: theme.overlayOpacity),
            ),
          ),

          // Main Content
          Row(
            children: [
              // ── Left Side: Branding ─────────────────────────────────────
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: theme.logoBadgeBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.logoBadgeBorder,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('images/logoToho.png', height: 32),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'TOHO EGS',
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF3E2723),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'EXCAVATOR GUIDANCE SYSTEM',
                                  style: TextStyle(
                                    color: theme.labelColor,
                                    fontSize: 10,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      const Text(
                        'Ready for\nOperation.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'System diagnostics complete.\nPlease identify to unlock controls.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 48),
                      // Footer
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        color: Colors.black54,
                        child: const Text(
                          'POWERED BY   TOHO MITRA PRESISI',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Right Side: Login Form ──────────────────────────────────
              Expanded(
                flex: 4,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(right: 48),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: theme.cardBackground.withValues(alpha: isDark ? 0.95 : 0.97),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: theme.cardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Title
                        Text(
                          'Operator Login',
                          style: TextStyle(
                            color: theme.titleColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Access level: Forestry Management',
                          style: TextStyle(
                            color: theme.subtitleColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Operator Select
                        _buildLabel('SELECT OPERATOR', theme),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: theme.inputFill,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.inputBorder),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Person>(
                              value: _selectedPerson,
                              hint: Text(
                                'Choose operator name',
                                style: TextStyle(color: theme.dropdownHintText),
                              ),
                              dropdownColor: theme.dropdownBackground,
                              icon: Icon(
                                Icons.expand_more,
                                color: theme.dropdownIcon,
                              ),
                              style: TextStyle(color: theme.dropdownItemText),
                              isExpanded: true,
                              items: _persons
                                  .map(
                                    (p) => DropdownMenuItem(
                                      value: p,
                                      child: Text(
                                        '${p.firstName} ${p.lastName ?? ""}',
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) =>
                                  setState(() => _selectedPerson = val),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Access Code
                        _buildLabel('ACCESS CODE', theme),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          style: TextStyle(color: theme.inputTextColor),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: theme.inputFill,
                            hintText: '••••••',
                            hintStyle: TextStyle(color: theme.inputHintText),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: theme.inputBorder),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: theme.inputBorder),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.inputFocusedBorder,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: theme.visibilityIconColor,
                              ),
                              onPressed: () =>
                                  setState(() => _obscureText = !_obscureText),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // System Mode
                        _buildLabel('SYSTEM MODE', theme),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: theme.inputFill,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              _buildModeButton(
                                'SPOT',
                                Icons.settings_suggest,
                                SystemMode.spot,
                                theme,
                              ),
                              _buildModeButton(
                                'CRUMBLING',
                                Icons.school,
                                SystemMode.crumbling,
                                theme,
                              ),
                              _buildModeButton(
                                'MAINT',
                                Icons.build,
                                SystemMode.maintenance,
                                theme,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Initialize Button
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_selectedPerson == null) {
                                NotificationService.showError(
                                  'Select an Operator',
                                );
                                return;
                              }
                              if (_passwordController.text.isEmpty) {
                                NotificationService.showError('Enter Password');
                                return;
                              }
                              if (_passwordController.text !=
                                  _selectedPerson!.password) {
                                NotificationService.showError(
                                  'Invalid Password',
                                );
                                return;
                              }

                              NotificationService.showSuccess(
                                'Welcome ${_selectedPerson!.firstName}',
                              );
                              ref
                                  .read(authProvider.notifier)
                                  .login(_selectedPerson!, _selectedMode);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryButtonBackground,
                              foregroundColor: theme.primaryButtonText,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              shadowColor: theme.primaryButtonShadow,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'INITIALIZE SYSTEM',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildUsbStatus(ref, theme),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Help Button
          Positioned(
            bottom: 32,
            right: 32,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white54),
              ),
              child: const Icon(Icons.help_outline, color: Colors.white54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsbStatus(WidgetRef ref, AppThemeData theme) {
    final usbState = ref.watch(comServiceProvider);

    bool hasDataStream = false;
    if (usbState.lastDataReceived != null) {
      final diff = DateTime.now().difference(usbState.lastDataReceived!);
      if (diff.inSeconds < 2) {
        hasDataStream = true;
      }
    }

    final bool isActive = usbState.isConnected && hasDataStream;

    // Status active/inactive menggunakan warna semantik tetap (tidak ikut tema)
    // Active = hijau, Inactive = merah — konsisten di dark & light mode
    const Color activeColor = Colors.green;
    const Color inactiveColor = Colors.red;
    final Color indicatorColor = isActive ? activeColor : inactiveColor;

    return Row(
      children: [
        Icon(
          Icons.usb,
          color: indicatorColor,
          size: 14,
        ),
        const SizedBox(width: 4),
        Text(
          'Connection to RS232 : ',
          style: TextStyle(color: theme.usbLabelColor, fontSize: 12),
        ),
        Text(
          isActive ? 'Active' : 'Inactive',
          style: TextStyle(
            color: indicatorColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: indicatorColor,
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.6),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text, AppThemeData theme) {
    return Text(
      text,
      style: TextStyle(
        color: theme.labelColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildModeButton(
    String label,
    IconData icon,
    SystemMode mode,
    AppThemeData theme,
  ) {
    final isSelected = _selectedMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedMode = mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.modeButtonSelectedBackground
                : theme.modeButtonBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? theme.modeButtonSelectedText
                    : theme.modeButtonText,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? theme.modeButtonSelectedText
                      : theme.modeButtonText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
