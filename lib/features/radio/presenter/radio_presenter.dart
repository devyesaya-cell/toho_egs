import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';
import '../../../core/protocol/protocol_service.dart';

class RadioPresenter {
  final ProtocolService _protocolService = ProtocolService();

  Future<void> setRadio(
    UsbPort? port, {
    required int channel,
    required int key,
    required int address,
    required int netID,
    required int airDataRate,
  }) async {
    if (port == null) {
      debugPrint("Cannot set radio, port is null.");
      return;
    }
    try {
      await _protocolService.setRadio(
        port,
        channel: channel,
        key: key,
        address: address,
        netID: netID,
        airDataRate: airDataRate,
      );
      debugPrint("Radio configuration sent successfully.");
    } catch (e) {
      debugPrint("Error sending radio configuration: $e");
    }
  }

  Future<void> getRadioConfig(UsbPort? port) async {
    if (port == null) {
      debugPrint("Cannot get radio config, port is null.");
      return;
    }
    try {
      await _protocolService.getRadioConfig(port);
      debugPrint("Radio configuration request sent successfully.");
    } catch (e) {
      debugPrint("Error requesting radio configuration: $e");
    }
  }
}
