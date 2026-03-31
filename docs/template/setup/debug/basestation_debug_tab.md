# Basestation Debug Tab Detail

The Basestation tab presents life-cycle and battery diagnostics for the local base station.

## Hardware Protocol
- **Source OpCode**: `0xD3` (Basestatus)
- **Model**: `Basestatus`

## Diagnostic Parameters
| Component | Parameters | Code Reference |
| :--- | :--- | :--- |
| **GNSS Status** | Status, Accuracy, Satellite Count | `status`, `akurasi`, `satelit` |
| **Position** | Altitude (mm), Latitude, Longitude | `altitude`, `lat`, `long` |
| **Battery** | Voltage (V), Current (A), Max Capacity (%), Current Capacity (%) | `batteryVoltage`, `batteryCurrent`, `bmc`, `bcc` |
| **Power** | Charging Type (e.g., Solar, DC) | `chargetype` |
| **Proximity** | Distance to Basestation (m) | `bsDistance` |

## UI Components
- **Grid Layout**: Row-based approach with 3 columns for battery and charging status.
- **Aesthetic**: Uses `FittedBox` scaled to `SizedBox(width: 280, height: 160)` to maintain dashboard proportions on varying screen sizes.
- **Accent Bar**: 8px wide right-side Primary Green bar.
