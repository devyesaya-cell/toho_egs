class GPSLoc {
  final double boomLat;
  final double boomLng;
  final double boomAlt;
  final double stickLat;
  final double stickLng;
  final double stickAlt;
  final double attachLat;
  final double attachLng;
  final double attachAlt;
  final double tipLat;
  final double tipLng;
  final double tipAlt;
  final int hAcc1;
  final int vAcc1;
  final int satelit;
  final String status;
  final double heading;
  final double pitch;
  final double roll;
  final int trackHeight;
  final double bucketLat;
  final double bucketLong;
  final int hAcc2;
  final int vAcc2;
  final int satelit2;
  final String status2;
  final int rssi;
  final int bsDistance;
  final double boomTilt;
  final double stickTilt;
  final double attachTilt;
  final int lastCorrection;
  final int lastBasePacket;
  final double mcuVoltage;
  final double mcuTemperature;

  GPSLoc({
    required this.boomLat,
    required this.boomLng,
    required this.boomAlt,
    required this.stickLat,
    required this.stickLng,
    required this.stickAlt,
    required this.attachLat,
    required this.attachLng,
    required this.attachAlt,
    required this.tipLat,
    required this.tipLng,
    required this.tipAlt,
    required this.hAcc1,
    required this.vAcc1,
    required this.satelit,
    required this.status,
    required this.heading,
    required this.pitch,
    required this.roll,
    required this.trackHeight,
    required this.bucketLat,
    required this.bucketLong,
    required this.hAcc2,
    required this.vAcc2,
    required this.satelit2,
    required this.status2,
    required this.rssi,
    required this.bsDistance,
    required this.boomTilt,
    required this.stickTilt,
    required this.attachTilt,
    required this.lastCorrection,
    required this.lastBasePacket,
    required this.mcuVoltage,
    required this.mcuTemperature,
  });
}
