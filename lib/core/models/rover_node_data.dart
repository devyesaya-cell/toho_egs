class RoverNodeData {
  final int length;
  final int opcode;
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

  // Angles/Tilt (unit: deg 1E-02)
  final int rawPitch;
  final int rawRoll;

  // Hardware/Environmental
  final int tempRaw; // unit: C (1E-02)
  final int vinAdcRaw; // unit: V (1E-02)
  final int adc5VRaw; // unit: V (1E-02)

  // Cylinder/Arm Angles (unit: deg 1E-02)
  final int rawBoom;
  final int rawStick;
  final int rawBucket;
  
  // Counters
  final int mainCounter;
  final int boomCounter;
  final int stickCounter;
  final int bucketCounter;
  
  final int canRxTimeout;
  final int gnss1Counter;
  final int gnss2Counter;
  final int bsStationRx;
  final int rs485Rx;
  final int sdCardCapacity; // in MB
  final int sdCardSpeed; // in kHz
  
  final int crc16;

  RoverNodeData({
    required this.length,
    required this.opcode,
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
    required this.rawPitch,
    required this.rawRoll,
    required this.tempRaw,
    required this.vinAdcRaw,
    required this.adc5VRaw,
    required this.rawBoom,
    required this.rawStick,
    required this.rawBucket,
    required this.mainCounter,
    required this.boomCounter,
    required this.stickCounter,
    required this.bucketCounter,
    required this.canRxTimeout,
    required this.gnss1Counter,
    required this.gnss2Counter,
    required this.bsStationRx,
    required this.rs485Rx,
    required this.sdCardCapacity,
    required this.sdCardSpeed,
    required this.crc16,
  });

  // --- Mappings & Mapped Getters ---

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

  // Bitwise Error Decoders (bit 1: ESP32, bit 2: Sensor, bit 3: CAN, bit 4: Voltage)
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

  double get pitch => rawPitch / 100.0;
  double get roll => rawRoll / 100.0;
  double get temperature => tempRaw / 100.0;
  double get vinAdc => vinAdcRaw / 100.0;
  double get adc5V => adc5VRaw / 100.0;
  double get boomAngle => rawBoom / 100.0;
  double get stickAngle => rawStick / 100.0;
  double get bucketAngle => rawBucket / 100.0;

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
