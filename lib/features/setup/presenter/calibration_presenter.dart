import 'package:usb_serial/usb_serial.dart';
import '../../../core/protocol/protocol_service.dart';

class CalibrationPresenter {
  final ProtocolService _protocolService = ProtocolService();

  Future<void> setConfig(UsbPort port) async {
    await _protocolService.setConfig(port);
  }

  Future<void> setNormal(UsbPort port) async {
    await _protocolService.setNormal(port);
  }

  List<int> calibrateCommand({required double value1, required int mode}) {
    return _protocolService.calibrateCommand(value1: value1, mode: mode);
  }

  List<int> setParam(int value, int type) {
    return _protocolService.setParam(value, type);
  }
}
