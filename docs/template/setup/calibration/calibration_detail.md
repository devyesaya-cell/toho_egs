# Equipment Calibration Detail

This document provides a granular blueprint for implementing the equipment calibration system (Body, Boom, Stick, Attachment, Offset).

## 1. Page Structure
- **Container**: `DefaultTabController` with 5 tabs.
- **Layout**: 3:1 Split (Calibration Layout).
- **Control Bottom (flex: 1)**:
  - `Pitch/Roll` value displays (using `Text` + degree symbol).
  - `Start/Stop Accelero` buttons (Toggle stream).
# Calibration Feature Detail

The Calibration page is a critical setup module used to align machine sensors (Pitch, Roll, Tilt) and define physical geometry (Lengths, Offsets). It follows a specialized **"Calibration Layout"** (3:1 split) and communicates with the MCU via real-time OpCodes.

## Calibration UI Structure
The page is organized into five specialized tabs, each targeting a specific component of the excavator:

- [**Offset Calibration**](file:///c:/apps/toho_EGS/docs/template/setup/calibration/offset_calibration_tab.md): Heading and top-view alignment.
- [**Body Calibration**](file:///c:/apps/toho_EGS/docs/template/setup/calibration/body_calibration_tab.md): Pitch, Roll, and Antenna offsets.
- [**Boom Calibration**](file:///c:/apps/toho_EGS/docs/template/setup/calibration/boom_calibration_tab.md): Boom tilt and geometry.
- [**Stick Calibration**](file:///c:/apps/toho_EGS/docs/template/setup/calibration/stick_calibration_tab.md): Stick tilt and geometry.
- [**Attachment Calibration**](file:///c:/apps/toho_EGS/docs/template/setup/calibration/attachment_calibration_tab.md): Bucket, I-Link, and H-Link detailing.

## Communication Protocol
Calibration actions use two primary OpCodes defined in `ProtocolService`:

### 1. CALIBRATE (OpCode 0x52)
Used for real-time sensor alignment (START/STOP) and reference setting.
- **Payload**: `[Mode (1 byte), Value1 (4 bytes Float32)]`
- **Logic**: Sent when "Calibrate", "Start", "Stop", or "Reset" buttons are pressed.

### 2. SET_PARAM (OpCode 0x53)
Used for saving static geometry values (Lengths, Offsets) to hardware memory.
- **Payload**: `[Type (1 byte), Value (2 bytes Int16, Little Endian)]`
- **Logic**: Sent when a Parameter Card is tapped and a new value is "Set" in the dialog.

---
## UI Standard
- **Layout**: 3:1 (Left: Reference Graphic & Controls, Right: Parameter List).
- **Styling**: `Color(0xFF1E293B)` surfaces, `Color(0xFF2ECC71)` success/values, `Color(0xFFEF4444)` errors/stops.
- **Components**: `StatusBar`, `Parameter Cards`, `FittedBox` images.
- **TextField**: Disabled border, background `0xFF0F1410`.
- **Validation**: Ensure values are correctly parsed as doubles before sending.

---
> [!CAUTION]
> Always verify that the "Config Active" indicator is green in the AppBar before sending calibration commands.
