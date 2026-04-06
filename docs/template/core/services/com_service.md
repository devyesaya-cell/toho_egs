# RS232 Communication Service
Path: `lib/core/coms/com_service.dart`

The central hub for all hardware communication (USB/Serial) and WebSocket synchronization. This single file manages the USB connection lifecycle, binary packet parsing for every opcode, WebSocket client connections, and exposes all parsed data through Riverpod providers.

## Dependencies
```dart
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/base_status.dart';
import '../models/calibration_data.dart';
import '../models/error_alert.dart';
import '../models/gps_loc.dart';
import '../models/radio_config.dart';
import '../models/send_acknowledge.dart';
import '../utils/parsing.dart';
import '../services/notification_service.dart' as simple_notif;
```

### Required Packages (`pubspec.yaml`)
```yaml
dependencies:
  usb_serial: ^0.5.1
  web_socket_channel: ^3.0.1
```

---

## 1. UsbState (State Class)

Immutable state object holding all communication state. Used by `comServiceProvider`.

```dart
class UsbState {
  final bool isConnected;         // USB serial port is open
  final UsbPort? port;            // Active serial port handle
  final List<UsbDevice> devices;  // All detected USB devices
  final DateTime? lastDataReceived; // Timestamp of last raw data (for liveness check)
  final bool diggingStatus;       // Set true when 0xD2 received

  // WebSocket / Sync state
  final bool isWsConnected;      // WebSocket channel is active
  final String? wsAddress;       // Current WebSocket URL
  final dynamic wsData;          // Last received WebSocket payload (decoded JSON or raw String)
}
```

### `copyWith` Method
All fields support immutable updates via `copyWith(...)`. Non-specified fields retain their previous values.

### Default Values
```dart
UsbState({
  this.isConnected = false,
  this.port,
  this.devices = const [],
  this.lastDataReceived,
  this.diggingStatus = false,
  this.isWsConnected = false,
  this.wsAddress,
  this.wsData,
});
```

---

## 2. ComService (Riverpod Notifier)

```dart
class ComService extends Notifier<UsbState> { ... }
```

### Internal Members

| Member               | Type                                    | Purpose                                  |
|----------------------|-----------------------------------------|------------------------------------------|
| `_gpsController`     | `StreamController<GPSLoc>.broadcast()`  | Emits parsed GPS frames                  |
| `_calibController`   | `StreamController<CalibrationData>.broadcast()` | Emits parsed calibration frames  |
| `_txn`               | `Transaction<Uint8List>?`               | Magic-header framing transaction         |
| `_txnSub`            | `StreamSubscription<Uint8List>?`        | Subscription to framed packet stream     |
| `_usbEventSub`       | `StreamSubscription<UsbEvent>?`         | Listens for USB attach/detach events     |
| `_wsChannel`          | `WebSocketChannel?`                    | Active WebSocket channel                 |
| `_wsSubscription`    | `StreamSubscription?`                   | Subscription to WebSocket data stream    |

### Stream Getters
```dart
Stream<GPSLoc> get gpsStream => _gpsController.stream;
Stream<CalibrationData> get calibStream => _calibController.stream;
```

### `build()` — Initialization
```dart
@override
UsbState build() {
  // Listen for USB attach/detach events
  _usbEventSub = UsbSerial.usbEventStream?.listen((UsbEvent event) {
    if (event.event == UsbEvent.ACTION_USB_DETACHED) {
      disconnect();
    } else if (event.event == UsbEvent.ACTION_USB_ATTACHED) {
      autoConnect("CP2102N");
    }
  });

  ref.onDispose(() {
    _usbEventSub?.cancel();
    disconnectWebSocket();
  });

  return UsbState();
}
```

**Key behavior**:
- Automatically listens for USB hot-plug events on provider creation.
- On USB detach → calls `disconnect()`.
- On USB attach → calls `autoConnect("CP2102N")` to re-establish connection.
- On provider dispose → cancels USB event listener + disconnects WebSocket.

