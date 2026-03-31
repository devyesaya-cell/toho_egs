# Project Context: Toho EGS

## What is this?
The **Toho Excavator Guidance System (EGS)** is a high-precision tablet-based interface designed to provide real-time 2D/3D guidance for excavator operators. It acts as the central hub for sensor data visualization, job site management, and hardware calibration.

The application:
- Communicates with Rover/Basestation hardware via **RS232/USB** using a custom hex-based protocol.
- Provides real-time map guidance using `MapLibre` and GeoJSON/DXF workfiles.
- Manages operator authentication and shift-based activity logging.
- Includes granular hardware calibration (Bucket, Boom, Stick, Body) for sensor accuracy.

## Why does it exist?
- **Precision**: Enables operators to dig to exact grades and geometries without manual staking.
- **Safety**: Provides collision and proximity warnings (Rover/Basestation distance).
- **Efficiency**: Centralizes job file distribution and productivity tracking (Timesheets).
- **Usability**: Offers a premium, dual-themed (Dark/Light) industrial UI optimized for outdoor visibility.

## Scope
**In Scope**
- Real-time GPS/Telemetry parsing (OpCodes 0xD0, 0xD1, 0xD3).
- Map-based guidance for "Spot" and "Crumbling" operational modes.
- Local CRUD for Persons, Equipment, Areas, and Contractors using Isar.
- Multi-step hardware calibration and parameter synchronization (OpCodes 0x52, 0x53).
- Persistent work hour logging and historical diagnostics.

**Out of Scope**
- Direct hardware sensor fusion (handled by the ESP32/MCU firmware).
- Cloud-side GIS processing (Map data is imported as static GeoJSON/DXF).
- Real-time video streaming or remote excavator control.

## Target Users
- Excavator Operators (Guidance & Work Mode).
- Site Supervisors (Workfile management & Progress review).
- Field Technicians (Calibration & Hardware diagnostics).

## Tech Summary
- **UI Framework**: Flutter (Dart)
- **State Management**: Riverpod (MVVM / Presenter pattern)
- **Local Database**: `isar_community` (NoSQL)
- **Mapping**: `MapLibre` (Libre Map) with local GeoJSON support.
- **Communication**: custom `ComService` for serial/hex protocol handling.
- **Protocol Highlights**:
    - **0xD0**: GNSS Telemetry (Rover)
    - **0xD3**: Basestatus (Battery/Charging/Proximity)
    - **0x52**: Calibration Commands
    - **0x53**: Parameter Synchronization

# Project Context: Core User Flows

This document defines the high-level operational lifecycle of the Toho EGS system, detailing the standard transitions from machine boot to actual excavation guidance.

## 1. Authentication Flow (Operator Login)
The primary entry point where operators identify themselves and set the system's operational paradigm.

- **Trigger**: System boot-up launches `LoginPage`.
- **Identity**: Operators select their name from a pre-seeded database of `Person` objects via a dropdown.
- **Validation**: 6-digit (typically) Access Code validation against the `person.password` field in Isar.
- **Mode Selection**: Critical selection of **System Mode**:
    - **SPOT**: Standard bucket-positioning operation.
    - **CRUMBLING**: Specialized guidance for site-specific leveling/crumbling.
    - **MAINT**: Restricted mode for technicians and calibration.
- **Result**: State is updated in `authProvider`, and the user is navigated to the main functional hub based on their role/mode.

## 2. Dashboard Hub (Operational Overview)
Once logged in, the operator is presented with the `DashboardPage`, providing a high-level summary of the day's performance.

- **Purpose**: Real-time monitoring of productivity and quality.
- **Key Metrics**:
    - **Production**: Total area (Ha) or Count (Spots) completed vs Target.
    - **Productivity**: Current rate of work (Spots/Hr or m²/Hr).
    - **Precision**: Average deviation from the target grade/position (in cm).
