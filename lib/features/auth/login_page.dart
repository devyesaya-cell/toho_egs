import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/state/auth_state.dart';
import '../../core/repositories/app_repository.dart';
import '../../core/models/person.dart';
import '../../core/services/notification_service.dart';
import '../../core/coms/com_service.dart';

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
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('images/login_bg.jpeg', fit: BoxFit.cover),
          ),

          // Dark Overlay for contrast
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          // Main Content
          Row(
            children: [
              // Left Side: Branding
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(48.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo Area
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green, width: 1),
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
                                const Text(
                                  'TOHO EGS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'EXCAVATOR GUIDANCE SYSTEM',
                                  style: TextStyle(
                                    color: Colors.greenAccent[400],
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

              // Right Side: Login Form
              Expanded(
                flex: 4,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(right: 48),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF1E241E,
                      ).withOpacity(0.95), // Dark Greenish Black
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
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
                        const Text(
                          'Operator Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Access level: Forestry Management',
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                        const SizedBox(height: 32),

                        // Operator Select
                        _buildLabel('SELECT OPERATOR'),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Person>(
                              value: _selectedPerson,
                              hint: const Text(
                                'Choose operator name',
                                style: TextStyle(color: Colors.white54),
                              ),
                              dropdownColor: const Color(0xFF1E241E),
                              icon: const Icon(
                                Icons.expand_more,
                                color: Colors.green,
                              ),
                              style: const TextStyle(color: Colors.white),
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
                        _buildLabel('ACCESS CODE'),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            hintText: '••••••',
                            hintStyle: const TextStyle(color: Colors.white24),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.white24,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.white24,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.white54,
                              ),
                              onPressed: () =>
                                  setState(() => _obscureText = !_obscureText),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // System Mode
                        _buildLabel('SYSTEM MODE'),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              _buildModeButton(
                                'SPOT',
                                Icons.settings_suggest,
                                SystemMode.spot,
                              ),
                              _buildModeButton(
                                'CRUMBLING',
                                Icons.school,
                                SystemMode.crumbling,
                              ), // Mapping Train -> Crumbling
                              _buildModeButton(
                                'MAINT',
                                Icons.build,
                                SystemMode.maintenance,
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

                              // Validate Password
                              // In real app, hash this. Here simple comparison.
                              if (_passwordController.text !=
                                  _selectedPerson!.password) {
                                NotificationService.showError(
                                  'Invalid Password',
                                );
                                return;
                              }

                              // Success
                              NotificationService.showSuccess(
                                'Welcome ${_selectedPerson!.firstName}',
                              );
                              ref
                                  .read(authProvider.notifier)
                                  .login(_selectedPerson!, _selectedMode);
                              // No need to Navigator, LandingPage handles it
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent[700],
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              shadowColor: Colors.greenAccent.withOpacity(0.5),
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
                            _buildUsbStatus(ref),
                            // Sector Removed as requested
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

  Widget _buildUsbStatus(WidgetRef ref) {
    // Watch USB State (make sure to import com_service.dart)
    // Note: Since this method is inside State<LoginPage>, we can use 'ref' passed or access 'ref' if it was a ConsumerWidget,
    // but LoginPage is ConsumerStatefulWidget, so we have 'ref' available in the State class.
    // However, the build method doesn't pass 'ref' to helper usually unless we ask.
    // Let's use 'ref.watch' directly.

    // Need to import com_service.dart at top of file first!
    // I will add the method here and then fix imports.
    final usbState = ref.watch(comServiceProvider);

    // Check latency
    bool hasDataStream = false;
    if (usbState.lastDataReceived != null) {
      final diff = DateTime.now().difference(usbState.lastDataReceived!);
      if (diff.inSeconds < 2) {
        hasDataStream = true;
      }
    }

    final bool isActive = usbState.isConnected && hasDataStream;

    return Row(
      children: [
        Icon(
          Icons.usb,
          color: isActive ? Colors.greenAccent : Colors.white54,
          size: 14,
        ),
        const SizedBox(width: 4),
        const Text(
          'Connection to RS232 : ',
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
        Text(
          isActive ? 'Active' : 'Inactive',
          style: TextStyle(
            color: isActive ? Colors.greenAccent : Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.greenAccent : Colors.red,
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.6),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.greenAccent[400],
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildModeButton(String label, IconData icon, SystemMode mode) {
    final isSelected = _selectedMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedMode = mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.greenAccent[700] : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.black : Colors.white54,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.white54,
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
