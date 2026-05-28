import 'package:isar_community/isar.dart';
import 'gps_loc.dart';
import 'base_status.dart';
import 'rover_node_data.dart';
import 'sensor_node_data.dart';
import 'error_alert.dart';

part 'debug_logs.g.dart';

@collection
class DebugLogs {
  Id id = Isar.autoIncrement;

  GPSLocEmbedded? gpsLoc;
  BasestatusEmbedded? baseStatus;
  RoverNodeDataEmbedded? roverNode;
  SensorNodeDataEmbedded? sensorNode;
  ErrorAlertEmbedded? errorAlert;

  DateTime lastUpdate;

  DebugLogs({
    this.id = Isar.autoIncrement,
    this.gpsLoc,
    this.baseStatus,
    this.roverNode,
    this.sensorNode,
    this.errorAlert,
    required this.lastUpdate,
  });
}

@embedded
class GPSLocEmbedded {
  double? boomLat;
  double? boomLng;
  double? boomAlt;
  double? stickLat;
  double? stickLng;
  double? stickAlt;
  double? attachLat;
  double? attachLng;
  double? attachAlt;
  double? tipLat;
  double? tipLng;
  double? tipAlt;
  int? hAcc1;
  int? vAcc1;
  int? satelit;
  String? status;
  double? heading;
  double? pitch;
  double? roll;
  int? trackHeight;
  double? bucketLat;
  double? bucketLong;
  int? hAcc2;
  int? vAcc2;
  int? satelit2;
  String? status2;
  int? rssi;
  int? bsDistance;
  double? boomTilt;
  double? stickTilt;
  double? attachTilt;
  int? lastCorrection;
  int? lastBasePacket;
  double? mcuVoltage;
  double? mcuTemperature;

  GPSLocEmbedded();

  factory GPSLocEmbedded.fromGPSLoc(GPSLoc data) {
    return GPSLocEmbedded()
      ..boomLat = data.boomLat
      ..boomLng = data.boomLng
      ..boomAlt = data.boomAlt
      ..stickLat = data.stickLat
      ..stickLng = data.stickLng
      ..stickAlt = data.stickAlt
      ..attachLat = data.attachLat
      ..attachLng = data.attachLng
      ..attachAlt = data.attachAlt
      ..tipLat = data.tipLat
      ..tipLng = data.tipLng
      ..tipAlt = data.tipAlt
      ..hAcc1 = data.hAcc1
      ..vAcc1 = data.vAcc1
      ..satelit = data.satelit
      ..status = data.status
      ..heading = data.heading
      ..pitch = data.pitch
      ..roll = data.roll
      ..trackHeight = data.trackHeight
      ..bucketLat = data.bucketLat
      ..bucketLong = data.bucketLong
      ..hAcc2 = data.hAcc2
      ..vAcc2 = data.vAcc2
      ..satelit2 = data.satelit2
      ..status2 = data.status2
      ..rssi = data.rssi
      ..bsDistance = data.bsDistance
      ..boomTilt = data.boomTilt
      ..stickTilt = data.stickTilt
      ..attachTilt = data.attachTilt
      ..lastCorrection = data.lastCorrection
      ..lastBasePacket = data.lastBasePacket
      ..mcuVoltage = data.mcuVoltage
      ..mcuTemperature = data.mcuTemperature;
  }
}

@embedded
class BasestatusEmbedded {
  double? batteryVoltage;
  double? batteryCurrent;
  int? bcc;
  int? bmc;
  double? lat;
  double? long;
  int? altitude;
  int? akurasi;
  int? satelit;
  String? status;
  double? pitch;
  double? roll;
  int? bsDistance;
  String? chargetype;

  BasestatusEmbedded();

  factory BasestatusEmbedded.fromBasestatus(Basestatus data) {
    return BasestatusEmbedded()
      ..batteryVoltage = data.batteryVoltage
      ..batteryCurrent = data.batteryCurrent
      ..bcc = data.bcc
      ..bmc = data.bmc
      ..lat = data.lat
      ..long = data.long
      ..altitude = data.altitude
      ..akurasi = data.akurasi
      ..satelit = data.satelit
      ..status = data.status
      ..pitch = data.pitch
      ..roll = data.roll
      ..bsDistance = data.bsDistance
      ..chargetype = data.chargetype;
  }
}

@embedded
class RoverNodeDataEmbedded {
  int? length;
  int? opcode;
  int? errorBits;
  int? resetReason;
  int? restartNumber;
  int? uptime;
  int? sensorType;
  int? sensorID;
  int? accelX;
  int? accelY;
  int? accelZ;
  int? offsetX;
  int? offsetY;
  int? offsetZ;
  int? scaleRawX;
  int? scaleRawY;
  int? scaleRawZ;
  int? rawPitch;
  int? rawRoll;
  int? tempRaw;
  int? vinAdcRaw;
  int? adc5VRaw;
  int? rawBoom;
  int? rawStick;
  int? rawBucket;
  int? mainCounter;
  int? boomCounter;
  int? stickCounter;
  int? bucketCounter;
  int? canRxTimeout;
  int? gnss1Counter;
  int? gnss2Counter;
  int? bsStationRx;
  int? rs485Rx;
  int? sdCardCapacity;
  int? sdCardSpeed;
  int? crc16;