- **Visuals**:
    - `ProgressCard`: Large radial/linear gauge showing goal completion.
    - `TrendChart`: Historical data points for the current session, identifying productivity dips.
- **Mode Context**: UI labels (e.g., "m²" vs "Spots") dynamically toggle based on the `SystemMode` (Crumbling vs Spot).

## 3. Job File Management (Workfile Hub)
Before operation can begin, a set of geographical or mathematical "guide" data must be selected.

- **Transition**: From Dashboard/Auth -> `WorkfilePage`.
- **Filtering**: The list of available `WorkFile` records is automatically filtered by the `SystemMode` selected during login.
- **Selection**: 
    - Tapping a `WorkfileCard` sets the `activeWorkfile` in the application state.
    - All subsequent sensor calculations on the Map will use this file's reference points.
- **Creation**: Operators or Supervisors can launch the `CreateWorkfilePage` to initialize new job sites/geometries.

## 4. Timesheet Lifecycle (Activity Logging)
Accurate logging of machine hours and operator activity is enforced throughout the session.

- **Navigation**: Access via the Bottom Navigation Bar -> `TimesheetPage`.
- **Activity Types**:
    - **ODT** (Operational Duty Time): Actual machine working hours (Digging, Loading).
    - **MDT** (Management Duty Time): Non-excavation time (Standby, Fueling, P2H).
- **Execution**:
    - **Start**: Selecting an activity and tapping **START ACTIVITY** initializes a persistent timer.
    - **Stop**: Tapping **STOP ACTIVITY** calculates the duration and saves a `TimesheetRecord`.
- **Review**: The **TIMESHEET VIEW** tab provides a list of today's records, automatically filtered by the current shift (Morning: 07:00-19:00, Night: 19:00-07:00).

## 5. Operational Guidance (The Map Flow)
The core working environment where sensors, GNSS, and job data converge for precision excavation.

### 5.1 Shift Initialization & Lifecycle
- **Shift Entry**: Upon entering `MapPage`, the system forces a `TimesheetStartDialog` if no active session is found, ensuring all productive hours are logged.
- **Data Integrity**: An automated 5-minute background loop auto-saves the current `TimesheetRecord` to the local Isar database, calculating real-time `workspeed` (Ha/hr) and `totalSpots`.
- **Termination**: Exiting the map triggers the `TimesheetEndDialog` to record the final Hour Meter (HM) and finalize work counters.

### 5.2 Standby vs. Work Mode Transitions
- **Standby Mode (Explorer)**:
    - **Interactivity**: User is free to pan/zoom. Navigation gestures are active.
    - **Camera**: Performs a single initial auto-center on the excavator's position.
    - **Focus**: Strategic site overview without active guidance overlays.
- **Work Mode (Precision Guidance)**:
    - **Lock-to-Machine**: Map gestures are locked (`AbsorbPointer`) to prevent accidental panning during high-vibration operation. 
    - **Slaved Camera**: The camera continuously tracks the excavator's GNSS position and heading (OpCode 0xD0/0xD3) for hands-free visibility.
    - **Automated HUD**: Guidance bars (SPOT/CRUMBLING) appear based on the system's active mode.

### 5.3 System Mode Logic
The guidance engine adapts its calculation branch based on the `SystemMode`:

#### A. SPOT Mode (Point-to-Point)
Targeting discrete point locations (e.g., piling, soil sampling).
1.  **Scanning**: Identifies uncompleted spots (`status=0`) within a **7.5m** radius of the machine body.
2.  **Targeting**: Prioritizes the closest spot within **0.5m** of the **Bucket Attachment** (`attachLng`, `attachLat`).
3.  **Auto-Complete**: A spot is marked "Done" (`status=1`) if the bucket maintains proximity $\le$ **0.1m (10cm)** for a configurable duration (default **2s**). 

