# Body Calibration Detail

The Body Calibration tab manages the core machine orientation (Pitch/Roll) and GNSS antenna offsets.

## UI Reference
- **Graphic**: Side-view of the machine body (`images/calibrate_1.png`).
- **Layout**: Status values for Pitch and Roll with "Calibrate" and "Reset" buttons.
- **Bottom Actions**: Accelero Calibration Start/Stop/Reset.

## Parameters (OpCode 0x53)
Sent via `setParam(value, type)` using the right-side **PARAMETERS** list.

| Parameter | Type | Abbreviation | Description |
| :--- | :--- | :--- | :--- |
| **Antenna Height** | 15 | Ant Height | Vertical height from the ground/track base to the GPS antenna. |
| **Boom Center X** | 11 | BCX | Horizontal offset from the rotation center to the boom hinge pin. |
| **Boom Center Y** | 12 | BCY | Vertical offset from the ground to the boom hinge pin. |
| **Axis Center X** | 13 | ACX | Offset X for the GNSS antenna relative to the rotation axis. |
| **Axis Center Y** | 14 | ACY | Offset Y for the GNSS antenna relative to the rotation axis. |
| **Antenna Pole** | 16 | Ant Pole Height | Physical height of the antenna pole mount. |

## Calibration Actions (OpCode 0x52)
Sent via `calibrateCommand(value, mode)` using buttons in the **Bottom Control Region**.

| Action | Mode | Description |
| :--- | :--- | :--- |
| **Calibrate Pitch** | 0 | Sets the current longitudinal tilt as the zero reference. |
| **Calibrate Roll** | 1 | Sets the current lateral tilt as the zero reference. |
| **Reset Pitch** | 64 | Reverts Pitch calibration to factory sensor defaults. |
| **Reset Roll** | 65 | Reverts Roll calibration to factory sensor defaults. |
| **Start Accelero** | 20 | Begins the 3rd-party accelerometer noise-level calibration. |
| **Stop Accelero** | 40 | Finalizes and saves the accelerometer calibration. |
| **Reset Accelero** | 60 | Clears stored accelerometer calibration data. |