---

## 3. Device Management Functions

### `listDevices()`
```dart
Future<void> listDevices() async {
  List<UsbDevice> devices = await UsbSerial.listDevices();
  state = state.copyWith(devices: devices);
}
```
Populates `state.devices` with all currently connected USB devices.

### `connectToDevice(UsbDevice device)`
```dart
Future<bool> connectToDevice(UsbDevice device) async {
  var port = await device.create();
  if (port == null) return false;

  bool openResult = await port.open();
  if (!openResult) return false;

  await port.setDTR(true);
  await port.setRTS(true);
  await port.setPortParameters(
    115200,                  // Baud rate
    UsbPort.DATABITS_8,      // Data bits
    UsbPort.STOPBITS_1,      // Stop bits
    UsbPort.PARITY_NONE,     // Parity
  );

  state = state.copyWith(port: port, isConnected: true);
  await _startUsb(port);
  return true;
}
```

**Serial Configuration:**
| Parameter   | Value               |
|-------------|---------------------|
| Baud Rate   | `115200`            |
| Data Bits   | `8`                 |
| Stop Bits   | `1`                 |
| Parity      | `None`              |
| DTR         | `true`              |
| RTS         | `true`              |

### `disconnect()`
```dart
Future<void> disconnect() async {
  await _stopUsb();          // Cancel transaction subscription + dispose
  state.port?.close();       // Close physical port
  state = state.copyWith(port: null, isConnected: false);
}
```

### `autoConnect(String filterName)`
```dart
Future<void> autoConnect(String filterName) async {
  await listDevices();
  for (var device in state.devices) {
    if (device.productName != null &&
        device.productName!.contains(filterName)) {
      await connectToDevice(device);
      return; // Connect to FIRST match only
    }
  }
}
```
Scans all USB devices, finds the first whose `productName` contains `filterName` (typically `"CP2102N"`), and connects to it.

### `resetDiggingStatus()`
```dart
void resetDiggingStatus() {
  state = state.copyWith(diggingStatus: false);
}
```
Called by the MapPage after processing a digging event to reset the flag.

---

## 4. Internal Stream Handling

### `_startUsb(UsbPort port)`

Sets up the data pipeline from raw USB bytes to parsed domain objects.

#### Step 1: Raw Stream with Liveness Tracking
```dart
final Stream<Uint8List> rawStream = port.inputStream!.map((data) {
  final now = DateTime.now();
  // Throttled update — only if >500ms since last update
  if (state.lastDataReceived == null ||
      now.difference(state.lastDataReceived!).inMilliseconds > 500) {
    Future.microtask(() {
      state = state.copyWith(lastDataReceived: now);
    });
  }
  return data;
});
```
**Critical**: The `lastDataReceived` update uses `Future.microtask()` to avoid modifying state inside a stream transform synchronously (which would violate Riverpod lifecycle rules). The 500ms throttle prevents excessive state rebuilds.

#### Step 2: Magic Header Framing
```dart
_txn = Transaction.magicHeader(rawStream, [85, 170, 85, 170], maxLen: 200);
// Header bytes: 0x55, 0xAA, 0x55, 0xAA → [85, 170, 85, 170]
// maxLen: 200 bytes maximum packet size
```

#### Step 3: OpCode Dispatch
```dart
_txnSub = _txn!.stream.listen((Uint8List framed) {
  final packet = framed.toList();
  if (packet.length < 6) return; // Minimum validation

  final opcode = packet[5]; // OpCode is always at index 5

  // Dispatch to parser by opcode...
});
```

**Error/Done handlers:**
```dart
onError: (e) { disconnect(); }
onDone: ()  { disconnect(); }
```
Both trigger a full disconnect on stream interruption.

### `_stopUsb()`
```dart
Future<void> _stopUsb() async {
  await _txnSub?.cancel();
  _txnSub = null;
  _txn?.dispose();
  _txn = null;
}
```

---

## 5. Packet Framing Protocol