#### B. CRUMBLING Mode (Segment-to-Line)
Guidance for continuous line or trench excavation using segment nodes.
1.  **Scanning**: Identifies line segments (joined nodes with matching `spotID`) within a **20m** radius.
2.  **Targeting**: Slaves guidance to the closest line segment within **3m** of the excavator.
3.  **Cross-Track Error (X-Deviation)**: Calculates the left/right deviation from the bucket center to the line segment. The value is projected relative to the machine's heading.
4.  **Auto-Complete**: Records are finalized when the excavator exits the active segment and crosses the threshold into the next node chain.

## 6. Equipment Calibration Flow

The Equipment Calibration system is a hardware-integrated configuration layer that allows operators to synchronize physical excavator geometry and sensor offsets with the system's internal model.

### 6.1 Calibration Lifecycle (Entry/Exit)
Calibration requires the hardware to be in a specific "Configuration Mode" to accept parameter writes.
*   **Entry**: Navigating to the Calibration Page triggers `CalibrationPresenter.setConfig()`.
    *   **OpCode 0x50**: Payload `[0x02]` (Configuration Mode).
*   **Exit**: Disposing the page (navigating back) triggers `CalibrationPresenter.setNormal()`.
    *   **OpCode 0x50**: Payload `[0x01]` (Normal Operational Mode).

### 6.2 Tab-Specific Workflows

#### A. Offset Calibration (180° Method)
Used to calibrate the heading/azimuth of the GNSS antennas relative to the excavator chassis.
1.  **Alignment**: Align the excavator arm perfectly parallel to the tracks.
2.  **Start**: Press **START** button.
    *   **OpCode 0x52**: Mode `7`, Value `0.0`.
3.  **Rotation**: Spin the excavator body roughly 180 degrees.
4.  **Stop**: Press **STOP** button.
    *   **OpCode 0x52**: Mode `8`, Value `0.0`.
    *   The system calculates the heading offset based on the rotation delta.

#### B. Body Calibration
Configures the main chassis sensors and GNSS antenna positions.
*   **Parameters (OpCode 0x53)**:
    *   `BCX/BCY` (Type 11/12): Boom Center Offset.
    *   `ACX/ACY` (Type 13/14): Axis Center Offset.
    *   `Ant Height/Pole` (Type 15/16): GNSS Antenna height data.
*   **Actions (OpCode 0x52)**:
    *   **Calibrate Pitch (Mode 0)**: Zeros the pitch sensor at a known level.
    *   **Calibrate Roll (Mode 1)**: Zeros the roll sensor at a known level.
    *   **Accelero Start/Stop (Mode 20/40)**: Calibrates the raw accelerometer biases.

#### C. Boom & Stick Calibration
Defines the physical lengths of the primary joints.
*   **Parameters (OpCode 0x53)**:
    *   `Boom Length` (Type 0) & `Base Height` (Type 10).
    *   `Stick Length` (Type 1).
*   **Actions (OpCode 0x52)**:
    *   **Calibrate Tilt (Mode 2/3)**: Zeros the sensor when the boom/stick is in a vertical reference position.
    *   **Accelero Start/Stop**: Calibrates the IMUs for each joint (Boom: Mode 21/41, Stick: Mode 22/42).

#### D. Attachment (Bucket) Calibration
Configures complex linkage geometry for accurate teeth positioning.
*   **Parameters (OpCode 0x53)**:
    *   `Bucket Length/Width` (Type 2/4).
    *   `Linkage` (I-Link Type 6, H-Link Type 7).
    *   `Pivot Offsets` (BPD Type 8, SPD Type 9).
*   **Actions (OpCode 0x52)**:
    *   **Dual-Tilt Calibration**: Calibrates the Bucket sensor (Mode 4) and I-Link sensor (Mode 5).
    *   **Accelero Start/Stop (Mode 23/43)**: Calibrates the bucket IMU.

