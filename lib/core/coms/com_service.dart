import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
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

// --- State Class ---
class UsbState {
  final bool isConnected;
  final UsbPort? port;
  final List<UsbDevice> devices;
  final DateTime? lastDataReceived;
  final bool diggingStatus; // New field

  // WebSocket / Sync state properties
  final bool isWsConnected;
  final String? wsAddress;
  final dynamic wsData;

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

  UsbState copyWith({
    bool? isConnected,
    UsbPort? port,
    List<UsbDevice>? devices,
    DateTime? lastDataReceived,
    bool? diggingStatus,
    bool? isWsConnected,
    String? wsAddress,
    dynamic wsData,
  }) {
    return UsbState(
      isConnected: isConnected ?? this.isConnected,
      port: port ?? this.port,
      devices: devices ?? this.devices,
      lastDataReceived: lastDataReceived ?? this.lastDataReceived,
      diggingStatus: diggingStatus ?? this.diggingStatus,
      isWsConnected: isWsConnected ?? this.isWsConnected,
      wsAddress: wsAddress ?? this.wsAddress,
      wsData: wsData ?? this.wsData,
    );
  }
}

// --- ComService (Notifier) ---
class ComService extends Notifier<UsbState> {
  // Stream Controllers
  final StreamController<GPSLoc> _gpsController =
      StreamController<GPSLoc>.broadcast();
  final StreamController<CalibrationData> _calibController =
      StreamController<CalibrationData>.broadcast();

  // USB Transaction
  Transaction<Uint8List>? _txn;
  StreamSubscription<Uint8List>? _txnSub;
  StreamSubscription<UsbEvent>? _usbEventSub;

  // WebSocket Connection
  WebSocketChannel? _wsChannel;
  StreamSubscription? _wsSubscription;

  @override
  UsbState build() {
    // Listen for USB connection state changes dynamically
    _usbEventSub = UsbSerial.usbEventStream?.listen((UsbEvent event) {
      if (event.event == UsbEvent.ACTION_USB_DETACHED) {
        debugPrint("USB Detached!");
        disconnect();
      } else if (event.event == UsbEvent.ACTION_USB_ATTACHED) {
        debugPrint("USB Attached!");
        autoConnect(
          "CP2102N",
        ); // Attempt to reconnect automatically when a cable is plugged in
      }
    });

    ref.onDispose(() {
      _usbEventSub?.cancel();
      disconnectWebSocket();
    });

    return UsbState();
  }

  // Getters for Streams
  Stream<GPSLoc> get gpsStream => _gpsController.stream;
  Stream<CalibrationData> get calibStream => _calibController.stream;

  // --- WebSocket Management ---

  /// Attempts to find the host's IP and establish a WebSocket connection.
  /// Typically, the Rover connects to the Basestation's hotspot, meaning the
  /// Basestation is the Gateway/Router IP for the Rover.
  Future<bool> connectToHostWebSocket({int port = 8080}) async {
    try {
      // On Android connected to a hotspot, the Gateway IP is usually the Hotspot owner
      // final info = NetworkInfo();
      // String? gatewayIp = await info.getWifiGatewayIP();
      const String gatewayIp = '192.168.100.186';

      if (gatewayIp.isEmpty) {
        debugPrint(
          "Failed to get Gateway IP. Reverting to manual entry or aborting.",
        );
        return false;
      }

      final wsUrl = Uri.parse('ws://$gatewayIp:$port');
      debugPrint("Attempting WebSocket connection to: $wsUrl");

      _wsChannel = WebSocketChannel.connect(wsUrl);

      // Successfully constructed the channel (Actual connection state requires awaiting `.ready` or ping response,
      // but creating it without exception means we can start listening)
      await _wsChannel!.ready;

      state = state.copyWith(isWsConnected: true, wsAddress: wsUrl.toString());

      _wsSubscription = _wsChannel!.stream.listen(
        (data) {
          debugPrint("WebSocket Data Received: $data");
          try {
            final decoded = jsonDecode(data);
            state = state.copyWith(wsData: decoded);
          } catch (e) {
            state = state.copyWith(wsData: data); // Raw string fallback
          }
        },
        onError: (error) {
          debugPrint("WebSocket Error: $error");
          _handleWsDisconnect();
        },
        onDone: () {
          debugPrint("WebSocket Closed");
          _handleWsDisconnect();
        },
      );

      return true;
    } catch (e) {
      debugPrint("WebSocket Connection Failed: $e");
      _handleWsDisconnect();
      return false;
    }
  }

