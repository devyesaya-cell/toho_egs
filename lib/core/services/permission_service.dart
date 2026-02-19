import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PermissionService {
  Future<bool> requestAllPermissions() async {
    // 1. Storage Permissions (Android 10 - 13)
    bool storage = await _requestStoragePermission();

    // 2. Location Permissions
    Map<Permission, PermissionStatus> locationStatuses = await [
      Permission.location,
      Permission.locationAlways, // Or just whenInUse depending on requirement
    ].request();
    bool location =
        locationStatuses[Permission.location]?.isGranted == true ||
        locationStatuses[Permission.locationAlways]?.isGranted == true;

    // 3. Bluetooth Permissions (Android 12+)
    bool bluetooth = true;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 31) {
        Map<Permission, PermissionStatus> bleStatuses = await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.bluetoothAdvertise,
        ].request();
        bluetooth = bleStatuses.values.every((status) => status.isGranted);
      } else {
        // Android 11 and below use Location for BLE scanning
        bluetooth = await Permission.bluetooth.request().isGranted;
      }
    }

    // 4. Internet (Normal permission, usually auto-granted but good to check status if restrictive OS)
    // Internet is normal permission, doesn't require runtime request usually.

    return storage && location && bluetooth;
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      // Android 11+ (SDK 30+)
      if (androidInfo.version.sdkInt >= 30) {
        var status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          status = await Permission.manageExternalStorage.request();
        }
        return status.isGranted;
      } else {
        // Android 10 and below
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
        return status.isGranted;
      }
    }
    return true;
  }
}
