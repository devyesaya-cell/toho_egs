import 'dart:typed_data';
import 'package:usb_serial/usb_serial.dart';
import '../utils/parsing.dart';

class ProtocolService {
  // Singleton pattern
  static final ProtocolService _instance = ProtocolService._internal();

  factory ProtocolService() {
    return _instance;
  }

  ProtocolService._internal();

  void parseData(List<int> data) {
    // TODO: Implement protocol parsing logic
  }

  /// Builds a complete data frame according to the APP -> MCU protocol:
  /// Header (4 bytes) | Length (1 byte) | Opcode (1 byte) | Payload (N bytes) | CRC16 (2 bytes)
  List<int> buildFrame({
    required int opcode,
    required List<int> payload,
    bool includeOpcodeInLength = true,
  }) {
    List<int> frame = [];

    // 1. Header: 0xAA55AA55 -> [0x55, 0xAA, 0x55, 0xAA] (Little-Endian matches ComService)
    frame.addAll([0x55, 0xAA, 0x55, 0xAA]);

    // 2. Length: (Opcode(1)?) + Payload Length (N) + CRC16 (2)
    int length = (includeOpcodeInLength ? 1 : 0) + payload.length + 2;
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
    final frame = buildFrame(opcode: 0x50, payload: [0x02]);
    await port.write(Uint8List.fromList(frame));
  }

  Future<void> setNormal(UsbPort port) async {
    // Opcode: 0x50, Payload: [0x01, 0x01]
    final frame = buildFrame(opcode: 0x50, payload: [0x01]);
    await port.write(Uint8List.fromList(frame));
  }

  List<int> calibrateCommand({required double value1, required int mode}) {
    // Opcode: 0x52
    // Payload: Command/mode (1 byte) + Value (4 bytes Float32)
    List<int> payload = [mode, ...Parsing.parseToFloat_32(value1)];
    return buildFrame(opcode: 0x52, payload: payload);
  }

  List<int> setParam(int value, int type) {
    // Opcode: 0x53
    // Payload: Type (1 byte) + Length/Value (2 bytes int16_t, Little Endian)
    List<int> payload = [type, value & 0xff, (value >> 8) & 0xff];
    return buildFrame(opcode: 0x53, payload: payload);
  }

  Future<void> setRadio(
    UsbPort port, {
    required int channel,
    required int key,
    required int address,
    required int netID,
    required int airDataRate,
  }) async {
    // Opcode: 0x0B (SET)
    // Payload: Channel (1), Key (2), Address (2), NetID (1), Air Data Rate (1)
    List<int> payload = [
      channel,
      key & 0xff,
      (key >> 8) & 0xff,
      address & 0xff,
      (address >> 8) & 0xff,
      netID,
      airDataRate,
    ];
    // Spreadsheet explicitly requires Length = Payload + CRC (doesn't include opcode length)
    final frame = buildFrame(
      opcode: 0x0B,
      payload: payload,
      includeOpcodeInLength: false,
    );
    await port.write(Uint8List.fromList(frame));
  }

  Future<void> getRadioConfig(UsbPort port) async {
    // Opcode: 0x05 (GET)
    // Payload: None
    // Spreadsheet example says Length is 2 (0 target + 2 CRC)
    final frame = buildFrame(
      opcode: 0x0C,
      payload: [],
      includeOpcodeInLength: false,
    );
    await port.write(Uint8List.fromList(frame));
  }
}

class CRCCalculator {
  static int calculate(List<int> list) {
    int crc = 0xffff;
    for (int i = 0; i < list.length; i++) {
      crc = ((crc >> 8) & 0xff) | ((crc << 8) & 0xff00);
      crc ^= list[i];
      crc ^= ((crc & 0xff) >> 4) & 0xff;
      crc ^= ((crc << 8) << 4) & 0xff00;
      crc ^= ((crc & 0xff) << 4) << 1;
    }
    return crc;
  }
}