### Byte Layout
```
[0]  [1]  [2]  [3]  [4]     [5]      [6..N-3]     [N-2][N-1]
0x55 0xAA 0x55 0xAA Length   OpCode   Payload       CRC16 (LE)
```

| Index    | Field       | Description                                  |
|----------|-------------|----------------------------------------------|
| `0-3`    | Magic Header| `0x55, 0xAA, 0x55, 0xAA` — fixed sync bytes |
| `4`      | Length      | Total payload length byte                    |
| `5`      | OpCode      | Command/data identifier                      |
| `6..N-3` | Payload     | Variable-length data (opcode-specific)       |
| `N-2..N-1`| CRC16     | Little-endian CRC-16 checksum               |

---

## 6. OpCode Dispatch Table

| OpCode | Name              | Parser Method              | Output Target                   |
|--------|-------------------|----------------------------|---------------------------------|
| `0xD0` | GPS Telemetry     | `_parseGPSLoc(packet)`     | `_gpsController.add(gps)`       |
| `0xD1` | Calibration Data  | `_parseCalibrationData(packet)` | `_calibController.add(calib)` |
| `0xD2` | Digging Status    | *(no parser — flag only)*  | `state.diggingStatus = true`    |
| `0xD3` | Base Station Status | `_parseBasestatus(packet)` | `ref.read(bsProvider.notifier).updateState(bs)` |
| `0x81` | Send Acknowledge  | `_parseSendAcknowledge(packet)` | `NotificationService.showSuccess/showError` |
| `0x83` | Error Alert       | `_parseErrorAlert(packet)` | `ref.read(errorProvider.notifier).updateState(error)` |
| `0x86` | Radio Config      | `_parseRadioConfig(packet)` | `ref.read(radioProvider.notifier).updateState(config)` |

---

## 7. Parser Functions — Complete Byte Mapping

### `_parseGPSLoc(List<int> socketData)` → `GPSLoc` (OpCode 0xD0)

