# Equipment Calibration Blueprint

The Equipment Calibration feature is a multi-tab system designed to align machine sensors (Pitch, Roll, Tilt) and define physical geometry (Lengths, Offsets). It strictly follows the **"Calibration Layout"** (3:1 grid) and communicates with the MCU via real-time OpCodes.

## 1. Core Architecture
- **State Management**: uses Riverpod.
  - `comServiceProvider`: Manages USB connection state.
  - `calibStreamProvider`: Provides real-time `CalibrationData` (OpCode `0xD1`).
- **Presenter Pattern**: `CalibrationPresenter` handles command logic.
- **Protocol**:
  - **OpCode 0x52 (CALIBRATE)**: `[Mode (1 byte), Value1 (4 bytes Float32)]`. Used for start/stop/align.
  - **OpCode 0x53 (SET_PARAM)**: `[Type (1 byte), Value (2 bytes Int16, Little Endian)]`. Used for static geometry.

## 2. Global UI Standards
### 2.1 Calibration Layout (3:1 Grid)
- **Container**: `Padding(padding: EdgeInsets.all(16.0))` wrapping a `Row`.
- **Left Column** (`Expanded(flex: 3)`):
  - **Top Region (flex: 3)**: Image container (`Color(0xFF1E293B)`, 16px radius, dark green border). Hosts `images/calibrate_X.png`.
  - **Bottom Region (flex: 1)**: Control center for real-time sensor alignment.
- **Right Column** (`Expanded(flex: 1)`):
  - Parameter list with heading "PARAMETERS" and `ListView` of cards.

### 2.2 Reusable Components
- **Parameter Card**: Tappable tile showing Abbreviation, Title, and Value. Green accent for numeric values.
- **Editing Dialog**: `AlertDialog` with dark background and primary green "Set" button.
- **Notification**: `NotificationService.showCommandNotification` used for every successful or failed write operation.
- **Confirmation**: `DialogUtils.showConfirmationDialog` required for all "Reset" actions.

## 3. Top-Level Page Layout (`CalibrationPage`)
- **Controller**: `DefaultTabController` with `length: 5`.
- **Scaffold**:
  - **AppBar**:
    - Title: "EQUIPMENT CALIBRATION" with subtitle "EGS CALIBRATION V4.0.0".
    - Actions: `StatusBar` (RS232 & Config status) + `ProfileWidget`.
  - **TabBar**: Scrollable, highlighted with amber accent (`0xFFF59E0B` or similar theme accent).
  - **Body**: `TabBarView` containing the 5 specialized tabs.

## 4. Initialization & Cleanup
- **onInit**: Call `presenter.setConfig(port)` to put MCU into configuration mode.
- **onDispose**: Call `presenter.setNormal(port)` to return MCU to operational mode.

---

## Related Tab Specifications
- [Offset Calibration Tab](file:///c:/apps/toho_EGS/docs/template/setup/calibration/offset_calibration_tab.md)
- [Body Calibration Tab](file:///c:/apps/toho_EGS/docs/template/setup/calibration/body_calibration_tab.md)
- [Boom Calibration Tab](file:///c:/apps/toho_EGS/docs/template/setup/calibration/boom_calibration_tab.md)
- [Stick Calibration Tab](file:///c:/apps/toho_EGS/docs/template/setup/calibration/stick_calibration_tab.md)
- [Attachment Calibration Tab](file:///c:/apps/toho_EGS/docs/template/setup/calibration/attachment_calibration_tab.md)