  /// Sends a raw string over the active WebSocket channel.
  void sendString(String message) {
    if (_wsChannel != null && state.isWsConnected) {
      try {
        _wsChannel!.sink.add(message);
        debugPrint("WebSocket String Sent: $message");
      } catch (e) {
        debugPrint("WebSocket Send String Error: $e");
      }
    } else {
      debugPrint(
        "Attempted to send WebSocket string but connection is not active.",
      );
    }
  }

  /// Sends a dynamically serialized Map over the active WebSocket channel.
  void sendDataToHost(Map<String, dynamic> data) {
    if (_wsChannel != null && state.isWsConnected) {
      try {
        final jsonString = jsonEncode(data);
        _wsChannel!.sink.add(jsonString);
        debugPrint("WebSocket Payload Sent: $jsonString");
      } catch (e) {
        debugPrint("WebSocket Send Error: $e");
      }
    } else {
      debugPrint(
        "Attempted to send WebSocket data but connection is not active.",
      );
    }
  }

  /// Sends raw byte data over the active WebSocket channel.
  void sendRawDataToHost(Uint8List data) {
    if (_wsChannel != null && state.isWsConnected) {
      try {
        _wsChannel!.sink.add(data);
        debugPrint("WebSocket Raw Payload Sent: ${data.length} bytes");
      } catch (e) {
        debugPrint("WebSocket Send Raw Error: $e");
      }
    } else {
      debugPrint(
        "Attempted to send WebSocket raw data but connection is not active.",
      );
    }
  }

  void _handleWsDisconnect() {
    _wsSubscription?.cancel();
    _wsSubscription = null;
    _wsChannel = null;
    state = state.copyWith(isWsConnected: false, wsAddress: null, wsData: null);
  }

  void disconnectWebSocket() {
    if (_wsChannel != null) {
      _wsChannel!.sink.close();
      _handleWsDisconnect();
    }
  }

  // --- Device Management ---

  Future<void> listDevices() async {
    try {
      List<UsbDevice> devices = await UsbSerial.listDevices();
      state = state.copyWith(devices: devices);
    } catch (e) {
      debugPrint('Error listing devices: $e');
    }
  }

  Future<bool> connectToDevice(UsbDevice device) async {
    try {
      var port = await device.create();
      if (port == null) return false;

      bool openResult = await port.open();
      if (!openResult) return false;

      await port.setDTR(true);
      await port.setRTS(true);
      await port.setPortParameters(
        115200,
        UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1,
        UsbPort.PARITY_NONE,
      );

      // Update State
      state = state.copyWith(port: port, isConnected: true);

      // Start Listening
      await _startUsb(port);
      return true;
    } catch (e) {
      debugPrint('Error connecting to device: $e');
      return false;
    }
  }

  Future<void> disconnect() async {
    await _stopUsb();
    state.port?.close();
    state = state.copyWith(port: null, isConnected: false);
  }

  void resetDiggingStatus() {
    state = state.copyWith(diggingStatus: false);
  }

  Future<void> autoConnect(String filterName) async {
    await listDevices();
    for (var device in state.devices) {
      if (device.productName != null &&
          device.productName!.contains(filterName)) {
        debugPrint("Auto-connecting to: ${device.productName}");
        await connectToDevice(device);
        return; // Connect to first match
      }
    }
  }

  // --- Internal Stream Handling ---