### 6.3 Parameter Persistence
All parameters updated via the "Parameter Cards" use **OpCode 0x53**. The MCU acknowledges these writes, and the UI displays a success notification. Real-time feedback for angles and offsets is provided via a serial data stream (OpCode 0xD2/0xD1) displayed in the live gages.

## 7. System Diagnostics (Debug Flow)

The Debug system provides a real-time introspection layer for technicians to monitor hardware health and communication integrity.

### 7.1 Rover & Basestation Telemetry
*   **Rover Debug**: Displays live `GPSLoc` data (OpCode 0xD0/0xD1).
    *   **GNSS**: Status (Fix type), horizontal/vertical accuracy, and satellite count for both antennas.
    *   **Vitals**: MCU Voltage and Temperature.
    *   **Radio RSSI**: Signal strength and age of the last correction/base packet.
*   **Basestation Debug**: Displays live `Basestatus` data (OpCode 0xD3).
    *   **BMS**: Battery voltage, current, and capacity (BMC/BCC).
    *   **Proximity**: Real-time distance between Rover and Basestation to prevent collisions.

### 7.2 Alert Log Hub
A synchronized historical record of `ErrorAlert` objects.
*   **Source Tracking**: Alerts are tagged by origin (Rover, Tablet Pair, Boom, Stick, Bucket).
*   **Persistence**: Alerts are buffered in the `errorProvider` and displayed in a formatted table for post-session analysis.

## 8. Resource Management Flow (CRUD)

Operational efficiency depends on the accurate configuration of site resources, managed through the `ManagementPage` using the `AppRepository` (Isar DB).

### 8.1 Key Management Entities
*   **Persons**: Operators registered with specific roles (Admin/Supervisor/Operator) and default `SystemMode` presets.
*   **Workfiles**: Digital blueprints (GeoJSON) used as guidance reference. Deletion is restricted to higher-level roles.
*   **Areas & Targets**: Geographical site boundaries with production targets (Luas Ha, Target Days).
*   **Equipment**: Machine profiles including physical models (Hitachi, Komatsu) and excavator-specific joint lengths.
*   **Contractors**: Business entities managing various equipment fleets.
*   **Timesheet Data**: Library of MDT/ODT activity types (e.g., P2H, Digging, Standby) for selection in the main Timesheet flow.

## 9. Advanced System Configuration

Specialized configuration layers for hardware-level communication and high-level operational logic.

### 9.1 Radio Configuration Flow
Managed via the `RadioPage`, allowing operators to set the communication parameters for the RS232 radio module.
*   **GET (Request Config)**: Sends **OpCode 0x0C** to the hardware to retrieve current settings.
*   **SET (Update Config)**: Sends **OpCode 0x0B** with a payload containing:
    *   `Channel`, `Key`, `Address`, `NetID`, and `Air Data Rate`.
*   **Confirmation**: The UI updates the "LIVE" status indicator upon receiving a successful acknowledgment.

### 9.2 Operational Work Configuration
A specialized grid-based interface (`WorkConfigPage`) for setting high-level operational offsets.
*   **Parameter Mapping (OpCode 0x56)**:
    - `0: GNSS Altitude Ref`: MSL vs Ellipsoid.
    - `1: Altitude Reference`: GNSS vs OGL (Original Ground Level).
    - `2: Bucket Length Ref`: Teeth vs Back of bucket.
    - `3: Bucket Horiz Ref`: Center vs Left/Right teeth.
    - `4: Pitch Compensation`: Toggle for sensor tilt compensation.

### 9.3 Data Synchronization (Sync Flow)
Automated background task managed by `SyncPresenter` to bridge the tablet's local Isar database with the remote host.
*   **Progress Tracking**: Visual feedback for "Data Packets" in the queue.
*   **Status States**: Completed (Green check), Uploading (Progress bar), Waiting (Queue).
*   **Payloads**: Includes telemetry logs, guidance paths, and operator notes gathered during shifts.
