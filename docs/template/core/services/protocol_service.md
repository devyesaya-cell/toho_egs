# Protocol Service
Path: `lib/core/protocol/protocol_service.dart`

The low-level packet builder responsible for constructing all outbound byte frames sent from the App (Tablet) to the MCU via USB/Serial. This is the **write** counterpart to `ComService` which handles the **read** (parsing) side.

## Dependencies
```dart
import 'dart:typed_data';
import 'package:usb_serial/usb_serial.dart';
import '../utils/parsing.dart';   // Parsing.parseToFloat_32, parseToUint_16
```

---

## 1. Singleton Pattern

```dart
class ProtocolService {
  static final ProtocolService _instance = ProtocolService._internal();

  factory ProtocolService() {
    return _instance;
  }

  ProtocolService._internal();
}
```
**Usage**: Always instantiate via `ProtocolService()` — returns the same singleton instance. Presenters hold a private reference:
```dart
final ProtocolService _protocolService = ProtocolService();
```

---

## 2. Frame Protocol (APP → MCU)

### Byte Layout
```
[0]  [1]  [2]  [3]  [4]       [5]      [6..N-3]     [N-2] [N-1]
0x55 0xAA 0x55 0xAA Length     OpCode   Payload       CRC_L CRC_H
```

| Index      | Field         | Size    | Description                                         |
|------------|---------------|---------|-----------------------------------------------------|
| `0-3`      | Magic Header  | 4 bytes | `[0x55, 0xAA, 0x55, 0xAA]` — sync bytes (Little-Endian of `0xAA55AA55`) |
| `4`        | Length        | 1 byte  | See length calculation below                        |
| `5`        | OpCode        | 1 byte  | Command identifier                                  |
| `6..N-3`   | Payload       | N bytes | Command-specific data                               |
| `N-2`      | CRC16 Low     | 1 byte  | `crc & 0xFF`                                        |
| `N-1`      | CRC16 High    | 1 byte  | `(crc >> 8) & 0xFF`                                 |

### Length Byte Calculation
```
Length = (includeOpcodeInLength ? 1 : 0) + payload.length + 2
```
- `includeOpcodeInLength`: defaults to `true` — most commands include the opcode byte in the length count.
- The `+2` accounts for the CRC16 footer.

### CRC16 Scope
The CRC is calculated over `[opcode, ...payload]` — it does **NOT** include the header or length byte.

---

## 3. `buildFrame()` — Core Frame Builder

```dart
List<int> buildFrame({
  required int opcode,
  required List<int> payload,
  bool includeOpcodeInLength = true,
}) {
  List<int> frame = [];

  // 1. Header
  frame.addAll([0x55, 0xAA, 0x55, 0xAA]);

  // 2. Length
  int length = (includeOpcodeInLength ? 1 : 0) + payload.length + 2;
  frame.add(length);

  // 3. Opcode + Payload
  List<int> crcData = [opcode, ...payload];
  frame.addAll(crcData);

  // 4. CRC16 (Little Endian)
  int crc = CRCCalculator.calculate(crcData);
  frame.add(crc & 0xff);         // Low byte
  frame.add((crc >> 8) & 0xff);  // High byte

  return frame;
}
```

**Returns**: `List<int>` — the complete byte frame ready to be written to `UsbPort`.

---

## 4. Command Functions

### `setNormal(UsbPort port)` — Switch MCU to Normal (Streaming) Mode
```dart
Future<void> setNormal(UsbPort port) async {
  final frame = buildFrame(opcode: 0x50, payload: [0x01]);
  await port.write(Uint8List.fromList(frame));
}
```
| Field    | Value  | Description                              |
|----------|--------|------------------------------------------|
| OpCode   | `0x50` | System Mode Command                      |
| Payload  | `[0x01]` | Mode = Normal (enable telemetry stream) |

**Called by**: `LandingPage` on boot, `CalibrationPresenter.setNormal()`.

---

### `setConfig(UsbPort port)` — Switch MCU to Config (Calibration) Mode
```dart
Future<void> setConfig(UsbPort port) async {
  final frame = buildFrame(opcode: 0x50, payload: [0x02]);
  await port.write(Uint8List.fromList(frame));
}
```
| Field    | Value  | Description                                |
|----------|--------|--------------------------------------------|
| OpCode   | `0x50` | System Mode Command                        |
| Payload  | `[0x02]` | Mode = Config (enable calibration stream) |