  Future<void> _startUsb(UsbPort port) async {
    debugPrint('Starting USB data listener on port: $port');

    // Intercept raw stream to update lastDataReceived regardless of framing/opcode
    final Stream<Uint8List> rawStream = port.inputStream!.map((data) {
      final now = DateTime.now();
      if (state.lastDataReceived == null ||
          now.difference(state.lastDataReceived!).inMilliseconds > 500) {
        Future.microtask(() {
          state = state.copyWith(lastDataReceived: now);
        });
      }
      return data;
    });

    // Magic header: 0x55, 0xAA, 0x55, 0xAA -> [85, 170, 85, 170]
    _txn = Transaction.magicHeader(rawStream, [85, 170, 85, 170], maxLen: 200);

    _txnSub = _txn!.stream.listen(
      (Uint8List framed) {
        final packet = framed.toList();

        // Basic validation (optional CRC check here)
        if (packet.length < 6) return;

        final opcode = packet[5];

        if (opcode == 0xD0) {
          // GPS Data
          try {
            final gps = _parseGPSLoc(packet);
            _gpsController.add(gps);
          } catch (e) {
            debugPrint('Error parsing GPS: $e');
          }
        } else if (opcode == 0xD3) {
          // Base Status
          try {
            final bs = _parseBasestatus(packet);
            ref.read(bsProvider.notifier).updateState(bs);
          } catch (e) {
            debugPrint('Error parsing BaseStatus: $e');
          }
        } else if (opcode == 0x83) {
          // Error Alert
          try {
            final error = _parseErrorAlert(packet);
            ref.read(errorProvider.notifier).updateState(error);
          } catch (e) {
            debugPrint('Error parsing Alert: $e');
          }
        } else if (opcode == 0xD1) {
          // Calibration Data
          try {
            final calib = _parseCalibrationData(packet);
            _calibController.add(calib);
          } catch (e) {
            debugPrint('Error parsing CalibrationData: $e');
          }
        } else if (opcode == 0x86) {
          // Radio Config
          try {
            final config = _parseRadioConfig(packet);
            ref.read(radioProvider.notifier).updateState(config);
          } catch (e) {
            debugPrint('Error parsing RadioConfig: $e');
          }
        } else if (opcode == 0xD2) {
          // Digging Status
          debugPrint('Digging Status Received (0xD2)');
          state = state.copyWith(diggingStatus: true);
        } else if (opcode == 0x81) {
          // Send Acknowledge
          try {
            final ack = _parseSendAcknowledge(packet);
            debugPrint('Send Acknowledge Received: $ack');

            final message =
                'Header 0x81: ${ack.isSuccess ? "Success" : "Failed"} from ${ack.sourceID}';
            if (ack.isSuccess) {
              simple_notif.NotificationService.showSuccess(message);
            } else {
              simple_notif.NotificationService.showError(message);
            }
          } catch (e) {
            debugPrint('Error parsing SendAcknowledge: $e');
          }
        }
      },
      onError: (e) {
        debugPrint('Transaction stream error: $e');
        disconnect();
      },
      onDone: () {
        debugPrint('Transaction stream done');
        disconnect();
      },
    );
  }

  Future<void> _stopUsb() async {
    await _txnSub?.cancel();
    _txnSub = null;
    _txn?.dispose();
    _txn = null;
  }

  // --- Parsers ---

