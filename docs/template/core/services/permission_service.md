# Permission Service — Blueprint

**File**: `lib/core/services/permission_service.dart`  
**Class**: `PermissionService` (instantiable, no state)

_Handles runtime permission requests for Storage, Location, and Bluetooth. Includes Android API-level-aware branching for correct permission handling across Android versions._

---

## Imports Required

```dart
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
```

## Dependencies

| Package              | Usage                                                         |
|----------------------|---------------------------------------------------------------|
| `permission_handler` | `Permission`, `PermissionStatus` — runtime permission requests |
| `device_info_plus`   | `DeviceInfoPlugin().androidInfo` — read Android SDK version   |
| `dart:io`            | `Platform.isAndroid` — platform guard                        |

---

## Class Structure

```dart
class PermissionService {
  Future<bool> requestAllPermissions() async { ... }
  Future<bool> _requestStoragePermission() async { ... }
}
```

---

## Method 1: `requestAllPermissions` (Public)

The single entry-point for all permission requests. Requests Storage, Location, and Bluetooth in sequence. Returns `true` only if **all three categories** are granted.

```dart
Future<bool> requestAllPermissions() async {
  // 1. Storage
  bool storage = await _requestStoragePermission();

  // 2. Location
  Map<Permission, PermissionStatus> locationStatuses = await [
    Permission.location,
    Permission.locationAlways,
  ].request();
  bool location =
      locationStatuses[Permission.location]?.isGranted == true ||
      locationStatuses[Permission.locationAlways]?.isGranted == true;

  // 3. Bluetooth
  bool bluetooth = true;
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 31) {
      // Android 12+ requires granular BLE permissions
      Map<Permission, PermissionStatus> bleStatuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.bluetoothAdvertise,
      ].request();
      bluetooth = bleStatuses.values.every((status) => status.isGranted);
    } else {
      // Android 11 and below: use legacy Permission.bluetooth
      bluetooth = await Permission.bluetooth.request().isGranted;
    }
  }

  return storage && location && bluetooth;
}
```

**Returns**: `bool` — `true` only when Storage AND Location AND Bluetooth are all granted.

---

## Bluetooth Permission Logic by SDK Version

| Android SDK | SDK Int | Permissions Requested                                                     |
|-------------|---------|---------------------------------------------------------------------------|
| Android 12+ | ≥ 31    | `bluetoothScan`, `bluetoothConnect`, `bluetoothAdvertise` (all must pass) |
| Android ≤ 11| < 31    | `bluetooth` (single legacy permission)                                    |
| iOS / Other | —       | `bluetooth = true` (skipped, always granted)                              |

> [!NOTE]
> On non-Android platforms (iOS), `bluetooth` is always set to `true` without any request. The `if (Platform.isAndroid)` guard ensures this service is safe to call on any platform.

---

## Location Permission Logic

```dart
bool location =
    locationStatuses[Permission.location]?.isGranted == true ||
    locationStatuses[Permission.locationAlways]?.isGranted == true;
```

Both `Permission.location` (while in use) and `Permission.locationAlways` (background) are requested simultaneously. The result is `true` if **either one** is granted. This allows the app to function when the user grants only "while in use" instead of "always".

---

## Method 2: `_requestStoragePermission` (Private)

Handles Android's split storage permission model for different SDK versions.

```dart
Future<bool> _requestStoragePermission() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (androidInfo.version.sdkInt >= 30) {
      // Android 11+ (SDK 30+) — uses MANAGE_EXTERNAL_STORAGE
      var status = await Permission.manageExternalStorage.status;
      if (!status.isGranted) {
        status = await Permission.manageExternalStorage.request();
      }
      return status.isGranted;
    } else {
      // Android 10 and below — uses READ/WRITE_EXTERNAL_STORAGE
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    }
  }
  return true;  // Non-Android always returns true
}
```

### Storage Permission by SDK Version

| Android SDK | SDK Int | Permission Used                | Notes                                                 |
|-------------|---------|--------------------------------|-------------------------------------------------------|
| Android 11+ | ≥ 30    | `manageExternalStorage`        | Checks status first before requesting                 |
| Android ≤ 10| < 30    | `storage`                      | Checks status first before requesting                 |
| iOS / Other | —       | _(none)_                       | Always returns `true`                                 |

> [!IMPORTANT]
> The logic checks the **current status first** before re-requesting, to avoid showing the permission dialog repeatedly if it was already granted.

---

## Typical Usage

```dart
// In Landing Page or App startup
final permissionService = PermissionService();
final granted = await permissionService.requestAllPermissions();

if (!granted) {
  // Show warning or redirect user to app settings
  openAppSettings(); // from permission_handler
}
```

## Required `pubspec.yaml` Packages

```yaml
dependencies:
  permission_handler: ^12.x.x    # or latest compatible
  device_info_plus: ^10.x.x      # or latest compatible
```

## Required Android Manifest Entries (`android/app/src/main/AndroidManifest.xml`)

```xml
<!-- Storage -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />

<!-- Location -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

<!-- Bluetooth (Android 12+) -->
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />

<!-- Bluetooth (Legacy) -->
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
```

> [!CAUTION]
> `MANAGE_EXTERNAL_STORAGE` is a special permission on Android 11+. The user is directed to a system settings screen (not a standard dialog). The `permission_handler` package handles this navigation automatically via `.request()`.