| Offset   | Field          | Dart Type    | Parse Method                          | Scale         |
|----------|----------------|-------------|---------------------------------------|---------------|
| `06-09`  | `bsDistance`   | `int`       | `Parsing.parseFromUint_32`            | 1 (mm)        |
| `10-13`  | `pitch`        | `double`    | `Parsing.parseFromFloat_32`           | 1             |
| `14-17`  | `roll`         | `double`    | `Parsing.parseFromFloat_32`           | 1             |
| `18-21`  | `boomTilt`     | `double`    | `Parsing.parseFromFloat_32`           | 1             |
| `22-25`  | `stickTilt`    | `double`    | `Parsing.parseFromFloat_32`           | 1             |
| `26-29`  | `attachTilt`   | `double`    | `Parsing.parseFromFloat_32`           | 1             |
| `30-33`  | `heading`      | `double`    | `Parsing.parseFromFloat_32`           | 1             |
| `34-37`  | `mcuVoltage`   | `double`    | `Parsing.parseFromFloat_32`           | 1             |
| `38-41`  | `mcuTemperature`| `double`   | `Parsing.parseFromFloat_32`           | 1             |
| `42`     | `rssi`         | `int`       | `socketData[42].toSigned(8)`          | 1 (dBm)       |
| `43-44`  | `lastCorrection`| `int`      | `Parsing.parseFromUint_16`            | 1             |
| `45-46`  | `lastBasePacket`| `int`      | `Parsing.parseFromUint_16`            | 1             |
| `47-48`  | `hAcc1`        | `int`       | `Parsing.parseFromUint_16`            | 1             |
| `49-50`  | `vAcc1`        | `int`       | `Parsing.parseFromUint_16`            | 1             |
| `51`     | `satelit`      | `int`       | `socketData[51]`                      | 1             |
| `53`     | `status`       | `String`    | `_statusGPS(socketData[53])`          | Enum          |
| `54-55`  | `hAcc2`        | `int`       | `Parsing.parseFromUint_16`            | 1             |
| `56-57`  | `vAcc2`        | `int`       | `Parsing.parseFromUint_16`            | 1             |
| `58`     | `satelit2`     | `int`       | `socketData[58]`                      | 1             |
| `60`     | `status2`      | `String`    | `_statusGPS(socketData[60])`          | Enum          |
| `61-64`  | `bucketLat`    | `double`    | `Parsing.parseFromINT_32` / 10000000  | ÷ 1E7         |
| `65-68`  | `bucketLong`   | `double`    | `Parsing.parseFromINT_32` / 10000000  | ÷ 1E7         |
| `69-72`  | `trackHeight`  | `int`       | `Parsing.parseFromINT_32`            | 1             |
| `73-76`  | `boomLat`      | `double`    | `Parsing.parseFromINT_32` / 10000000  | ÷ 1E7         |
| `77-80`  | `boomLng`      | `double`    | `Parsing.parseFromINT_32` / 10000000  | ÷ 1E7         |
| `81-84`  | `boomAlt`      | `double`    | `Parsing.parseFromINT_32` / 1000      | ÷ 1000        |
| `85-88`  | `stickLat`     | `double`    | `Parsing.parseFromINT_32` / 10000000  | ÷ 1E7         |
| `89-92`  | `stickLng`     | `double`    | `Parsing.parseFromINT_32` / 10000000  | ÷ 1E7         |
| `93-96`  | `stickAlt`     | `double`    | `Parsing.parseFromINT_32` / 1000      | ÷ 1000        |
| `97-100` | `attachLat`    | `double`    | `Parsing.parseFromINT_32` / 10000000  | ÷ 1E7         |
| `101-104`| `attachLng`    | `double`    | `Parsing.parseFromINT_32` / 10000000  | ÷ 1E7         |
| `105-108`| `attachAlt`    | `double`    | `Parsing.parseFromINT_32` / 1000      | ÷ 1000        |
| `109-112`| `tipLat`       | `double`    | `Parsing.parseFromINT_32` / 10000000  | ÷ 1E7         |
| `113-116`| `tipLng`       | `double`    | `Parsing.parseFromINT_32` / 10000000  | ÷ 1E7         |
| `117-120`| `tipAlt`       | `double`    | `Parsing.parseFromINT_32` / 1000      | ÷ 1000        |

---

### `_parseCalibrationData(List<int> socketData)` → `CalibrationData` (OpCode 0xD1)

| Offset   | Field            | Dart Type  | Parse Method                         | Note              |
|----------|------------------|-----------|--------------------------------------|-------------------|
| `06-09`  | *(Packet ID)*    | —         | *(not stored in model, ignored)*     |                   |
| `10-13`  | `pitch`          | `double`  | `Parsing.parseFromFloat_32`          |                   |
| `14-17`  | `roll`           | `double`  | `Parsing.parseFromFloat_32`          |                   |
| `18-21`  | `boomTilt`       | `double`  | `Parsing.parseFromFloat_32`          |                   |
| `22-25`  | `stickTilt`      | `double`  | `Parsing.parseFromFloat_32`          |                   |
| `26-29`  | `bucketTilt`     | `double`  | `Parsing.parseFromFloat_32`          |                   |
| `30-33`  | `iLinkTilt`      | `double`  | `Parsing.parseFromFloat_32`          |                   |
| `34-37`  | `bucketLayTilt`  | `double`  | `Parsing.parseFromFloat_32`          | Bucket back tilt  |
| `38-39`  | `boomLenght`     | `int`     | `Parsing.parseFromUint_16`           |                   |
| `40-41`  | `stickLenght`    | `int`     | `Parsing.parseFromUint_16`           |                   |
| `42-43`  | `bucketLenght`   | `int`     | `Parsing.parseFromUint_16`           |                   |
| `46-47`  | `bucketWidth`    | `int`     | `Parsing.parseFromUint_16`           |                   |
| `50-51`  | `iLink`          | `int`     | `Parsing.parseFromUint_16`           |                   |
| `52-53`  | `hLink`          | `int`     | `Parsing.parseFromUint_16`           |                   |
| `54-55`  | `bpd`            | `int`     | `Parsing.parseFromUint_16`           | Boom pivot dist   |
| `56-57`  | `spd`            | `int`     | `Parsing.parseFromUint_16`           | Stick pivot dist  |
| `58-59`  | `boomBaseHeight` | `int`     | `Parsing.parseFromUint_16`           | Base hinge height |
| `60-61`  | `bcx`            | `int`     | `Parsing.parseFromINT_16`           | Boom center X     |
| `62-63`  | `bcy`            | `int`     | `Parsing.parseFromINT_16`           | Boom center Y     |
| `64-65`  | `acx`            | `int`     | `Parsing.parseFromINT_16`           | Axis center X     |
| `66-67`  | `acy`            | `int`     | `Parsing.parseFromINT_16`           | Axis center Y     |
| `68-69`  | `antHeight`      | `int`     | `Parsing.parseFromUint_16`           |                   |
| `70-71`  | `antPole`        | `int`     | `Parsing.parseFromUint_16`           |                   |
| `80-83`  | `heading`        | `double`  | `Parsing.parseFromFloat_32`          |                   |
| `84-85`  | `akurasi1`       | `int`     | `Parsing.parseFromUint_16`           | H Acc 1           |
| `88-89`  | `akurasi2`       | `int`     | `Parsing.parseFromUint_16`           | H Acc 2           |
| `92`     | `calStatus`      | `int`     | `socketData[92]`                     | Bitmask           |