  GPSLoc _parseGPSLoc(List<int> socketData) {
    return GPSLoc(
      boomLat: Parsing.parseFromINT_32(socketData.sublist(73, 77)) / 10000000,
      boomLng: Parsing.parseFromINT_32(socketData.sublist(77, 81)) / 10000000,
      boomAlt: Parsing.parseFromINT_32(socketData.sublist(81, 85)) / 1000,
      stickLat: Parsing.parseFromINT_32(socketData.sublist(85, 89)) / 10000000,
      stickLng: Parsing.parseFromINT_32(socketData.sublist(89, 93)) / 10000000,
      stickAlt: Parsing.parseFromINT_32(socketData.sublist(93, 97)) / 1000,
      attachLat:
          Parsing.parseFromINT_32(socketData.sublist(97, 101)) / 10000000,
      attachLng:
          Parsing.parseFromINT_32(socketData.sublist(101, 105)) / 10000000,
      attachAlt: Parsing.parseFromINT_32(socketData.sublist(105, 109)) / 1000,
      tipLat: Parsing.parseFromINT_32(socketData.sublist(109, 113)) / 10000000,
      tipLng: Parsing.parseFromINT_32(socketData.sublist(113, 117)) / 10000000,
      tipAlt: Parsing.parseFromINT_32(socketData.sublist(117, 121)) / 1000,
      hAcc1: Parsing.parseFromUint_16(socketData.sublist(47, 49)),
      vAcc1: Parsing.parseFromUint_16(socketData.sublist(49, 51)),
      satelit: socketData[51],
      status: _statusGPS(socketData[53]),
      heading: Parsing.parseFromFloat_32(socketData.sublist(30, 34)),
      pitch: Parsing.parseFromFloat_32(socketData.sublist(10, 14)),
      roll: Parsing.parseFromFloat_32(socketData.sublist(14, 18)),
      bucketLat: Parsing.parseFromINT_32(socketData.sublist(61, 65)) / 10000000,
      bucketLong:
          Parsing.parseFromINT_32(socketData.sublist(65, 69)) / 10000000,
      hAcc2: Parsing.parseFromUint_16(socketData.sublist(54, 56)),
      vAcc2: Parsing.parseFromUint_16(socketData.sublist(56, 58)),
      satelit2: socketData[58],
      status2: _statusGPS(socketData[60]),
      rssi: socketData[42].toSigned(8),
      bsDistance: Parsing.parseFromUint_32(socketData.sublist(6, 10)),
      boomTilt: Parsing.parseFromFloat_32(socketData.sublist(18, 22)),
      stickTilt: Parsing.parseFromFloat_32(socketData.sublist(22, 26)),
      attachTilt: Parsing.parseFromFloat_32(socketData.sublist(26, 30)),
      lastCorrection: Parsing.parseFromUint_16(socketData.sublist(43, 45)),
      lastBasePacket: Parsing.parseFromUint_16(socketData.sublist(45, 47)),
      mcuVoltage: Parsing.parseFromFloat_32(socketData.sublist(34, 38)),
      mcuTemperature: Parsing.parseFromFloat_32(socketData.sublist(38, 42)),
      trackHeight: Parsing.parseFromINT_32(socketData.sublist(69, 73)),
    );
  }

  Basestatus _parseBasestatus(List<int> socketData) {
    return Basestatus(
      batteryVoltage: Parsing.parseFromFloat_32(socketData.sublist(6, 10)),
      batteryCurrent: Parsing.parseFromFloat_32(socketData.sublist(10, 14)),
      bcc: socketData[14],
      bmc: socketData[15],
      lat: Parsing.parseFromFloat_64(socketData.sublist(16, 24)),
      long: Parsing.parseFromFloat_64(socketData.sublist(24, 32)),
      altitude: Parsing.parseFromUint_32(socketData.sublist(32, 36)),
      akurasi: Parsing.parseFromUint_16(socketData.sublist(36, 38)),
      satelit: socketData[38],
      status: _statusBS2(socketData),
      pitch: Parsing.parseFromFloat_32(socketData.sublist(41, 45)),
      roll: Parsing.parseFromFloat_32(socketData.sublist(45, 49)),
      chargetype: _chargeType(socketData[49]),
      bsDistance: Parsing.parseFromUint_16(socketData.sublist(50, 52)),
    );
  }

  ErrorAlert _parseErrorAlert(List<int> socketData) {
    return ErrorAlert(
      sourceID: _sourceIDError(socketData[6]),
      alertType: _errType(socketData[7]),
      message: _alertContent(socketData),
      timestamp: DateTime.now(),
    );
  }