**Called by**: `CalibrationPresenter.setConfig()` when entering calibration pages.

---

### `calibrateCommand({double value1, int mode})` — Send Calibration Value
```dart
List<int> calibrateCommand({required double value1, required int mode}) {
  List<int> payload = [mode, ...Parsing.parseToFloat_32(value1)];
  return buildFrame(opcode: 0x52, payload: payload);
}
```
| Field     | Value       | Description                               |
|-----------|-------------|-------------------------------------------|
| OpCode    | `0x52`      | Calibration Command                       |
| Payload[0]| `mode`      | Calibration sub-command (1 byte)          |
| Payload[1-4]| Float32 LE| Calibration value (4 bytes)              |

**Returns**: `List<int>` frame — the caller is responsible for writing to port.

**Called by**: `CalibrationPresenter.calibrateCommand()` → used by calibration tabs (Body, Boom, Stick, Attachment) for setting pitch/roll/tilt offsets and reset operations.

---

### `setParam(int value, int type)` — Set Geometry/Configuration Parameter
```dart
List<int> setParam(int value, int type) {
  List<int> payload = [type, value & 0xff, (value >> 8) & 0xff];
  return buildFrame(opcode: 0x53, payload: payload);
}
```
| Field     | Value           | Description                              |
|-----------|-----------------|------------------------------------------|
| OpCode    | `0x53`          | Parameter Set Command                    |
| Payload[0]| `type`          | Parameter type ID (1 byte)               |
| Payload[1]| `value & 0xFF`  | Value low byte (Little Endian)           |
| Payload[2]| `(value >> 8) & 0xFF` | Value high byte (Little Endian)   |

**Value encoding**: 16-bit signed integer, manually split into Little-Endian byte pair.

**Returns**: `List<int>` frame — the caller writes to port.

**Called by**: `CalibrationPresenter.setParam()` → used by parameter cards in calibration pages (boom length, stick length, bucket width, antenna height, etc.).

---

### `setRadio(UsbPort port, {...})` — Configure LoRa Radio Parameters
```dart
Future<void> setRadio(
  UsbPort port, {
  required int channel,
  required int key,
  required int address,
  required int netID,
  required int airDataRate,
}) async {
  List<int> payload = [
    0x01,                          // Sub-command: SET
    channel,                       // 1 byte
    key & 0xff, (key >> 8) & 0xff,         // 2 bytes LE
    address & 0xff, (address >> 8) & 0xff, // 2 bytes LE
    netID,                         // 1 byte
    airDataRate,                   // 1 byte
  ];
  final frame = buildFrame(
    opcode: 0x0B,
    payload: payload,
    includeOpcodeInLength: true,
  );
  await port.write(Uint8List.fromList(frame));
}
```

| Field        | Offset in Payload | Size    | Description             |
|--------------|-------------------|---------|-------------------------|
| Sub-command  | 0                 | 1 byte  | `0x01` = SET            |
| Channel      | 1                 | 1 byte  | Radio channel number    |
| Key          | 2-3               | 2 bytes | Encryption key (LE)     |
| Address      | 4-5               | 2 bytes | Device address (LE)     |
| NetID        | 6                 | 1 byte  | Network identifier      |
| AirDataRate  | 7                 | 1 byte  | Transmission speed code |

| Frame Field | Value  |
|-------------|--------|
| OpCode      | `0x0B` |
| Total Payload | 8 bytes |

**Called by**: `RadioPresenter.setRadio()`.

---

### `getRadioConfig(UsbPort port)` — Request Current Radio Configuration
```dart
Future<void> getRadioConfig(UsbPort port) async {
  final frame = buildFrame(
    opcode: 0x0C,
    payload: [0x01],
    includeOpcodeInLength: true,
  );
  await port.write(Uint8List.fromList(frame));
}
```
| Field    | Value    | Description                                  |
|----------|----------|----------------------------------------------|
| OpCode   | `0x0C`   | Radio Config Request                         |
| Payload  | `[0x01]` | Sub-command: GET                             |

**Response**: MCU replies with OpCode `0x86` (parsed by `ComService._parseRadioConfig`).

**Called by**: `RadioPresenter.getRadioConfig()`.

