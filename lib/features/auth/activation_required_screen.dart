import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/coms/com_service.dart';
import '../../core/state/activation_state.dart';
import '../../core/utils/app_theme.dart';

class ActivationRequiredScreen extends ConsumerStatefulWidget {
  const ActivationRequiredScreen({super.key});

  @override
  ConsumerState<ActivationRequiredScreen> createState() => _ActivationRequiredScreenState();
}

class _ActivationRequiredScreenState extends ConsumerState<ActivationRequiredScreen>
    with SingleTickerProviderStateMixin {
  Timer? _connectTimer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    // Pulse animation for network/scanning indicator
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Auto connection logic: retry connection to supervisor hotspot gateway IP
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoConnection();
    });
  }

  void _startAutoConnection() {
    _tryConnect();
    _connectTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      final usbState = ref.read(comServiceProvider);
      if (!usbState.isWsConnected && mounted) {
        _tryConnect();
      }
    });
  }

  Future<void> _tryConnect() async {
    try {
      await ref.read(comServiceProvider.notifier).connectToHostWebSocket();
    } catch (_) {}
  }

  @override
  void dispose() {
    _connectTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleWebSocketData(dynamic data) {
    if (data is Map<String, dynamic>) {
      final command = data['command'] ?? data['type'];
      
      if (data['status'] == 'pending_registration') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Device fingerprint saved locally. Awaiting online registration.'),
            backgroundColor: Colors.blue,
            duration: const Duration(seconds: 4),
          ),
        );
        return;
      }

      if (data['status'] == 'error') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Activation error occurred.'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
        return;
      }

      if (command == 'activate' || data['status'] == 'success') {
        final token = data['token'] as String?;
        final macAddress = data['mac_address'] as String?;
        final equipmentId = data['equipmentID'] as String?;

        if (token != null && token.isNotEmpty) {
          // Deactivate any active websocket connection first
          Future.microtask(() => ref.read(comServiceProvider.notifier).disconnectWebSocket());

          // Set activation state
          ref.read(activationProvider.notifier).setActivation(
            token: token,
            macAddress: macAddress ?? 'EGS-ACTIVATED',
            equipmentId: equipmentId ?? 'EGS-UNIT',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final activationState = ref.watch(activationProvider);
    final usbState = ref.watch(comServiceProvider);

    // Listen to WS data for incoming activation payload & connection transitions
    ref.listen<UsbState>(comServiceProvider, (previous, next) {
      // Trigger get_activation immediately upon connection
      if (next.isWsConnected && !(previous?.isWsConnected ?? false)) {
        final deviceId = ref.read(activationProvider).deviceId;
        final equipmentId = ref.read(activationProvider).activationData?.equipmentId ?? '';
        debugPrint("EGS: WebSocket connected. Sending get_activation for device: $deviceId");
        
        ref.read(comServiceProvider.notifier).sendDataToHost({
          'command': 'get_activation',
          'device_id': deviceId,
          'equipment_id': equipmentId,
        });
      }

      if (next.wsData != null && next.wsData != previous?.wsData) {
        _handleWebSocketData(next.wsData);
      }
    });

    final bool isConnected = usbState.isWsConnected;
    final Color statusColor = isConnected ? Colors.green : Colors.orange;

    return Scaffold(
      backgroundColor: theme.pageBackground,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('images/login_bg.jpeg', fit: BoxFit.cover),
          ),

          // Dark overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(theme.overlayOpacity + 0.2),
            ),
          ),

          // Main content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Container(
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
                constraints: const BoxConstraints(maxWidth: 580),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/logoToho.png', height: 40),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TOHO EGS',
                              style: TextStyle(
                                color: isDark ? Colors.white : const Color(0xFF3E2723),
                                fontSize: 22,
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
                    const SizedBox(height: 32),

                    // Lock Icon with breathing/pulsing animation
                    Center(
                      child: ScaleTransition(
                        scale: _pulseAnimation,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(color: statusColor.withOpacity(0.3), width: 2),
                          ),
                          child: Icon(
                            isConnected ? Icons.lock_open : Icons.lock,
                            size: 48,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      'ACTIVATION REQUIRED',
                      style: TextStyle(
                        color: theme.titleColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Please activate this EGS unit through the Supervisor App to continue.',
                      style: TextStyle(
                        color: theme.subtitleColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),

                    // Unique Build ID Panel
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.inputFill,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.inputBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'DEVICE ID / BUILD ID',
                            style: TextStyle(
                              color: theme.labelColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SelectableText(
                                  activationState.deviceId,
                                  style: TextStyle(
                                    color: theme.inputTextColor,
                                    fontFamily: 'Courier',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy, size: 20),
                                color: theme.inputIconColor,
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: activationState.deviceId));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Device ID copied to clipboard!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Connection Status indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: statusColor.withOpacity(0.5),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isConnected ? 'CONNECTED TO SUPERVISOR' : 'WAITING FOR WS CONNECTION...',
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Instruction details
                    Text(
                      'How to Activate:\n'
                      '1. Connect this tablet to the Supervisor App\'s Wi-Fi hotspot.\n'
                      '2. Open Supervisor App, input EGS Device ID above and register the unit.\n'
                      '3. The Supervisor App will transmit the activation key automatically.',
                      style: TextStyle(
                        color: theme.subtitleColor.withOpacity(0.8),
                        fontSize: 12,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _showManualActivationDialog,
                            icon: const Icon(Icons.keyboard_outlined, size: 18),
                            label: const Text('MANUAL CODE', style: TextStyle(fontWeight: FontWeight.bold)),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: theme.titleColor,
                              side: BorderSide(color: theme.inputBorder),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _tryConnect,
                            icon: const Icon(Icons.refresh, size: 18),
                            label: const Text('RETRY CONNECT', style: TextStyle(fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryButtonBackground,
                              foregroundColor: theme.primaryButtonText,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showManualActivationDialog() {
    final theme = AppTheme.of(context);
    final tokenController = TextEditingController();
    final equipmentIdController = TextEditingController();
    final deviceIdController = TextEditingController(text: ref.read(activationProvider).deviceId);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.dialogBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'MANUAL ACTIVATION',
          style: TextStyle(color: theme.textOnSurface, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter activation details manually if automated sync is unavailable.',
                style: TextStyle(color: theme.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: 16),
              
              // Device ID Read-Only
              TextField(
                controller: deviceIdController,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'DEVICE ID',
                  labelStyle: TextStyle(color: theme.labelColor, fontSize: 11),
                  filled: true,
                  fillColor: theme.pageBackground,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),

              // Equipment ID
              TextField(
                controller: equipmentIdController,
                style: TextStyle(color: theme.textOnSurface),
                decoration: InputDecoration(
                  labelText: 'EQUIPMENT ID',
                  labelStyle: TextStyle(color: theme.labelColor, fontSize: 11),
                  hintText: 'e.g., EXCAVATOR-01',
                  hintStyle: TextStyle(color: theme.textSecondary.withOpacity(0.5)),
                  filled: true,
                  fillColor: theme.inputFill,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 12),

              // Token
              TextField(
                controller: tokenController,
                maxLines: 2,
                style: TextStyle(color: theme.textOnSurface),
                decoration: InputDecoration(
                  labelText: 'ACTIVATION TOKEN',
                  labelStyle: TextStyle(color: theme.labelColor, fontSize: 11),
                  hintText: 'Paste activation token code',
                  hintStyle: TextStyle(color: theme.textSecondary.withOpacity(0.5)),
                  filled: true,
                  fillColor: theme.inputFill,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL', style: TextStyle(color: theme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              final token = tokenController.text.trim();
              final equipId = equipmentIdController.text.trim();
              final deviceId = deviceIdController.text.trim();

              if (token.isEmpty || equipId.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all fields.'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              ref.read(activationProvider.notifier).setActivation(
                token: token,
                macAddress: deviceId,
                equipmentId: equipId,
              );

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Device Activated Manually!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2ECC71),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('ACTIVATE'),
          ),
        ],
      ),
    );
  }
}
