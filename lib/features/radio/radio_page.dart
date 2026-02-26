import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/coms/com_service.dart';
import '../../core/models/radio_config.dart';
import '../../core/widgets/global_app_bar_actions.dart';
import 'presenter/radio_presenter.dart';

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
    final radioAsync = ref.watch(radioStreamProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1410),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1410),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            // Green Icon Box
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A2A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.radio,
                color: Color(0xFF2ECC71),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Titles
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RADIO CONFIG',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'EGS RADIO V4.0.0',
                  style: TextStyle(
                    color: Color(0xFF2ECC71), // Primary Green
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
                  // Top left: Image placeholder
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'images/under_cons.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Bottom left: Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          _showSaveDialog(context, radioAsync.value),
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
                        backgroundColor: const Color(0xFF2ECC71),
                        foregroundColor: Colors.white,
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
                color: const Color(0xFF1E293B), // Dark blueish tint
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF2ECC71).withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
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
                      const Icon(
                        Icons.sensors,
                        color: Color(0xFF2ECC71),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'RADIO PARAMETERS PREVIEW',
                        style: TextStyle(
                          color: Colors.white,
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
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text(
                          //       'Requesting radio configuration...',
                          //     ),
                          //     backgroundColor: Color(0xFF2ECC71),
                          //     duration: Duration(seconds: 1),
                          //   ),
                          // );
                        },
                        icon: const Icon(Icons.refresh, color: Colors.white70),
                        tooltip: 'Request config from device',
                      ),
                      const SizedBox(width: 8),
                      if (radioAsync.hasValue)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2ECC71).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'LIVE',
                            style: TextStyle(
                              color: Color(0xFF2ECC71),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white12,
                    height: 48,
                    thickness: 1,
                  ),
                  Expanded(
                    child: radioAsync.when(
                      data: (config) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildConfigItem(
                                'Channel',
                                config.channel.toString(),
                                Icons.tune,
                              ),
                              _buildConfigItem(
                                'Key',
                                '0x${config.key.toRadixString(16).padLeft(4, '0').toUpperCase()}',
                                Icons.vpn_key,
                              ),
                              _buildConfigItem(
                                'Address',
                                '0x${config.address.toRadixString(16).padLeft(4, '0').toUpperCase()}',
                                Icons.location_on,
                              ),
                              _buildConfigItem(
                                'Net ID',
                                config.netID.toString(),
                                Icons.router,
                              ),
                              _buildConfigItem(
                                'Air Data Rate',
                                config.airDataRate.toString(),
                                Icons.speed,
                              ),
                              _buildConfigItem(
                                'Last Update',
                                _formatTime(config.lastUpdate),
                                Icons.access_time,
                              ),
                            ],
                          ),
                        );
                      },
                      loading: () => const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.wifi_off,
                              size: 48,
                              color: Colors.white24,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Waiting for radio data stream...',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      error: (err, stack) => Center(
                        child: Text(
                          'Error loading stream: $err',
                          style: const TextStyle(color: Colors.red),
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
    );
  }

  Widget _buildConfigItem(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 24),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
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

  void _showSaveDialog(BuildContext context, RadioConfig? currentConfig) {
    final channelCtrl = TextEditingController(
      text: currentConfig?.channel.toString() ?? '86',
    );
    // Using decimal representations in textfields, or hex based on preference. Let's stick to int.
    final keyCtrl = TextEditingController(
      text: currentConfig?.key.toString() ?? '513',
    ); // 0x0201
    final addressCtrl = TextEditingController(
      text: currentConfig?.address.toString() ?? '0',
    );
    final netIDCtrl = TextEditingController(
      text: currentConfig?.netID.toString() ?? '0',
    );
    final airDataRateCtrl = TextEditingController(
      text: currentConfig?.airDataRate.toString() ?? '3',
    );

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Set Radio Configurations',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputField('Channel', channelCtrl),
                _buildInputField(
                  'Key (Decimal)',
                  keyCtrl,
                ), // Or Hex if parsed differently, using decimal for simplicity
                _buildInputField('Address (Decimal)', addressCtrl),
                _buildInputField('Net ID', netIDCtrl),
                _buildInputField('Air Data Rate', airDataRateCtrl),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(
                'CANCEL',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2ECC71),
                foregroundColor: Colors.white,
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
                    const SnackBar(
                      content: Text('Radio configuration sent!'),
                      backgroundColor: Color(0xFF2ECC71),
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

  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white54),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white24),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF2ECC71)),
          ),
        ),
      ),
    );
  }
}