---

## 5. CRC16 Calculator

Path: Same file, standalone class.

```dart
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
```

**Algorithm**: CRC-CCITT variant with initial value `0xFFFF`.

**Input**: `List<int>` — the bytes to checksum (opcode + payload, without header/length).

**Output**: `int` — 16-bit CRC value. Split into Little-Endian for transmission:
```dart
frame.add(crc & 0xff);         // Low byte first
frame.add((crc >> 8) & 0xff);  // High byte second
```

---

## 6. OpCode Summary Table (APP → MCU)

| OpCode | Command          | Payload Format                                                  | Write Method    |
|--------|------------------|-----------------------------------------------------------------|-----------------|
| `0x50` | Set System Mode  | `[0x01]` = Normal, `[0x02]` = Config                           | Direct to port  |
| `0x52` | Calibrate        | `[mode(1), float32_LE(4)]` → 5 bytes                           | Returns frame   |
| `0x53` | Set Parameter    | `[type(1), value_lo(1), value_hi(1)]` → 3 bytes                | Returns frame   |
| `0x0B` | Set Radio Config | `[0x01, ch(1), key_LE(2), addr_LE(2), netID(1), rate(1)]` → 8 bytes | Direct to port |
| `0x0C` | Get Radio Config | `[0x01]` → 1 byte                                              | Direct to port  |

> [!NOTE]
> Commands that write **directly to port** (`setNormal`, `setConfig`, `setRadio`, `getRadioConfig`) accept a `UsbPort` parameter and call `port.write()` internally.
> Commands that **return a frame** (`calibrateCommand`, `setParam`) return `List<int>` — the caller must write to the port themselves via `port.write(Uint8List.fromList(frame))`.

---

## 7. Presenter Integration

### `CalibrationPresenter`
Path: `lib/features/setup/presenter/calibration_presenter.dart`

Thin wrapper delegating all calls to `ProtocolService`:
```dart
class CalibrationPresenter {
  final ProtocolService _protocolService = ProtocolService();

  Future<void> setConfig(UsbPort port)  => _protocolService.setConfig(port);
  Future<void> setNormal(UsbPort port)  => _protocolService.setNormal(port);

  List<int> calibrateCommand({required double value1, required int mode})
      => _protocolService.calibrateCommand(value1: value1, mode: mode);

  List<int> setParam(int value, int type)
      => _protocolService.setParam(value, type);
}
```

### `RadioPresenter`
Path: `lib/features/setup/presenter/radio_presenter.dart`

Wrapper with null-safety guards on `UsbPort?`:
```dart
class RadioPresenter {
  final ProtocolService _protocolService = ProtocolService();

  Future<void> setRadio(UsbPort? port, {...}) async {
    if (port == null) return;
    await _protocolService.setRadio(port, channel: ..., key: ..., ...);
  }

  Future<void> getRadioConfig(UsbPort? port) async {
    if (port == null) return;
    await _protocolService.getRadioConfig(port);
  }
}
```

---

## 8. Communication Flow Diagram

```
┌──────────────┐     buildFrame()      ┌─────────────────┐     USB Serial      ┌──────┐
│  UI Widget   │ ──→ ProtocolService ──→ │ List<int> frame │ ──→ port.write() ──→ │ MCU  │
│  (via        │     (Singleton)        │ [55,AA,55,AA,..]│                      │      │
│  Presenter)  │                        └─────────────────┘                      │      │
└──────────────┘                                                                 │      │
                                                                                 │      │
┌──────────────┐     _parseXxx()        ┌─────────────────┐     USB Serial      │      │
│  Provider    │ ←── ComService    ←──── │ Transaction     │ ←── inputStream ←── │      │
│  (State)     │     (Notifier)         │ .magicHeader    │                      └──────┘
└──────────────┘                        └─────────────────┘
```

> [!IMPORTANT]
> The outbound header `[0x55, 0xAA, 0x55, 0xAA]` matches the inbound magic header used by `ComService`'s `Transaction.magicHeader`. Both directions use the same framing protocol with CRC16 validation.

> [!WARNING]
> `parseData(List<int> data)` is declared but not yet implemented (contains `// TODO`). All inbound parsing is handled by `ComService._startUsb()` instead. This method exists as a placeholder for future refactoring.
