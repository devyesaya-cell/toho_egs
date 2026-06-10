import 'package:isar_community/isar.dart';

class Basestatus {
  Id id = 1010;

  // --- GNSS Status & Position ---
  double lat;
  double long;
  int altitude; // in mm
  int akurasi; // in mm
  int satelit;
  String status;
  int bsDistance; // in m

  // --- Battery & Power Diagnostics ---
  double batteryVoltage; // in V
  double batteryCurrent; // in A
  int bcc; // battery current capacity (%)
  int bmc; // battery max capacity (%)
  String chargetype; // Charging / Discharging

  // --- Attitude & Tilt ---
  double pitch; // in degrees
  double roll; // in degrees

  Basestatus({
    required this.lat,
    required this.long,
    required this.akurasi,
    required this.satelit,
    required this.status,
    required this.batteryVoltage,
    required this.batteryCurrent,
    required this.bcc,
    required this.bmc,
    required this.altitude,
    required this.pitch,
    required this.roll,
    this.bsDistance = 0,
    this.chargetype = "N/A",
  });

  // --- GNSS & Position Getters ---
  String get latFormatted => lat.toStringAsFixed(7);
  String get longFormatted => long.toStringAsFixed(7);
  String get coordinatesFormatted => '$latFormatted, $longFormatted';
  String get altitudeFormatted => '$altitude mm';
  String get accuracyFormatted => '$akurasi mm';
  String get distanceFormatted => '$bsDistance m';

  // --- Battery & Power Getters ---
  bool get isCharging => chargetype.toUpperCase() == 'CHARGING';
  String get batteryVoltageFormatted => '${batteryVoltage.toStringAsFixed(2)} V';
  String get batteryCurrentFormatted => '${batteryCurrent.toStringAsFixed(2)} A';
  String get bccFormatted => '$bcc%';
  String get bmcFormatted => '$bmc%';

  // --- Attitude & Tilt Getters ---
  // ANY value representing an Angle or Tilt MUST be visually capped at a max of 360.00 and formatted with °.
  String get pitchFormatted {
    final double capped = pitch > 360.0 ? 360.0 : pitch;
    return '${capped.toStringAsFixed(2)}°';
  }

  String get rollFormatted {
    final double capped = roll > 360.0 ? 360.0 : roll;
    return '${capped.toStringAsFixed(2)}°';
  }
}

