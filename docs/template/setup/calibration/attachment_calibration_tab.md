# Attachment Calibration Detail

The Attachment Calibration tab manages the bucket, I-Link, and H-Link geometry and positioning.

## UI Reference
- **Graphic**: Focused view of the bucket and linkage system (`images/calibrate_3.png`).
- **Layout**: Multi-control row for Bucket Tilt, I-Link Tilt, and Accelero.

## Parameters (OpCode 0x53)
Sent via `setParam(value, type)` using the right-side **PARAMETERS** list.

| Parameter | Type | Abbreviation | Description |
| :--- | :--- | :--- | :--- |
| **Bucket Length** | 2 | BCL | Distance from the bucket pin to the bucket tooth/tip. |
| **Bucket Width** | 4 | BCW | Total physical width of the bucket. |
| **I-Link Length** | 6 | ILK | Length of the I-Link (the link connected to the stick). |
| **H-Link Length** | 7 | HLK | Length of the H-Link (the link connected to the bucket). |
| **Bucket Pivot Disc** | 8 | BPD | Horizontal displacement offset for the bucket pivot point. |
| **Stick Pivot Disc** | 9 | SPD | Horizontal displacement offset for the stick pivot point. |

## Calibration Actions (OpCode 0x52)
Sent via `calibrateCommand(value, mode)` using buttons in the **Bottom Control Region**.

| Action | Mode | Description |
| :--- | :--- | :--- |
| **Calibrate Bucket Tilt** | 4 | Calibrates the bucket sensor to a known reference angle. |
| **Reset Bucket Tilt** | 68 | Reverts Bucket Tilt to its factory sensor calibration. |
| **Calibrate I-Link Tilt** | 5 | Calibrates the I-Link sensor for linkage-based guidance. |
| **Start Accelero** | 23 | Begins noise-level calibration for the Attachment IMU. |
| **Stop Accelero** | 43 | Finalizes and saves the Attachment accelerometer calibration. |
| **Reset Accelero** | 63 | Clears the Attachment accelerometer calibration data. |
