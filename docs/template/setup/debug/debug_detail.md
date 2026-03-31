# System# Debug Feature Detail

The Debug page provides real-time telemetry, hardware status, and historical error logs for diagnostic purposes. It uses a `DefaultTabController` with a scrollable `TabBar` and displays system versioning information in the `AppBar`.

## Page Structure
- **AppBar Section**: Displays "DEBUG" and "EGS DEBUG V4.0.0" subtitle.
- **TabBar**: Scrollable, containing 3 diagnostic tabs.
- **View**: A `TabBarView` hosting specialized debug widgets.

## Diagnostic Tabs
- [**ROVER**](file:///c:/apps/toho_EGS/docs/template/setup/debug/rover_debug_tab.md): Real-time Rover GNSS data, power, and radio telemetry (OpCode 0xD0).
- [**BASESTATION**](file:///c:/apps/toho_EGS/docs/template/setup/debug/basestation_debug_tab.md): Basestation battery, charging, and GNSS status (OpCode 0xD3).
- [**ALERT**](file:///c:/apps/toho_EGS/docs/template/setup/debug/alert_debug_tab.md): Historical log of system-wide errors and warnings.

## UI Generation Rules
- **Dashboard Aesthetic**: Rover and Basestation use large, green-accented cards with high-contrast labels.
- **Color Coding**: Critical status values (e.g., FIX, FLOAT) and error sources have predefined color mappings for quick visual identification.
- **Streams**: Continuously listens to `gpsStreamProvider` and `bsProvider` for live updates.
 (use monospaced fonts if possible).

---
> [!WARNING]
> The Debug page is intended for maintenance and should only be accessible to authorized technicians.