  CalibrationData _parseCalibrationData(List<int> socketData) {
    return CalibrationData(
      // Packet ID is at 6-9 (4 bytes, uint32_t) - not in model, ignored
      pitch: Parsing.parseFromFloat_32(socketData.sublist(10, 14)),
      roll: Parsing.parseFromFloat_32(socketData.sublist(14, 18)),
      boomTilt: Parsing.parseFromFloat_32(socketData.sublist(18, 22)),
      stickTilt: Parsing.parseFromFloat_32(socketData.sublist(22, 26)),
      bucketTilt: Parsing.parseFromFloat_32(socketData.sublist(26, 30)),
      iLinkTilt: Parsing.parseFromFloat_32(socketData.sublist(30, 34)),
      bucketLayTilt: Parsing.parseFromFloat_32(
        socketData.sublist(34, 38),
      ), // "Bucket Back Tilt" in spreadsheet?
      boomLenght: Parsing.parseFromUint_16(socketData.sublist(38, 40)),
      stickLenght: Parsing.parseFromUint_16(socketData.sublist(40, 42)),
      bucketLenght: Parsing.parseFromUint_16(socketData.sublist(42, 44)),
      boomBaseHeight: Parsing.parseFromUint_16(
        socketData.sublist(58, 60),
      ), // "Bucket Base length" in spreadsheet
      bucketWidth: Parsing.parseFromUint_16(socketData.sublist(46, 48)),
      // BTW is at 48-49 - not explicitly in model, skipped or mapped differently by user before?
      iLink: Parsing.parseFromUint_16(socketData.sublist(50, 52)),
      hLink: Parsing.parseFromUint_16(socketData.sublist(52, 54)),
      bpd: Parsing.parseFromUint_16(socketData.sublist(54, 56)),
      spd: Parsing.parseFromUint_16(socketData.sublist(56, 58)),
      // BPH is at 58-59 - previously mapped to boomBaseHeight which was at 55-57. I'll stick to model mapping.
      bcx: Parsing.parseFromINT_16(socketData.sublist(60, 62)),
      bcy: Parsing.parseFromINT_16(socketData.sublist(62, 64)),
      acx: Parsing.parseFromINT_16(socketData.sublist(64, 66)),
      acy: Parsing.parseFromINT_16(socketData.sublist(66, 68)),
      antHeight: Parsing.parseFromUint_16(socketData.sublist(68, 70)),
      antPole: Parsing.parseFromUint_16(socketData.sublist(70, 72)),
      // Antennas Dist 72-73, Antenna 2 Offset 74-75, OGL 76-79
      heading: Parsing.parseFromFloat_32(socketData.sublist(80, 84)),
      akurasi1: Parsing.parseFromUint_16(socketData.sublist(84, 86)), // H Acc 1
      akurasi2: Parsing.parseFromUint_16(socketData.sublist(88, 90)), // H Acc 2
      // V Acc 1 (86-87), V Acc 2 (90-91) exist but aren't in CalibrationData model currently.
      calStatus: socketData[92],
    );
  }

  RadioConfig _parseRadioConfig(List<int> packet) {
    return RadioConfig(
      channel: packet[7],
      key: Parsing.parseFromUint_16(packet.sublist(8, 10)),
      address: Parsing.parseFromUint_16(packet.sublist(10, 12)),
      netID: packet[12],
      airDataRate: packet[13],
      lastUpdate: DateTime.now().millisecondsSinceEpoch,
    );
  }

  SendAcknowledge _parseSendAcknowledge(List<int> socketData) {
    return SendAcknowledge(
      sourceID: _sourceIDError(socketData[6]),
      ackOpcode: socketData[7],
      status: socketData[8],
      timestamp: DateTime.now(),
    );
  }

  // --- Helper Functions ---
  String _statusGPS(int status) {
    switch (status) {
      case 0:
        return 'NO RTK';
      case 1:
        return 'FLOAT';
      case 2:
        return 'RTK ON';
      default:
        return 'Unknown';
    }
  }

