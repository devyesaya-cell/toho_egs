# Stick Calibration Detail

The Stick Calibration tab manages the secondary arm (Stick) angle and length.

## UI Reference
- **Graphic**: Side view concentrating on the Stick/Arm component (`images/calibrate_1.png`).
- **Layout**: Status value for Stick Tilt with "Calibrate" and "Reset" buttons.

## Parameters (OpCode 0x53)
Sent via `setParam(value, type)` using the right-side **PARAMETERS** list.

| Parameter | Type | Abbreviation | Description |
| :--- | :--- | :--- | :--- |
| **Stick Length** | 1 | SL | Physical length of the stick (dipper arm) from boom hinge to bucket hinge. |

## Calibration Actions (OpCode 0x52)
Sent via `calibrateCommand(value, mode)` using buttons in the **Bottom Control Region**.

| Action | Mode | Description |
| :--- | :--- | :--- |
| **Calibrate Stick Tilt** | 3 | Calibrates the stick sensor to a known reference angle. |
| **Reset Stick Tilt** | 67 | Reverts Stick Tilt to its factory sensor calibration. |
| **Start Accelero** | 22 | Begins noise-level calibration for the Stick IMU. |
| **Stop Accelero** | 42 | Finalizes and saves the Stick accelerometer calibration. |
| **Reset Accelero** | 62 | Clears the Stick accelerometer calibration data. |
