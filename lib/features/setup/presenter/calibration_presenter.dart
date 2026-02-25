import 'dart:typed_data';
import 'package:usb_serial/usb_serial.dart';
import '../../../core/protocol/protocol_service.dart';
import '../../../core/utils/parsing.dart';

class CalibrationPresenter {
  /// Builds a complete data frame according to the APP -> MCU protocol:
  /// Header (4 bytes) | Length (1 byte) | Opcode (1 byte) | Payload (N bytes) | CRC16 (2 bytes)
  List<int> _buildFrame({required int opcode, required List<int> payload}) {
    List<int> frame = [];

    // 1. Header: 0xAA55AA55 -> [0x55, 0xAA, 0x55, 0xAA] (Little-Endian matches ComService)
    frame.addAll([0x55, 0xAA, 0x55, 0xAA]);
    // frame.addAll([0x01]);

    // 2. Length: Opcode (1) + Payload Length (N) + CRC16 (2)
    int length = 1 + payload.length + 2;
    frame.add(length);

    // 3. Prepare data for CRC (Opcode + Payload)
    List<int> crcData = [opcode, ...payload];
    frame.addAll(crcData);

    // 4. Calculate CRC16 and Append (Little Endian)
    int crc = CRCCalculator.calculate(crcData);
    frame.add(crc & 0xff); // Low Byte
    frame.add((crc >> 8) & 0xff); // High Byte

    return frame;
  }

  Future<void> setConfig(UsbPort port) async {
    // Opcode: 0x50, Payload: [0x01, 0x02] (Assuming this matches the structure)
    final frame = _buildFrame(opcode: 0x50, payload: [0x02]);
    await port.write(Uint8List.fromList(frame));
  }

  Future<void> setNormal(UsbPort port) async {
    // Opcode: 0x50, Payload: [0x01, 0x01]
    final frame = _buildFrame(opcode: 0x50, payload: [0x01]);
    await port.write(Uint8List.fromList(frame));
  }

  List<int> calibrateCommand({required double value1, required int mode}) {
    // Opcode: 0x52
    // Payload: Command/mode (1 byte) + Value (4 bytes Float32)
    List<int> payload = [mode, ...Parsing.parseToFloat_32(value1)];
    return _buildFrame(opcode: 0x52, payload: payload);
  }

  List<int> setParam(int value, int type) {
    // Opcode: 0x53
    // Payload: Type (1 byte) + Length/Value (2 bytes int16_t, Little Endian)
    List<int> payload = [type, value & 0xff, (value >> 8) & 0xff];
    return _buildFrame(opcode: 0x53, payload: payload);
  }
}
