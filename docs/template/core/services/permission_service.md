# Permission Service Detail

Centralized management for system-level hardware permissions.

## 1. Permission Groups
- **Storage**:
  - Android 11+ (SDK 30+): Requires `Permission.manageExternalStorage` for full file access.
  - Android 10 and below: Uses standard `Permission.storage`.
- **Location**:
  - Requires `Permission.location` and `Permission.locationAlways` for background RTK tracking.
- **Bluetooth (BLE)**:
  - Android 12+ (SDK 31+): Requires `bluetoothScan`, `bluetoothConnect`, and `bluetoothAdvertise`.
  - Older versions: Inherits from Location permissions for BLE scanning.

## 2. Best Practices
- Always call `requestAllPermissions()` during the initial app splash or first login.
- Check `Platform.isAndroid` before requesting SDK-specific permissions like `manageExternalStorage`.

---
> [!WARNING]
> Denying these permissions will break core features like RS232 communication, GPS tracking, and GeoJSON ingestion.
