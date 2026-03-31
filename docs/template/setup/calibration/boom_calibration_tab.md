# Boom Calibration Detail

The Boom Calibration tab manages the main lift arm angle and physical boom geometry.

## UI Reference
- **Graphic**: Detailed side view concentrating on the Boom (`images/calibrate_2.png`).
- **Layout**: Status value for Boom Tilt with "Calibrate" and "Reset" buttons.

## Parameters (OpCode 0x53)
Sent via `setParam(value, type)` using the right-side **PARAMETERS** list.

| Parameter | Type | Abbreviation | Description |
| :--- | :--- | :--- | :--- |
| **Boom Length** | 0 | BL | Physical length of the boom from the main hinge to the stick hinge. |
| **Boom Base Height** | 10 | BBH | Vertical distance from the ground/track base to the main boom hinge pin. |

## Calibration Actions (OpCode 0x52)
Sent via `calibrateCommand(value, mode)` using buttons in the **Bottom Control Region**.

| Action | Mode | Description |
| :--- | :--- | :--- |
| **Calibrate Boom Tilt** | 2 | Calibrates the boom sensor to a known reference angle. |
| **Reset Boom Tilt** | 66 | Reverts Boom Tilt to its factory sensor calibration. |
| **Start Accelero** | 21 | Begins noise-level calibration for the Boom IMU. |
| **Stop Accelero** | 41 | Finalizes and saves the Boom accelerometer calibration. |
| **Reset Accelero** | 61 | Clears the Boom accelerometer calibration data. |
