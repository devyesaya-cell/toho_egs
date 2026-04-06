# Work Config Presenter Blueprint

**Path**: `lib/features/setup/pages/work_config_presenter.dart`  
**Type**: State/Logic Controller  
**Class Name**: `WorkConfigPresenter`

## 1. Overview
The `WorkConfigPresenter` class handles the state management (via Riverpod Notifier) for the Work Configuration settings. It constructs and sends serial commands to update hardware parameters while maintaining a local state copy for immediate UI responsiveness.

## 2. Model: `WorkConfigState`
```dart
class WorkConfigState {
  final WorkConfig config;
  WorkConfigState({this.config = const WorkConfig()});
  WorkConfigState copyWith({WorkConfig? config});
}
```

## 3. Core Function: `setWorkConfigParam(int index, int value)`
**Purpose**: Update a specific configuration parameter on the hardware and in the local state.

### Implementation Logic:
1.  **Command Construction**:
    - **Header**: `[0xAA, 0x55, 0xAA, 0x55]`
    - **Length**: `0x05`
    - **Opcode**: `0x56`
    - **Index**: User-selected index (0-4).
    - **Value**: User-selected value.
2.  **CRC16 Calculation**:
    - Calculates CRC16 for the payload starting from the length byte: `[0x05, 0x56, index, value]`.
    - **Algorithm**: CRC16 IBM variant (poly: 0xA001).
3.  **Serial Transmission**:
    - Sends the full packet: `[Header, Length, Opcode, Index, Value, CRCLow, CRCHigh]`.
    - Utilizes `ref.read(comServiceProvider).port` for writing.
4.  **State Synchronization**:
    - Updates local `WorkConfig` state via `state.config.copyWith(...)`.
    - Mapping:
        - `0`: `gnssAltRef`
        - `1`: `altRef`
        - `2`: `bucketLenRef`
        - `3`: `bucketHorizRef`
        - `4`: `pitchComp`

## 4. Helper: `_calCRC16(List<int> bytes)`
**Algorithm Reference**:
```dart
int _calCRC16(List<int> bytes) {
  int crc = 0xFFFF;
  for (int byte in bytes) {
    crc ^= byte;
    for (int i = 0; i < 8; i++) {
      if ((crc & 1) != 0) {
        crc = (crc >> 1) ^ 0xA001;
      } else {
        crc >>= 1;
      }
    }
  }
  return crc;
}
```

---
> [!NOTE]
> The Presenter is initialized via `NotifierProvider<WorkConfigPresenter, WorkConfigState>`, providing a centralized point of truth for the `WorkConfigPage`.
