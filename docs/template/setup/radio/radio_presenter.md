# Radio Presenter Blueprint

**Path**: `lib/features/setup/presenter/radio_presenter.dart`  
**Type**: State/Logic Controller  
**Class Name**: `RadioPresenter`

## 1. Overview
The `RadioPresenter` class acts as the intermediary between the UI (Radio Page) and the hardware integration layer (`ProtocolService`). It handles sending commands over the USB serial port to retrieve and set Radio configuration data (LORA settings).

## 2. Dependencies
- `package:flutter/material.dart` (for `debugPrint`).
- `package:usb_serial/usb_serial.dart` (for the `UsbPort` class).
- `ProtocolService` from `../../../core/protocol/protocol_service.dart`.

## 3. Core Functions

### A. `getRadioConfig(UsbPort? port)`
**Purpose**: Requests the active radio settings from the connected hardware. This will trigger updates to the `radioProvider` globally.

**Detailed Logic**:
1. **Port Validation**: If `port == null`, the process halts and outputs `debugPrint("Cannot get radio config, port is null.");`.
2. **Execution**: Inside a `try/catch` block, it calls `await _protocolService.getRadioConfig(port);`.
3. **Success**: Triggers `debugPrint("Radio configuration request sent successfully.");`.
4. **Error Handling**: Catches any exceptions and prints `"Error requesting radio configuration: $e"`.

### B. `setRadio`
**Signature**:
```dart
Future<void> setRadio(
  UsbPort? port, {
  required int channel,
  required int key,
  required int address,
  required int netID,
  required int airDataRate,
})
```
**Purpose**: Sends user-defined tuning parameters down to the radio hardware.

**Parameters (Required Named)**:
- `channel` (int): Wireless channel ID.
- `key` (int): Connection key / password (stored as int, converted hex internally).
- `address` (int): Device identity address.
- `netID` (int): Subnet identifier.
- `airDataRate` (int): Transmission speed index.

**Detailed Logic**:
1. **Port Validation**: If `port == null`, halt execution and output `debugPrint("Cannot set radio, port is null.");`.
2. **Execution**: Inside a `try/catch` block, it calls `await _protocolService.setRadio(...)` passing all named parameters down to the core service.
3. **Success**: Triggers `debugPrint("Radio configuration sent successfully.");`.
4. **Error Handling**: Catches any exceptions and prints `"Error sending radio configuration: $e"`.

---
> [!NOTE]  
> The Presenter DOES NOT modify Riverpod state directly. It relies on `ProtocolService` pushing commands over the hardware. The hardware then responds via serial broadcast, which is intercepted by a data listener in `ComService`, which then updates the `radioProvider`. This creates a reactive, uni-directional data flow.