---

### `_parseBasestatus(List<int> socketData)` → `Basestatus` (OpCode 0xD3)

| Offset   | Field             | Dart Type  | Parse Method                          |
|----------|-------------------|-----------|---------------------------------------|
| `06-09`  | `batteryVoltage`  | `double`  | `Parsing.parseFromFloat_32`           |
| `10-13`  | `batteryCurrent`  | `double`  | `Parsing.parseFromFloat_32`           |
| `14`     | `bcc`             | `int`     | `socketData[14]`                      |
| `15`     | `bmc`             | `int`     | `socketData[15]`                      |
| `16-23`  | `lat`             | `double`  | `Parsing.parseFromFloat_64`           |
| `24-31`  | `long`            | `double`  | `Parsing.parseFromFloat_64`           |
| `32-35`  | `altitude`        | `int`     | `Parsing.parseFromUint_32`            |
| `36-37`  | `akurasi`         | `int`     | `Parsing.parseFromUint_16`            |
| `38`     | `satelit`         | `int`     | `socketData[38]`                      |
| `39`     | `status`          | `String`  | `_statusBS2(socketData)` → see enum   |
| `41-44`  | `pitch`           | `double`  | `Parsing.parseFromFloat_32`           |
| `45-48`  | `roll`            | `double`  | `Parsing.parseFromFloat_32`           |
| `49`     | `chargetype`      | `String`  | `_chargeType(socketData[49])`         |
| `50-51`  | `bsDistance`      | `int`     | `Parsing.parseFromUint_16`            |

---

### `_parseRadioConfig(List<int> packet)` → `RadioConfig` (OpCode 0x86)

| Offset   | Field          | Dart Type | Parse Method                          |
|----------|----------------|----------|---------------------------------------|
| `07`     | `channel`      | `int`    | `packet[7]`                           |
| `08-09`  | `key`          | `int`    | `Parsing.parseFromUint_16`            |
| `10-11`  | `address`      | `int`    | `Parsing.parseFromUint_16`            |
| `12`     | `netID`        | `int`    | `packet[12]`                          |
| `13`     | `airDataRate`  | `int`    | `packet[13]`                          |

`lastUpdate` is set to `DateTime.now().millisecondsSinceEpoch`.

---

### `_parseSendAcknowledge(List<int> socketData)` → `SendAcknowledge` (OpCode 0x81)

