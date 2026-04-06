# Toho EGS — C4 Level 1: System Context Diagram

Shows the Toho EGS system as a single box and its interactions with all external actors and systems.

```mermaid
C4Context
    title System Context Diagram — Toho EGS

    Person(operator, "Excavator Operator", "Operates the excavator, logs timesheets, follows on-screen 2D/3D guidance to dig to precise grades.")
    Person(supervisor, "Site Supervisor", "Manages workfiles, reviews productivity dashboards, configures job sites.")
    Person(technician, "Field Technician", "Calibrates hardware sensors, configures radio/wireless, diagnoses system alerts via Debug tools.")

    System(egs, "Toho EGS", "Android tablet application providing real-time excavation guidance, sensor calibration, productivity tracking, and hardware diagnostics.")

    System_Ext(mcu, "ESP32 MCU", "Embedded firmware on the excavator. Fuses GNSS + IMU sensor data and streams telemetry via RS232 to the tablet.")
    System_Ext(basestation, "GNSS Basestation", "Provides RTK correction data to the Rover via LoRa radio. Also available as a WebSocket sync host for multi-tablet coordination.")
    System_Ext(gnss, "Dual GNSS Receivers", "Two u-blox antennas on the excavator providing position and heading data to the MCU.")
    System_Ext(imu_sensors, "IMU Sensor Array", "Accelerometers/gyroscopes on Boom, Stick, Bucket, and Body measuring tilt angles for the MCU.")

    Rel(operator, egs, "Authenticates, selects workfiles, views map guidance, logs timesheet activities")
    Rel(supervisor, egs, "Creates workfiles, manages operators/equipment/areas, reviews dashboard KPIs")
    Rel(technician, egs, "Calibrates sensors, configures radio, monitors Rover/Base debug telemetry")

    Rel(egs, mcu, "Sends commands via USB RS232", "OpCodes: 0x50, 0x52, 0x53, 0x0B, 0x0C")
    Rel(mcu, egs, "Streams telemetry via USB RS232", "OpCodes: 0xD0, 0xD1, 0xD2, 0xD3, 0x81, 0x83, 0x86")
    Rel(gnss, mcu, "Position + heading fixes", "UART")
    Rel(imu_sensors, mcu, "Tilt angles (pitch, roll, boom, stick, bucket)", "I2C/SPI")
    Rel(basestation, mcu, "RTK correction data", "LoRa radio link")
    Rel(egs, basestation, "Sync data for multi-tablet coordination", "WebSocket ws://192.168.100.69:8080")
```

## Actors

| Actor | Role | Primary Interactions |
|-------|------|---------------------|
| **Excavator Operator** | Day-to-day user | Login, Map Guidance (Spot/Crumbling), Timesheet Start/Stop, Dashboard review |
| **Site Supervisor** | Management role | Workfile creation, Person/Equipment/Area CRUD, Dashboard productivity review |
| **Field Technician** | Hardware specialist | Calibration (Body/Boom/Stick/Bucket), Radio Config, Debug telemetry, Maintenance mode |

## External Systems

| System | Communication | Protocol |
|--------|--------------|----------|
| **ESP32 MCU** | USB RS232 (CP2102N) | Custom binary: `[55,AA,55,AA][Len][OpCode][Payload][CRC16]` |
| **GNSS Basestation** | LoRa Radio (to MCU) + WebSocket (to Tablet) | RTK corrections + JSON/binary sync |
| **Dual GNSS Receivers** | UART to MCU | u-blox UBX protocol |
| **IMU Sensor Array** | I2C/SPI to MCU | Raw accelerometer/gyroscope data |
