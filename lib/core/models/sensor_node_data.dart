class SensorNodeData {
  final int length;
  final int opcode;
  final int sourceID;
  final int errorBits;
  final int resetReason;
  final int restartNumber;
  final int uptime; // in seconds
  final int sensorType;
  final int sensorID;
  
  // Accelerometer data (unit: mg)
  final int accelX;
  final int accelY;
  final int accelZ;
  
  // Offsets
  final int offsetX;
  final int offsetY;
  final int offsetZ;
  
  // Scales (unit: 1E-02)
  final int scaleRawX;
  final int scaleRawY;
  final int scaleRawZ;
  
  // Error counts
  final int errSensorRead;
  final int errSensorUncalib;
  final int errCANSendFail;
  
  // Physical measurements
  final int tiltRaw; // unit: deg (1E-02)
  final int tempRaw; // unit: C (1E-02)
  final int adc3V3Raw; // unit: V (1E-02)
  final int adc5VRaw; // unit: V (1E-02)
  
  // CAN/Main counters
  final int mainCounter;
  final int boomCounter;
  final int stickCounter;
  final int bucketCounter;
  
  final int canRxTimeout;
  final int crc16;

  SensorNodeData({
    required this.length,
    required this.opcode,
    required this.sourceID,
    required this.errorBits,
    required this.resetReason,
    required this.restartNumber,
    required this.uptime,
    required this.sensorType,
    required this.sensorID,
    required this.accelX,
    required this.accelY,
    required this.accelZ,
    required this.offsetX,
    required this.offsetY,
    required this.offsetZ,
    required this.scaleRawX,
    required this.scaleRawY,
    required this.scaleRawZ,
    required this.errSensorRead,
    required this.errSensorUncalib,
    required this.errCANSendFail,
    required this.tiltRaw,
    required this.tempRaw,
    required this.adc3V3Raw,
    required this.adc5VRaw,
    required this.mainCounter,
    required this.boomCounter,
    required this.stickCounter,
    required this.bucketCounter,
    required this.canRxTimeout,
    required this.crc16,
  });

  // --- Mappings & Mapped Getters ---

  String get sourceIDLabel {
    switch (sourceID) {
      case 0:
        return 'Tablet Pair';
      case 1:
        return 'Rover';
      case 2:
        return 'Boom';
      case 3:
        return 'Stick';
      case 4:
        return 'Attachment';
      case 5:
        return 'Plow';
      default:
        return 'Unknown ($sourceID)';
    }
  }

  String get sensorTypeLabel {
    switch (sensorType) {
      case 0:
        return 'ISM';
      case 1:
        return 'ASM';
      case 2:
        return 'IIM';
      default:
        return 'Unknown ($sensorType)';
    }
  }

  String get resetReasonLabel {
    switch (resetReason) {
      case 0:
        return 'Unknown';
      case 1:
        return 'Power On';
      case 2:
        return 'Panic';
      case 3:
        return 'WatchDog';
      case 4:
        return 'BrownOut';
      case 5:
        return 'OTA Update';
      case 6:
        return 'Internal';
      case 7:
        return 'External';
      default:
        return 'Code $resetReason';
    }
  }

  // Bitwise Error Decoders
  bool get hasESP32Error => (errorBits & 1) != 0;
  bool get hasSensorError => (errorBits & 2) != 0;
  bool get hasCANError => (errorBits & 4) != 0;
  bool get hasInputVoltError => (errorBits & 8) != 0;

  List<String> get errorFlags {
    final List<String> flags = [];
    if (hasESP32Error) flags.add('ESP32 Error');
    if (hasSensorError) flags.add('Sensor Error');
    if (hasCANError) flags.add('CAN Error');
    if (hasInputVoltError) flags.add('Input Volt Error');
    return flags;
  }

  // --- Physical Scaled Getters ---

  double get scaleX => scaleRawX / 100.0;
  double get scaleY => scaleRawY / 100.0;
  double get scaleZ => scaleRawZ / 100.0;

  double get tilt => tiltRaw / 100.0;
  double get temperature => tempRaw / 100.0;
  double get adc3V3 => adc3V3Raw / 100.0;
  double get adc5V => adc5VRaw / 100.0;

  // Formatting helpers
  String get uptimeFormatted {
    final int hours = uptime ~/ 3600;
    final int minutes = (uptime % 3600) ~/ 60;
    final int seconds = uptime % 60;
    
    final String hStr = hours.toString().padLeft(2, '0');
    final String mStr = minutes.toString().padLeft(2, '0');
    final String sStr = seconds.toString().padLeft(2, '0');
    
    return '$hStr:$mStr:$sStr';
  }
}