| Offset | Field       | Dart Type  | Parse Method                          |
|--------|-------------|-----------|---------------------------------------|
| `06`   | `sourceID`  | `String`  | `_sourceIDError(socketData[6])`       |
| `07`   | `ackOpcode` | `int`     | `socketData[7]`                       |
| `08`   | `status`    | `int`     | `socketData[8]`                       |

- `isSuccess` getter: `status == 1`
- On receive: Shows `NotificationService.showSuccess(message)` if success, `.showError(message)` if failed.
- Message format: `'Header 0x81: ${ack.isSuccess ? "Success" : "Failed"} from ${ack.sourceID}'`

---

### `_parseErrorAlert(List<int> socketData)` → `ErrorAlert` (OpCode 0x83)

| Offset | Field       | Dart Type  | Parse Method                          |
|--------|-------------|-----------|---------------------------------------|
| `06`   | `sourceID`  | `String`  | `_sourceIDError(socketData[6])`       |
| `07`   | `alertType` | `String`  | `_errType(socketData[7])`             |
| `varies`| `message`  | `String`  | `_alertContent(socketData)` → dynamic |

---

## 8. Helper / Enum Functions

### `_statusGPS(int status)` → `String`
```
0 → 'NO RTK'
1 → 'FLOAT'
2 → 'RTK ON'
_ → 'Unknown'
```

### `_statusBS2(List<int> list)` → `String`
Reads byte at index `39`:
```
0 → 'NO FIX'
1 → 'RECKONING'
2 → '2D-FIX'
3 → '3D-FIX'
4 → 'GNSS-FIX'
5 → 'TO-FIX'
_ → 'Unknown'
```

### `_chargeType(int type)` → `String`
```
1 → 'Charging'
_ → 'Discharging'
```

### `_sourceIDError(int id)` → `String`
```
0 → 'Tablet Pair'
1 → 'Rover'
2 → 'Boom'
3 → 'Stick'
4 → 'Bucket'
5 → 'Plow'
_ → 'Unknown'
```

### `_errType(int id)` → `String`
```
0 → 'No Data'
1 → 'Fail To sent'
2 → 'Bad Power'
3 → 'Just Restarted'
4 → 'Sensor need Calibration'
5 → 'Data Lagging'
6 → 'Sensor Error'
7 → 'Restart External Sensor'
_ → 'Unknown'
```

### `_restartReason(int id)` → `String`
```
0 → 'Unknown'
1 → 'Power On'
2 → 'Panic'
3 → 'Watchdog'
4 → 'Brownout'
5 → 'OTA update'
6 → 'Internal'
7 → 'External'
_ → 'Unknown'
```

### `_alertContent(List<int> socketData)` → `String`
Dynamic message builder based on `alertType` (byte index 7):

| Type | Content Logic                                                                    |
|------|----------------------------------------------------------------------------------|
| `0`  | `'from ${_sourceIDError(socketData[8])}'`                                       |
| `1`  | `'to ${_sourceIDError(socketData[8])}'`                                         |
| `2`  | `'${parseFromFloat_32(socketData[8..11]).toStringAsFixed(2)}V'`                 |
| `3`  | `'${_restartReason(parseFromUint_16([8..9]))}, ${parseFromUint_16([10..11])} Times'` |
| `4`  | `'Sensor need Calibration'`                                                      |
| `5`  | `'Delay ${parseFromUint_32(socketData[8..11])} ms'`                             |
| `6`  | `'Sensor Error'`                                                                 |
| `7`  | `'Restart External Sensor'`                                                      |

---

## 9. WebSocket Management

### `connectToHostWebSocket({int port = 8080})` → `Future<bool>`
```
1. Gateway IP is hardcoded: "192.168.100.69"
   (In production, use NetworkInfo().getWifiGatewayIP() to discover hotspot owner)
2. Construct URL: ws://$gatewayIp:$port
3. Create WebSocketChannel.connect(wsUrl)
4. Await _wsChannel.ready
5. Update state: isWsConnected = true, wsAddress = wsUrl
6. Listen to stream:
   - On data: Try jsonDecode → store in state.wsData
   - On error/done: Call _handleWsDisconnect()
7. Return true on success, false on failure
```

