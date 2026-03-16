import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/coms/com_service.dart';
import '../../../core/models/radio_config.dart';
import '../../../core/widgets/global_app_bar_actions.dart';
import '../presenter/radio_presenter.dart';
import '../../../core/utils/app_theme.dart';

class RadioPage extends ConsumerStatefulWidget {
  const RadioPage({super.key});

  @override
  ConsumerState<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends ConsumerState<RadioPage> {
  final RadioPresenter _presenter = RadioPresenter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final usbState = ref.read(comServiceProvider);
      if (usbState.port != null) {
        _presenter.getRadioConfig(usbState.port);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final radioData = ref.watch(radioProvider);

    return Scaffold(
      backgroundColor: theme.pageBackground,
      appBar: AppBar(
        backgroundColor: theme.appBarBackground,
        foregroundColor: theme.appBarForeground,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.iconBoxBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.radio, color: theme.iconBoxIcon, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RADIO CONFIG',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 18,
                    color: theme.appBarForeground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'EGS RADIO V4.0.0',
                  style: TextStyle(
                    color: theme.appBarAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: const [GlobalAppBarActions(), SizedBox(width: 16)],
      ),
      body: Row(
        children: [
          // LEFT SIDE
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'images/under_cons.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton.icon(
                      onPressed: () => _showSaveDialog(context, radioData, theme),
                      icon: const Icon(Icons.save, size: 28),
                      label: const Text(
                        'SAVE CONFIG',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryButtonBackground,
                        foregroundColor: theme.primaryButtonText,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // RIGHT SIDE
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(32.0),
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: theme.cardSurface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: theme.appBarAccent.withValues(alpha: 0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.sensors, color: theme.appBarAccent, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'RADIO PARAMETERS PREVIEW',
                        style: TextStyle(
                          color: theme.textOnSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          final port = ref.read(comServiceProvider).port;
                          _presenter.getRadioConfig(port);
                        },
                        icon: Icon(Icons.refresh, color: theme.textSecondary),
                        tooltip: 'Request config from device',
                      ),
                      const SizedBox(width: 8),
                      if (radioData != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.appBarAccent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'LIVE',
                            style: TextStyle(
                              color: theme.appBarAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Divider(
                    color: theme.dividerColor,
                    height: 48,
                    thickness: 1,
                  ),
                  Expanded(
                    child: radioData != null
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildConfigItem(theme, 'Channel',
                                    radioData.channel.toString(), Icons.tune),
                                _buildConfigItem(
                                    theme,
                                    'Key',
                                    '0x${radioData.key.toRadixString(16).padLeft(4, '0').toUpperCase()}',
                                    Icons.vpn_key),
                                _buildConfigItem(
                                    theme,
                                    'Address',
                                    '0x${radioData.address.toRadixString(16).padLeft(4, '0').toUpperCase()}',
                                    Icons.location_on),
                                _buildConfigItem(theme, 'Net ID',
                                    radioData.netID.toString(), Icons.router),
                                _buildConfigItem(
                                    theme,
                                    'Air Data Rate',
                                    radioData.airDataRate.toString(),
                                    Icons.speed),
                                _buildConfigItem(theme, 'Last Update',
                                    _formatTime(radioData.lastUpdate),
                                    Icons.access_time),
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.wifi_off,
                                    size: 48, color: theme.textSecondary),
                                const SizedBox(height: 16),
                                Text(
                                  'Waiting for radio data stream...',
                                  style: TextStyle(
                                    color: theme.textSecondary,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
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

  Widget _buildConfigItem(
      AppThemeData theme, String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.pageBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.cardBorderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.textSecondary, size: 24),
          const SizedBox(width: 16),
          Text(label, style: TextStyle(color: theme.textSecondary, fontSize: 16)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: theme.textOnSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int epochMs) {
    final dt = DateTime.fromMillisecondsSinceEpoch(epochMs);
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  void _showSaveDialog(
      BuildContext context, RadioConfig? currentConfig, AppThemeData theme) {
    final channelCtrl =
        TextEditingController(text: currentConfig?.channel.toString() ?? '86');
    final keyCtrl =
        TextEditingController(text: currentConfig?.key.toString() ?? '513');
    final addressCtrl =
        TextEditingController(text: currentConfig?.address.toString() ?? '0');
    final netIDCtrl =
        TextEditingController(text: currentConfig?.netID.toString() ?? '0');
    final airDataRateCtrl = TextEditingController(
        text: currentConfig?.airDataRate.toString() ?? '3');

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: theme.dialogBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Set Radio Configurations',
            style: TextStyle(
                color: theme.textOnSurface, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputField(theme, 'Channel', channelCtrl),
                _buildInputField(theme, 'Key (Decimal)', keyCtrl),
                _buildInputField(theme, 'Address (Decimal)', addressCtrl),
                _buildInputField(theme, 'Net ID', netIDCtrl),
                _buildInputField(theme, 'Air Data Rate', airDataRateCtrl),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('CANCEL',
                  style: TextStyle(color: theme.textSecondary)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryButtonBackground,
                foregroundColor: theme.primaryButtonText,
              ),
              onPressed: () async {
                final channel = int.tryParse(channelCtrl.text) ?? 86;
                final key = int.tryParse(keyCtrl.text) ?? 513;
                final address = int.tryParse(addressCtrl.text) ?? 0;
                final netID = int.tryParse(netIDCtrl.text) ?? 0;
                final airDataRate = int.tryParse(airDataRateCtrl.text) ?? 3;
                final port = ref.read(comServiceProvider).port;

                await _presenter.setRadio(
                  port,
                  channel: channel,
                  key: key,
                  address: address,
                  netID: netID,
                  airDataRate: airDataRate,
                );

                if (ctx.mounted) {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Radio configuration sent!'),
                      backgroundColor: theme.appBarAccent,
                    ),
                  );
                }
              },
              child: const Text(
                'SET CONFIG',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputField(
      AppThemeData theme, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: theme.inputTextColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: theme.textSecondary),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.inputBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.inputFocusedBorder),
          ),
          filled: true,
          fillColor: theme.inputFill,
        ),
      ),
    );
  }
}
