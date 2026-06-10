import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/state/activation_state.dart';
import '../../../core/utils/app_theme.dart';
import '../../../core/widgets/global_app_bar_actions.dart';

class ActivationPage extends ConsumerWidget {
  const ActivationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final activationState = ref.watch(activationProvider);

    final isActivated = activationState.isActivated;
    final data = activationState.activationData;
    final deviceId = activationState.deviceId;

    final String statusText = isActivated ? 'ACTIVATED' : 'NOT ACTIVATED';
    final Color statusColor = isActivated ? const Color(0xFF2ECC71) : Colors.redAccent;
    final DateFormat formatter = DateFormat('dd MMM yyyy • HH:mm:ss');

    return Scaffold(
      backgroundColor: theme.pageBackground,
      appBar: AppBar(
        title: Text('ACTIVATION STATUS', style: TextStyle(color: theme.appBarForeground)),
        backgroundColor: theme.appBarBackground,
        iconTheme: IconThemeData(color: theme.appBarForeground),
        actions: const [GlobalAppBarActions(), SizedBox(width: 16)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            decoration: BoxDecoration(
              color: theme.cardSurface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: theme.cardBorderColor, width: 1),
            ),
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Status Indicator
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            statusText,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      isActivated ? Icons.verified : Icons.warning_amber_rounded,
                      color: statusColor,
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Divider(color: theme.dividerColor),
                const SizedBox(height: 16),

                // Device ID / Build ID
                _buildInfoRow(
                  context,
                  theme,
                  'Device ID / Build ID',
                  deviceId,
                  canCopy: true,
                ),
                const SizedBox(height: 16),

                // Equipment ID
                _buildInfoRow(
                  context,
                  theme,
                  'Equipment ID',
                  isActivated ? (data?.equipmentId ?? 'N/A') : 'Unit is not activated',
                ),
                const SizedBox(height: 16),

                // Activation Token
                _buildInfoRow(
                  context,
                  theme,
                  'Activation Token',
                  isActivated ? (data?.token ?? 'N/A') : 'N/A',
                  canCopy: isActivated,
                ),
                const SizedBox(height: 16),

                // Last Update
                _buildInfoRow(
                  context,
                  theme,
                  'Last Activated / Checked',
                  isActivated && data?.lastUpdate != null
                      ? formatter.format(data!.lastUpdate!)
                      : 'Never',
                ),
                const SizedBox(height: 32),

                // Action Buttons
                if (isActivated) ...[
                  ElevatedButton.icon(
                    onPressed: () => _confirmDeactivation(context, ref, theme),
                    icon: const Icon(Icons.lock_reset, size: 20),
                    label: const Text('DEACTIVATE MACHINE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ] else ...[
                  Text(
                    'To activate this machine, connect to a Supervisor WebSocket host from the main screen or input the credentials manually on system startup.',
                    style: TextStyle(
                      color: theme.textSecondary,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    AppThemeData theme,
    String label,
    String value, {
    bool canCopy = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: theme.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SelectableText(
                value,
                style: TextStyle(
                  color: theme.textOnSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: canCopy ? 'Courier' : null,
                ),
              ),
            ),
            if (canCopy && value != 'Loading...')
              IconButton(
                icon: const Icon(Icons.copy, size: 18),
                color: theme.textSecondary,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: value));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$label copied to clipboard!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
          ],
        ),
      ],
    );
  }

  void _confirmDeactivation(BuildContext context, WidgetRef ref, AppThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.dialogBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'DEACTIVATE THIS MACHINE?',
          style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: Text(
          'This will clear the activation token and lock the machine immediately. You will need to re-activate the EGS unit before any future operation.',
          style: TextStyle(color: theme.textOnSurface, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('CANCEL', style: TextStyle(color: theme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Pop ActivationPage back to SetupPage (which gets immediately locked out by LandingPage)

              // Call deactivate in notifier
              await ref.read(activationProvider.notifier).deactivate();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('DEACTIVATE'),
          ),
        ],
      ),
    );
  }
}