### `sendDataToHost(Map<String, dynamic> data)`
Sends a JSON-encoded `Map` over the active WebSocket channel.
```dart
final jsonString = jsonEncode(data);
_wsChannel!.sink.add(jsonString);
```
Guard: Does nothing if `_wsChannel == null || !state.isWsConnected`.

### `sendRawDataToHost(Uint8List data)`
Sends raw binary bytes over the active WebSocket channel.
```dart
_wsChannel!.sink.add(data);
```
Guard: Same as above.

### `disconnectWebSocket()`
```dart
void disconnectWebSocket() {
  if (_wsChannel != null) {
    _wsChannel!.sink.close();
    _handleWsDisconnect();
  }
}
```

### `_handleWsDisconnect()` (Internal Cleanup)
```dart
void _handleWsDisconnect() {
  _wsSubscription?.cancel();
  _wsSubscription = null;
  _wsChannel = null;
  state = state.copyWith(isWsConnected: false, wsAddress: null, wsData: null);
}
```

---

## 10. Riverpod Providers

### Primary Service Provider
```dart
final comServiceProvider = NotifierProvider<ComService, UsbState>(
  ComService.new,
);
```
**Usage**: `ref.watch(comServiceProvider)` for USB state, `ref.read(comServiceProvider.notifier)` for function calls.

### GPS Stream Provider
```dart
final gpsStreamProvider = StreamProvider.autoDispose<GPSLoc>((ref) {
  ref.keepAlive();
  return ref.watch(comServiceProvider.notifier).gpsStream;
});
```
- `autoDispose` + `keepAlive()` → stays alive as long as there is at least one watcher but properly disposes when no longer needed.

### Calibration Stream Provider
```dart
final calibStreamProvider = StreamProvider.autoDispose<CalibrationData>((ref) {
  ref.keepAlive();
  return ref.watch(comServiceProvider.notifier).calibStream;
});
```

### Base Station Status Provider
```dart
class BsNotifier extends Notifier<Basestatus?> {
  @override
  Basestatus? build() => null;
  void updateState(Basestatus bs) => state = bs;
}

final bsProvider = NotifierProvider<BsNotifier, Basestatus?>(BsNotifier.new);
```

### Error Alert Provider
```dart
class ErrorNotifier extends Notifier<List<ErrorAlert>> {
  @override
  List<ErrorAlert> build() => [];

  void updateState(ErrorAlert err) {
    // Buffer capped at 100 alerts, newest first
    state = [err, ...state].take(100).toList();
  }
}

final errorProvider = NotifierProvider<ErrorNotifier, List<ErrorAlert>>(
  ErrorNotifier.new,
);
```

### Radio Config Provider
```dart
class RadioNotifier extends Notifier<RadioConfig?> {
  @override
  RadioConfig? build() => null;
  void updateState(RadioConfig conf) => state = conf;
}

final radioProvider = NotifierProvider<RadioNotifier, RadioConfig?>(
  RadioNotifier.new,
);
```

---

## 11. Parsing Utility Reference

Path: `lib/core/utils/parsing.dart`

All parsers use **Little Endian** byte order.

