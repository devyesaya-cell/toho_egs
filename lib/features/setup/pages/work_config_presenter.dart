import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/work_config.dart';
import '../../../../core/coms/com_service.dart';

class WorkConfigState {
  final WorkConfig config;

  WorkConfigState({
    this.config = const WorkConfig(),
  });

  WorkConfigState copyWith({
    WorkConfig? config,
  }) {
    return WorkConfigState(
      config: config ?? this.config,
    );
  }
}

class WorkConfigPresenter extends Notifier<WorkConfigState> {
  @override
  WorkConfigState build() {
    return WorkConfigState();
  }

  void setWorkConfigParam(int index, int value) {
    // 1. Send command via serial
    // Packet Structure: [0xAA, 0x55, 0xAA, 0x55, 0x05, 0x56, index, value, crc low, crc high]
    final payload = <int>[
      0xAA, 0x55, 0xAA, 0x55, // Header
      0x05,                   // Length
      0x56,                   // Opcode
      index,                  // Type
      value                   // Value
    ];

    final crc = _calCRC16(payload.sublist(4));
    payload.add(crc & 0xFF);         // CRC Low
    payload.add((crc >> 8) & 0xFF);  // CRC High

    // Send the constructed packet
    final port = ref.read(comServiceProvider).port;
    if (port != null) {
      port.write(Uint8List.fromList(payload));
    }

    // 2. Update local state representation
    WorkConfig newConfig = state.config;
    switch (index) {
      case 0:
        newConfig = newConfig.copyWith(gnssAltRef: value);
        break;
      case 1:
        newConfig = newConfig.copyWith(altRef: value);
        break;
      case 2:
        newConfig = newConfig.copyWith(bucketLenRef: value);
        break;
      case 3:
        newConfig = newConfig.copyWith(bucketHorizRef: value);
        break;
      case 4:
        newConfig = newConfig.copyWith(pitchComp: value);
        break;
    }

    state = state.copyWith(config: newConfig);
  }

  int _calCRC16(List<int> bytes) {
    int crc = 0xFFFF;
    for (int byte in bytes) {
      crc ^= byte;
      for (int i = 0; i < 8; i++) {
        if ((crc & 1) != 0) {
          crc = (crc >> 1) ^ 0xA001;
        } else {
          crc >>= 1;
        }
      }
    }
    return crc;
  }
}

final workConfigProvider =
    NotifierProvider<WorkConfigPresenter, WorkConfigState>(
        () => WorkConfigPresenter());
