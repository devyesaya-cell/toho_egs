# RS232 Communication Service Detail

The backbone of hardware communication via USB/Serial and WebSocket synchronization.

## 1. Serial Port Management
- Uses `usb_serial` package.
- **Configuration**: 115200 Baud, 8 Data Bits, 1 Stop Bit, No Parity.
- **Auto-Connect**: Scans for specific product names (e.g., "CP2102N") to establish contact automatically.
- **Health Check**: `lastDataReceived` timestamp monitors connection liveness.

## 2. Packet Framing
- **Header**: Magic byte sequence `0x55, 0xAA, 0x55, 0xAA`.
- **Framing**: Uses `Transaction.magicHeader` to ensure valid packet extraction from the raw byte stream.

## 3. Byte Framing (Transaction.magicHeader)
- **Header**: `[0x55, 0xAA, 0x55, 0xAA]` (Indices 0-3)
- **Length**: Index 4
- **OpCode**: Index 5
- **Payload**: Indices 6 to (Packet Length - 3)
- **CRC16 (Little Endian)**: Last 2 bytes of the packet.

## 4. OpCode Payload Mapping (100% Coverage)

### 0xD0: Full GPS Telemetry (Indices 06-120)
| Offset | Field | Type | Scale | Description |
| :--- | :--- | :--- | :--- | :--- |
| 06-09 | BS Distance | Uint32 | 1 | Distance to base (mm). |
| 10-13 | Pitch | Float32 | 1 | Machine Pitch. |
| 14-17 | Roll | Float32 | 1 | Machine Roll. |
| 18-21 | Boom Tilt | Float32 | 1 | Boom Arm Angle. |
| 22-25 | Stick Tilt | Float32 | 1 | Stick Arm Angle. |
| 26-29 | Attach Tilt | Float32 | 1 | Attachment Angle. |
| 30-33 | Heading | Float32 | 1 | Machine Heading (True North). |
| 34-37 | MCU Voltage | Float32 | 1 | Board Voltage. |
| 38-41 | MCU Temp | Float32 | 1 | Board Temperature (°C). |
| 42 | RSSI | Int8 | 1 | Signal Strength (dBm). |
| 43-44 | Last Corr | Uint16 | 1 | Time since last correction. |
| 45-46 | Last Pkt | Uint16 | 1 | Last received Base packet #. |
| 47-48 | H Acc 1 | Uint16 | 1 | GNSS 1 Horizontal Accuracy. |
| 49-50 | V Acc 1 | Uint16 | 1 | GNSS 1 Vertical Accuracy. |
| 51 | Sat 1 | Uint8 | 1 | GNSS 1 Satellite count. |
| 53 | Status 1 | Uint8 | Enum | 0:NoRTK, 1:Float, 2:RTK_FIX. |
| 54-55 | H Acc 2 | Uint16 | 1 | GNSS 2 Horizontal Accuracy. |
| 56-57 | V Acc 2 | Uint16 | 1 | GNSS 2 Vertical Accuracy. |
| 58 | Sat 2 | Uint8 | 1 | GNSS 2 Satellite count. |
| 60 | Status 2 | Uint8 | Enum | 0:NoRTK, 1:Float, 2:RTK_FIX. |
| 61-64 | Bucket Lat | Int32 | 1E7 | Latitude / 10,000,000. |
| 65-68 | Bucket Lng | Int32 | 1E7 | Longitude / 10,000,000. |
| 69-72 | Track Hgt | Int32 | 1 | Track Height offset. |
| 73-76 | Boom Lat | Int32 | 1E7 | Boom Hinge Latitude. |
| 77-80 | Boom Lng | Int32 | 1E7 | Boom Hinge Longitude. |
| 81-84 | Boom Alt | Int32 | 1000 | Boom Hinge Local Altitude. |
| 85-88 | Stick Lat | Int32 | 1E7 | Stick Hinge Latitude. |
| 89-92 | Stick Lng | Int32 | 1E7 | Stick Hinge Longitude. |
| 93-96 | Stick Alt | Int32 | 1000 | Stick Hinge Local Altitude. |
| 97-100 | Attach Lat | Int32 | 1E7 | Attachment Hinge Latitude. |
| 101-104| Attach Lng | Int32 | 1E7 | Attachment Hinge Longitude. |
| 105-108| Attach Alt | Int32 | 1000 | Attachment Local Altitude. |
| 109-112| Tip Lat | Int32 | 1E7 | Bucket Tip Latitude. |
| 113-116| Tip Lng | Int32 | 1E7 | Bucket Tip Longitude. |
| 117-120| Tip Alt | Int32 | 1000 | Bucket Tip Local Altitude. |

