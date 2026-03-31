# Rover Debug Tab Detail

The Rover tab displays live telemetry parsed from the Rover station's hardware stream.

## Hardware Protocol
- **Source OpCode**: `0xD0` (GPS Telemetry)
- **Presenter**: Data formatted via `DebugPresenter` (e.g., `formatTime` for correction packets).

## Diagnostic Parameters
| Component | Parameters | Code Reference |
| :--- | :--- | :--- |
| **GNSS 1** | Status, H-Acc, V-Acc, Satellite Count | `status`, `hAcc1`, `vAcc1`, `satelit` |
| **GNSS 2** | Status, H-Acc, V-Acc, Satellite Count | `status2`, `hAcc2`, `vAcc2`, `satelit2` |
| **Power** | Voltage (V), MCU Temperature (°C) | `mcuVoltage`, `mcuTemperature` |
| **Radio** | RSSI (dBm), Last Correction (s), Last Packet (s) | `rssi`, `lastCorrection`, `lastBasePacket` |
| **Position** | Track Height (mm), Latitude, Longitude | `trackHeight`, `boomLat`, `boomLng` |

## UI Components
- **Card Template**: Responsive container with `Color(0xFF1E293B)`, `Border.all(color: Color(0xFF2ECC71))`, and a 20px wide right-side Primary Green accent bar.
- **Icons**: Standardized (satellite_alt, battery_charging_full, cell_tower, location_on).