  RoverNodeDataEmbedded();

  factory RoverNodeDataEmbedded.fromRoverNodeData(RoverNodeData data) {
    return RoverNodeDataEmbedded()
      ..length = data.length
      ..opcode = data.opcode
      ..errorBits = data.errorBits
      ..resetReason = data.resetReason
      ..restartNumber = data.restartNumber
      ..uptime = data.uptime
      ..sensorType = data.sensorType
      ..sensorID = data.sensorID
      ..accelX = data.accelX
      ..accelY = data.accelY
      ..accelZ = data.accelZ
      ..offsetX = data.offsetX
      ..offsetY = data.offsetY
      ..offsetZ = data.offsetZ
      ..scaleRawX = data.scaleRawX
      ..scaleRawY = data.scaleRawY
      ..scaleRawZ = data.scaleRawZ
      ..rawPitch = data.rawPitch
      ..rawRoll = data.rawRoll
      ..tempRaw = data.tempRaw
      ..vinAdcRaw = data.vinAdcRaw
      ..adc5VRaw = data.adc5VRaw
      ..rawBoom = data.rawBoom
      ..rawStick = data.rawStick
      ..rawBucket = data.rawBucket
      ..mainCounter = data.mainCounter
      ..boomCounter = data.boomCounter
      ..stickCounter = data.stickCounter
      ..bucketCounter = data.bucketCounter
      ..canRxTimeout = data.canRxTimeout
      ..gnss1Counter = data.gnss1Counter
      ..gnss2Counter = data.gnss2Counter
      ..bsStationRx = data.bsStationRx
      ..rs485Rx = data.rs485Rx
      ..sdCardCapacity = data.sdCardCapacity
      ..sdCardSpeed = data.sdCardSpeed
      ..crc16 = data.crc16;
  }
}

@embedded
class SensorNodeDataEmbedded {
  int? length;
  int? opcode;
  int? sourceID;
  int? errorBits;
  int? resetReason;
  int? restartNumber;
  int? uptime;
  int? sensorType;
  int? sensorID;
  int? accelX;
  int? accelY;
  int? accelZ;
  int? offsetX;
  int? offsetY;
  int? offsetZ;
  int? scaleRawX;
  int? scaleRawY;
  int? scaleRawZ;
  int? errSensorRead;
  int? errSensorUncalib;
  int? errCANSendFail;
  int? tiltRaw;
  int? tempRaw;
  int? adc3V3Raw;
  int? adc5VRaw;
  int? mainCounter;
  int? boomCounter;
  int? stickCounter;
  int? bucketCounter;
  int? canRxTimeout;
  int? crc16;

  SensorNodeDataEmbedded();

  factory SensorNodeDataEmbedded.fromSensorNodeData(SensorNodeData data) {
    return SensorNodeDataEmbedded()
      ..length = data.length
      ..opcode = data.opcode
      ..sourceID = data.sourceID
      ..errorBits = data.errorBits
      ..resetReason = data.resetReason
      ..restartNumber = data.restartNumber
      ..uptime = data.uptime
      ..sensorType = data.sensorType
      ..sensorID = data.sensorID
      ..accelX = data.accelX
      ..accelY = data.accelY
      ..accelZ = data.accelZ
      ..offsetX = data.offsetX
      ..offsetY = data.offsetY
      ..offsetZ = data.offsetZ
      ..scaleRawX = data.scaleRawX
      ..scaleRawY = data.scaleRawY
      ..scaleRawZ = data.scaleRawZ
      ..errSensorRead = data.errSensorRead
      ..errSensorUncalib = data.errSensorUncalib
      ..errCANSendFail = data.errCANSendFail
      ..tiltRaw = data.tiltRaw
      ..tempRaw = data.tempRaw
      ..adc3V3Raw = data.adc3V3Raw
      ..adc5VRaw = data.adc5VRaw
      ..mainCounter = data.mainCounter
      ..boomCounter = data.boomCounter
      ..stickCounter = data.stickCounter
      ..bucketCounter = data.bucketCounter
      ..canRxTimeout = data.canRxTimeout
      ..crc16 = data.crc16;
  }
}

@embedded
class ErrorAlertEmbedded {
  String? sourceID;
  String? alertType;
  String? message;
  DateTime? timestamp;

  ErrorAlertEmbedded();

  factory ErrorAlertEmbedded.fromErrorAlert(ErrorAlert data) {
    return ErrorAlertEmbedded()
      ..sourceID = data.sourceID
      ..alertType = data.alertType
      ..message = data.message
      ..timestamp = data.timestamp;
  }
}