| Method                              | Input            | Output    | Dart Equivalent                           |
|-------------------------------------|------------------|-----------|-------------------------------------------|
| `Parsing.parseFromFloat_64(list)`   | `List<int>` (8B) | `double`  | `ByteData.getFloat64(0, Endian.little)`   |
| `Parsing.parseFromFloat_32(list)`   | `List<int>` (4B) | `double`  | `ByteData.getFloat32(0, Endian.little)`   |
| `Parsing.parseFromUint_16(list)`    | `List<int>` (2B) | `int`     | `ByteData.getUint16(0, Endian.little)`    |
| `Parsing.parseFromUint_32(list)`    | `List<int>` (4B) | `int`     | `ByteData.getUint32(0, Endian.little)`    |
| `Parsing.parseFromINT_16(list)`     | `List<int>` (2B) | `int`     | `ByteData.getInt16(0, Endian.little)`     |
| `Parsing.parseFromINT_32(list)`     | `List<int>` (4B) | `int`     | `ByteData.getInt32(0, Endian.little)`     |
| `Parsing.parseToFloat_64(data)`     | `double`         | `Uint8List (8B)` | `setFloat64(0, data, Endian.little)` |
| `Parsing.parseToFloat_32(data)`     | `double`         | `Uint8List (4B)` | `setFloat32(0, data, Endian.little)` |
| `Parsing.parseToUint_16(data)`      | `int`            | `Uint8List (2B)` | `setUint16(0, data, Endian.little)`  |
| `Parsing.buatToken(jumlah)`         | `int`            | `String`  | Random alphanumeric string                |
| `Parsing.buatID()`                  | —                | `int`     | Random int up to 99999999                 |
| `Parsing.stringToList(data)`        | `String`         | `List<int>` | `data.codeUnits`                        |

**Construction pattern** (all parsers follow this):
```dart
ByteBuffer buffer = Int8List.fromList(list).buffer;
ByteData data = ByteData.view(buffer);
return data.getXxx(0, Endian.little);
```

---

## 12. Data Models (Quick Reference)

### `GPSLoc` — Full rover telemetry
Fields: `boomLat`, `boomLng`, `boomAlt`, `stickLat`, `stickLng`, `stickAlt`, `attachLat`, `attachLng`, `attachAlt`, `tipLat`, `tipLng`, `tipAlt`, `hAcc1`, `vAcc1`, `satelit`, `status`, `heading`, `pitch`, `roll`, `bucketLat`, `bucketLong`, `hAcc2`, `vAcc2`, `satelit2`, `status2`, `rssi`, `bsDistance`, `boomTilt`, `stickTilt`, `attachTilt`, `lastCorrection`, `lastBasePacket`, `mcuVoltage`, `mcuTemperature`, `trackHeight`

### `CalibrationData` — Machine geometry + sensor calibration
Fields: `pitch`, `roll`, `boomTilt`, `stickTilt`, `bucketTilt`, `iLinkTilt`, `bucketLayTilt`, `boomLenght`, `stickLenght`, `bucketLenght`, `boomBaseHeight`, `bucketWidth`, `iLink`, `hLink`, `bpd`, `spd`, `bcx`, `bcy`, `acx`, `acy`, `antHeight`, `antPole`, `heading`, `akurasi1`, `akurasi2`, `calStatus`

### `Basestatus` — Base station health
Fields: `batteryVoltage`, `batteryCurrent`, `bcc`, `bmc`, `lat`, `long`, `altitude`, `akurasi`, `satelit`, `status`, `pitch`, `roll`, `bsDistance`, `chargetype`

### `RadioConfig` — LoRa radio parameters
Fields: `channel`, `key`, `address`, `netID`, `airDataRate`, `lastUpdate`

### `ErrorAlert` — System error/warning
Fields: `sourceID` (String), `alertType` (String), `message` (String), `timestamp` (DateTime)

### `SendAcknowledge` — Command response
Fields: `sourceID` (String), `ackOpcode` (int), `status` (int), `timestamp` (DateTime)
Getter: `bool get isSuccess => status == 1`

---

> [!IMPORTANT]
> The `UsbState` is global — any widget can watch `comServiceProvider` to see if the hardware is live. The `lastDataReceived` timestamp is the primary liveness signal, used by `GlobalAppBarActions` and `LoginPage._buildUsbStatus` with a 2-second freshness threshold.

> [!WARNING]
> Never modify provider state synchronously inside Riverpod lifecycle hooks or stream transforms. Always wrap state mutations in `Future.microtask(() => ...)` as shown in `_startUsb`. This prevents the assertion error: *"Cannot use Ref or modify other providers inside life-cycles/selectors."*