  String _statusBS2(List<int> list) {
    const status = {
      0: 'NO FIX',
      1: 'RECKONING',
      2: '2D-FIX',
      3: '3D-FIX',
      4: 'GNSS-FIX',
      5: 'TO-FIX',
    };
    return status[list[39]] ?? 'Unknown';
  }

  String _chargeType(int type) {
    return type == 1 ? 'Charging' : 'Discharging';
  }

  String _sourceIDError(int id) {
    const ids = {
      0: 'Tablet Pair',
      1: 'Rover',
      2: 'Boom',
      3: 'Stick',
      4: 'Bucket',
      5: 'Plow',
    };
    return ids[id] ?? 'Unknown';
  }

  String _errType(int id) {
    const types = {
      0: 'No Data',
      1: 'Fail To sent',
      2: 'Bad Power',
      3: 'Just Restarted',
      4: 'Sensor need Calibration',
      5: 'Data Lagging',
      6: 'Sensor Error',
      7: 'Restart External Sensor',
    };
    return types[id] ?? 'Unknown';
  }

  String _restartReason(int id) {
    const reasons = {
      0: 'Unknown',
      1: 'Power On',
      2: 'Panic',
      3: 'Watchdog',
      4: 'Brownout',
      5: 'OTA update',
      6: 'Internal',
      7: 'External',
    };
    return reasons[id] ?? 'Unknown';
  }

  String _alertContent(List<int> socketData) {
    final type = socketData[7];
    final source = socketData[8]; // Assuming source ID in byte 8
    if (type == 0) {
      return 'from ${_sourceIDError(source)}';
    }
    if (type == 1) {
      return 'to ${_sourceIDError(source)}';
    }
    if (type == 2) {
      return '${Parsing.parseFromFloat_32(socketData.sublist(8, 12)).toStringAsFixed(2)}V';
    }
    if (type == 3) {
      final reasonCode = Parsing.parseFromUint_16(socketData.sublist(8, 10));
      final count = Parsing.parseFromUint_16(socketData.sublist(10, 12));
      return '${_restartReason(reasonCode)}, $count Times';
    }
    if (type == 4) {
      return 'Sensor need Calibration';
    }
    if (type == 5) {
      return 'Delay ${Parsing.parseFromUint_32(socketData.sublist(8, 12))} ms';
    }
    if (type == 6) {
      return 'Sensor Error';
    }
    if (type == 7) {
      return 'Restart External Sensor';
    }
    return 'Unknown Error';
  }
}

// --- Providers ---

final comServiceProvider = NotifierProvider<ComService, UsbState>(
  ComService.new,
);

final gpsStreamProvider = StreamProvider.autoDispose<GPSLoc>((ref) {
  ref.keepAlive();
  return ref.watch(comServiceProvider.notifier).gpsStream;
});

class BsNotifier extends Notifier<Basestatus?> {
  @override
  Basestatus? build() => null;
  void updateState(Basestatus bs) => state = bs;
}

final bsProvider = NotifierProvider<BsNotifier, Basestatus?>(BsNotifier.new);

class ErrorNotifier extends Notifier<List<ErrorAlert>> {
  @override
  List<ErrorAlert> build() => [];

  void updateState(ErrorAlert err) {
    // Keep internal buffer of 100 alerts, newest first
    state = [err, ...state].take(100).toList();
  }
}

final errorProvider = NotifierProvider<ErrorNotifier, List<ErrorAlert>>(
  ErrorNotifier.new,
);

class RadioNotifier extends Notifier<RadioConfig?> {
  @override
  RadioConfig? build() => null;
  void updateState(RadioConfig conf) => state = conf;
}

final radioProvider = NotifierProvider<RadioNotifier, RadioConfig?>(
  RadioNotifier.new,
);

final calibStreamProvider = StreamProvider.autoDispose<CalibrationData>((ref) {
  ref.keepAlive();
  return ref.watch(comServiceProvider.notifier).calibStream;
});
