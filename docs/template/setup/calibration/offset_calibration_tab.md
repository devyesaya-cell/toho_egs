# Offset Calibration Detail

The Offset Calibration tab is used to align the machine's heading with the track for proper tracking and map orientation.

## UI Reference
- **Graphic**: Rotating excavator top-view (`images/exca2_top.png`) rotated by the `heading` value from `calibStreamProvider`.
- **Value Display**: A large digital display of the current **HEADING** value in degrees (°).

## Calibration Actions (OpCode 0x52)
These actions use the `calibrateCommand` logic via `CalibrationPresenter`.

| Action | Mode | Value1 | Description |
| :--- | :--- | :--- | :--- |
| **START** | 7 | 0.0 | Starts the 180-degree rotation calibration sequence. |
| **STOP** | 8 | 0.0 | Stops the sequence and calculates the final offset. |

## Calibration Workflow
1. **Initial Alignment**: Arahkan Boom/Arm excavator lurus ke depan, sejajar dengan track (roda rantai).
2. **Start Sequence**: Tekan tombol **START**. Status indikator pada AppBar akan menunjukkan "Config Active".
3. **Rotation**: Putar body excavator 180 derajat secara perlahan sampai posisi berlawanan arah dengan posisi awal (Arm membelakangi track).
4. **Stop & Save**: Tekan tombol **STOP**. Sistem akan menghitung offset heading dan menyimpannya secara otomatis ke memori hardware.
5. **Validation**: Periksa apakah nilai HEADING pada layar menunjukkan angka yang stabil dan sesuai dengan orientasi visual pada peta.