### 0xD1: Full Calibration Data (Indices 06-92)
| Offset | Field | Type | Scale | Description |
| :--- | :--- | :--- | :--- | :--- |
| 06-09 | Packet ID | Uint32 | 1 | Configuration Version. |
| 10-13 | Pitch Off | Float32 | 1 | Calibrated Pitch. |
| 14-17 | Roll Off | Float32 | 1 | Calibrated Roll. |
| 18-21 | Boom Tilt | Float32 | 1 | Current Boom Angle. |
| 22-25 | Stick Tilt | Float32 | 1 | Current Stick Angle. |
| 26-29 | Bucket Tilt | Float32 | 1 | Current Bucket Angle. |
| 30-33 | I-Link Tilt| Float32 | 1 | I-Link Sensor Value. |
| 34-37 | Back Tilt | Float32 | 1 | Bucket Laydown Angle. |
| 38-39 | Boom Len | Uint16 | 1 | Physical BL Geometry. |
| 40-41 | Stick Len | Uint16 | 1 | Physical SL Geometry. |
| 42-43 | Bucket Len | Uint16 | 1 | Physical BCL Geometry. |
| 46-47 | Bucket Wid | Uint16 | 1 | BCW geometry. |
| 50-51 | I-Link Len | Uint16 | 1 | ILK geometry. |
| 52-53 | H-Link Len | Uint16 | 1 | HLK geometry. |
| 54-55 | BPD | Uint16 | 1 | Bucket Pivot Distance. |
| 56-57 | SPD | Uint16 | 1 | Stick Pivot Distance. |
| 58-59 | Base Hgt | Uint16 | 1 | Boom Base hinge height. |
| 60-61 | BCX | Int16 | 1 | Boom center X offset. |
| 62-63 | BCY | Int16 | 1 | Boom center Y offset. |
| 64-65 | ACX | Int16 | 1 | Axis center X offset. |
| 66-67 | ACY | Int16 | 1 | Axis center Y offset. |
| 68-69 | Ant Hgt | Uint16 | 1 | Antenna Vertical offset. |
| 70-71 | Ant Pole | Uint16 | 1 | Antenna Pole Height. |
| 80-83 | Heading | Float32 | 1 | Current Calibrated Heading. |
| 84-85 | H Acc 1 | Uint16 | 1 | GNSS 1 Accuracy. |
| 88-89 | H Acc 2 | Uint16 | 1 | GNSS 2 Accuracy. |
| 92 | Cal Status | Uint8 | 1 | Bitmask of active calibrations. |

### 0xD3: Full Basestatus (Indices 06-51)
| Offset | Field | Type | Scale | Description |
| :--- | :--- | :--- | :--- | :--- |
| 06-09 | Voltage | Float32 | 1 | Battery Volts level. |
| 10-13 | Current | Float32 | 1 | Battery Amps draw. |
| 14 | BCC | Uint8 | 1 | Battery Cell Count. |
| 15 | BMC | Uint8 | 1 | Battery Mode Code. |
| 16-23 | Latitude | Float64 | 1 | High-precision Lat. |
| 24-31 | Longitude | Float64 | 1 | High-precision Lng. |
| 32-35 | Altitude | Uint32 | 1 | AMSL height in mm. |
| 36-37 | Accuracy | Uint16 | 1 | Positional accuracy (mm). |
| 38 | Satelit | Uint8 | 1 | GNSS satellite count. |
| 39 | Pos Status | Uint8 | Enum | 0:NoFix...5:GNSS_FIX. |
| 41-44 | Pitch | Float32 | 1 | Base station tilt. |
| 45-48 | Roll | Float32 | 1 | Base station roll. |
| 49 | Chrg Type | Uint8 | 1 | 1:Charging, 0:Discharging. |
| 50-51 | Distance | Uint16 | 1 | Range from base to Rover. |

### 0x81: Send Acknowledge
- **06**: `SourceID` (0:Tablet, 1:Rover, 2:Boom, 3:Stick, 4:Bucket, 5:Plow).
- **07**: `AckOpcode` (Byte value of opcode acknowledged).
- **08**: `Status` (1: Success, 0: Failed).

### 0x83: Error Alert (Dynamic Payload)
| Type | Field | Byte | Type | Description |
| :--- | :--- | :--- | :--- | :--- |
| **0, 1** | Node Link | 08 | Uint8 | Source ID involved in link error. |
| **2** | Power | 08-11| Float32 | Current voltage level. |
| **3** | Restart | 08-09| Uint16 | Reason (1:Power, 3:Watchdog...). |
| **5** | Lagging | 08-11| Uint32 | Total delay in milliseconds. |

### 0x86: Radio Config
- **07**: Channel (Uint8).
- **08-09**: Encryption Key (Uint16).
- **10-11**: Address (Uint16).
- **12**: Network ID (Uint8).
- **13**: Air Data Rate (Uint8).

## 4. WebSocket Synchronization
- Acts as a client to the Basestation host (usually `192.168.100.69`).
- Syncs raw byte data or JSON payloads for remote monitoring and multi-tablet coordination.

---
> [!IMPORTANT]
> The `UsbState` is global; any widget can watch `comServiceProvider` to see if the hardware is live.
