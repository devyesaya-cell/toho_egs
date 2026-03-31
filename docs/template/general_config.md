# Project General Configuration Template

This document serves as the entry point for generating a new project. Edit the sections below to define the scope and requirements of the new application.

## 1. Project Identity
- **Name**: [Project Name]
- **Description**: [Brief description of the app's purpose]
- **Base Version**: 1.0.0

## 2. Core Features
List the features to be implemented. Each feature corresponds to a module in `lib/features/`.
- [ ON ] **Dashboard**: Real-time telemetry, bucket positioning, and machine status.
- [ ON ] **Map**: MapLibre integration, GeoJSON job sites, and guidance logic.
- [ ON ] **Workfile**: Project selection, area configuration, and spot management.
- [ ON ] **Timesheet**: Operator work logging, shift tracking, and activity analysis.
- [ ON ] **Alarm / Voice**: Offline command logs, STT/TTS, and system alerts.
- [ ON ] **Setup / Management**:
    - [ ON ] **Calibration**: 3:1 layout for Pitch, Roll, and Bucket sensors.
    - [ ON ] **Work Config**: Machine geometry and antenna offsets.
    - [ ON ] **Radio**: Hardware frequency and protocol configuration.
    - [ ON ] **Sync**: WebSocket data exchange and remote monitoring.
    - [ ON ] **Debug**: Log tables and internal sensor monitoring.
    - [ ON ] **Wireless**: WiFi/AP hotspot configuration.
    - [ ON ] **Testing**: Compass calibration and peripheral diagnostics.
    - [ ON ] **Management**: CRUD for Persons, Equipments, Areas, and Contractors.
- [ ON ] **Auth**: Login/Logout and session state management.
- [ ON ] **Landing / Home**: Entry points and side navigation.

## 2.1 System Guidance Modes
Configure the active guidance branches for the Map module. Toggle [ ON ] / [ OFF ] as required.

### A. SPOT Mode (Point-Based)
- [ ON ] **Enable SPOT Mode**
- **Scan Radius**: 7.5m (Machine detection range)
- **Target Precision**: 0.5m (Bucket-to-point lock range)
- **Auto-Complete Threshold**: 0.1m (10cm)
- **Completion Delay**: 2.0s (Time required at threshold)

### B. CRUMBLING Mode (Line-Based)
- [ ON ] **Enable CRUMBLING Mode**
- **Scan Radius**: 20.0m (Segment detection range)
- **Target Threshold**: 1.2m (Machine-to-line lock range)
- **Deviation Projection**: Relative to Machine Heading (Cross-Track)
- **Auto-Complete Trigger**: Segment Transition (Node Crossing)

### C. Road Mode (Line-Based)
- [ ON ] **Enable Road Mode**
- **Scan Radius**: 30.0m (Segment detection range)
- **Target Threshold**: 2.0m (Machine-to-line lock range)
- **Deviation Projection**: Relative to Machine Heading (Cross-Track)
- **Auto-Complete Trigger**: Segment Transition (Node Crossing)

### D. Dozer Mode (Line-Based)
- [ ON ] **Enable Dozer Mode**
- **Scan Radius**: 20.0m (Segment detection range)
- **Target Threshold**: 1.2m (Machine-to-line lock range)
- **Deviation Projection**: Relative to Machine Heading (Cross-Track)
- **Auto-Complete Trigger**: Segment Transition (Node Crossing)

### E. Harvester Mode (Line-Based)
- [ ON ] **Enable Harvester Mode**
- **Scan Radius**: 20.0m (Segment detection range)
- **Target Threshold**: 3.0m (Machine-to-line lock range)
- **Deviation Projection**: Relative to Machine Heading (Cross-Track)
- **Auto-Complete Trigger**: Segment Transition (Node Crossing)

## 3. Data Models
List the Isar models and data structures required for the project.
- [ ON ] **Person**: [uid, firstName, lastName, kontraktor, driverID, picURL, role, user, password, loginState, lastLogin, lastUpdate, equipment]
- [ ON ] **Equipment**: [uid, equipName, partName, type, unitNumber, model, ipAddress, armLength, lastUpdate, lastDriver]
- [ ON ] **WorkFile**: [uid, areaName, panjang, lebar, luasArea, contractor, equipment, totalSpot, spotDone, status, createAt, lastUpdate, doneAt, equipmentID, operatorID, areaID]
- [ ON ] **Area**: [uid, areaName, luasArea, spacing, targetDone]
- [ ON ] **Contractor**: [uid, name, area, sector, numberEquipment, numberOperator, lastUpdate]
- [ ON ] **WorkingSpot**: [status, driverID, fileID, spotID, mode, totalTime, akurasi, deep, lat, lng, alt, lastUpdate]
- [ ON ] **TimesheetRecord**: [id, modeSystem, activityType, activityName, totalTime, startTime, endTime, hmStart, hmEnd, totalSpots, workspeed, personID]
- [ ON ] **VoiceMessage**: [text, timestamp, sender]
- [ ON ] **BaseStatus**: [batteryVoltage, batteryCurrent, bcc, bmc, lat, long, altitude, akurasi, satelit, status, pitch, roll, chargetype, bsDistance]
- [ ON ] **CalibrationData**: [pitch, roll, boomTilt, stickTilt, bucketTilt, iLinkTilt, bucketLayTilt, boomLenght, stickLenght, bucketLenght, boomBaseHeight, bucketWidth, iLink, hLink, bpd, spd, bcx, bcy, acx, acy, antHeight, antPole, heading, akurasi1, akurasi2, calStatus]
- [ ON ] **RadioConfig**: [channel, key, address, netID, airDataRate, lastUpdate]
- [ ON ] **ErrorAlert**: [sourceID, alertType, message, timestamp]
- [ ON ] **SendAcknowledge**: [sourceID, ackOpcode, status, timestamp]
- [ ON ] **StatusTimesheet**: [id, lastUpdate, status, idTimesheet]
- [ ON ] **WorkConfig**: [gnssAltRef, altRef, bucketLenRef, bucketHorizRef, pitchComp]
- [ ON ] **TimesheetData**: [id, activityType, activityName, icon]

## 4. Hardware / External Integrations
Specify the hardware drivers and external service integrations to be utilized.

- [ ON ] **USB / RS232 (Serial Bridge)**: 
    - Driver: CP2102N (UART-to-USB).
    - Protocol: Hex-based frames (Header: `0xAA55AA55`, Footer: `CRC16`).
- [ ON ] **Offline Voice System**: 
    - STT Engine: **VOSK** (Offline Speech-to-Text).
    - TTS Feedback: **Flutter TTS** for auditory system alerts and guidance.
- [ ON ] **Map & Geospatial**: 
    - Render Engine: **MapLibre** for vector tile display.
    - Path Data: **GeoJSON** for guidance nodes and site boundaries.
    - Calculation: WSG84 to Cartesian (XY) projection via `CoordinateService`.
- [ ON ] **Persistence Layer**: 
    - Engine: **Isar DB** (NoSQL) for high-performance localized telemetry storage.
- [ ON ] **System Permissions**: 
    - Handling: Android Location (Fine/Coarse), Storage (Read/Write), and Audio Recording (for STT) via `PermissionService`.

## 5. UI Layout Preferences
- **Standard Page**: Use standard `Scaffold` + `AppBar` + `SideMenu`.
- **Calibration Layout**: Use the "Calibration Layout" (3:1 horizontal split).
- **Dashboard**: Multi-card responsive grid.

## 6. State & Providers Architecture
The project's reactive data layer is built on Riverpod. New features must implement a `Presenter` (Notifier) pattern.

### 6.1 Core Infrastructure Providers
Centralized services and high-level system state:
- [ ON ] **authProvider**: (`AuthNotifier`, `AuthState`) Session lifecycle and operator role management.
- [ ON ] **comServiceProvider**: (`ComService`, `UsbState`) Low-level USB/Serial (RS232) handshake and connectivity monitoring.
- [ ON ] **gpsStreamProvider**: (`StreamProvider<GPSLoc>`) Reactive NMEA/Binary hardware telemetry.
- [ ON ] **appRepositoryProvider**: (`Provider<AppRepository>`) Main Isar database gateway for all entity collections.
- [ ON ] **errorProvider**: (`ErrorNotifier`, `List<ErrorAlert>`) Global buffer for system-wide hardware and sensor errors.
- [ ON ] **voiceRecognitionProvider**: (`VoiceRecognitionService`) Offline wake-word and command processing.

### 6.2 Feature Presenter Providers
Reactive logic slaved to specific feature pages:
- **Dashboard**: `dashboardPresenterProvider` (`DashboardPresenter`, `DashboardState`) - Live gauges and telemetry mapping.
- **Map**: `mapPresenterProvider` (`MapPresenter`, `MapState`) - Guidance logic (7.5m/20m scan logic), targeting, and dev thresholds.
- **Workfile**: `workfilePresenterProvider` (`WorkfilePresenter`, `WorkfileState`) - File selection, GeoJSON parsing, and area loading.
- **Timesheet**: `timesheetProvider` (`TimesheetNotifier`, `TimesheetState`) - Active activity tracking, auto-save (5-min loop), and HMS recording.
- **Alarm**: `alarmPresenterProvider` (`AlarmPresenter`, `AlarmState`) - STT/TTS logs and auditory feedback queuing.
- **Navigation**: `selectedMenuProvider` (`MenuNotifier`, `int`) - Master navigation drawer indexing (0-4).

### 6.3 Setup & Configuration Providers
Hardware-level setup and background synchronization:
- **Radio**: `radioProvider` (`RadioNotifier`, `RadioConfig?`) - OpCode 0x0B (SET) / 0x0C (GET) config status.
- **Sync**: `syncPresenterProvider` (`SyncPresenter`, `SyncState`) - Background data transmission queue and packet status.
- **WorkConfig**: `workConfigProvider` (`WorkConfigPresenter`, `WorkConfigState`) - OpCode 0x56 operational offsets and ref levels.
- **Calibration**: `calibrationPresenterProvider` (`CalibrationPresenter`, `CalibrationState`) - Lifecycle management (OpCode 0x50) and parameter writes (OpCode 0x53).

---
> [!NOTE]
> Once this document is filled out, the AI (Antigravity) will use it as a reference to generate the necessary code structure, models, and UI components following the standard architecture.
