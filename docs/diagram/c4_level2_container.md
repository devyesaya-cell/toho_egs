# Toho EGS — C4 Level 2: Container Diagram

Zooms into the Toho EGS system boundary, showing internal containers (layers/modules) and their interactions.

```mermaid
C4Container
    title Container Diagram — Toho EGS (Android Tablet)

    Person(user, "Operator / Technician", "Interacts with the tablet touchscreen in landscape mode.")

    System_Boundary(egs, "Toho EGS Application") {

        Container(ui, "Presentation Layer", "Flutter Widgets", "9 feature modules: Login, Landing, Home, Dashboard, Map, Workfile, Timesheet, Alarm, Setup. Uses ConsumerWidget/ConsumerStatefulWidget for reactive UI.")

        Container(state, "State Management", "Riverpod Notifiers + Providers", "AuthNotifier, MenuNotifier, ComService, TimesheetPresenter, DashboardPresenter, MapPresenter, CalibrationPresenter, RadioPresenter, WorkConfigPresenter. Provides reactive state to the UI layer.")

        Container(com, "Communication Service", "ComService (Notifier)", "Manages USB serial lifecycle. Parses inbound binary packets via magic-header framing. Dispatches parsed data to StreamProviders and StateNotifiers. Also manages WebSocket client for basestation sync.")

        Container(proto, "Protocol Service", "ProtocolService (Singleton)", "Builds outbound binary frames with CRC16 checksum. Provides command functions: setNormal, setConfig, calibrateCommand, setParam, setRadio, getRadioConfig.")

        Container(repo, "Repository Layer", "AppRepository", "Facade over Isar database. Provides CRUD operations for Person, WorkFile, Area, Equipment, Contractor, TimesheetRecord, WorkingSpot, TimesheetData, StatusTimesheet.")

        Container(db, "Local Database", "Isar Community (NoSQL)", "Persistent storage for all domain entities. 10 collections with indexed queries. Initialized at app boot via DatabaseService.")

        Container(services, "Utility Services", "Dart Services", "NotificationService (global SnackBar), GeoJsonService (workfile parsing), CoordinateService (distance/bearing math), VoiceRecognitionService (offline wake-word + STT), PermissionService (runtime Android permissions).")

        Container(theme, "Theme System", "AppTheme + AppThemeData", "Dual-theme engine (Dark SCADA / Light SCADA) with 50+ color tokens. Auto-switches based on platform brightness. Provides consistent styling across all pages including standard AppBar pattern.")

        Container(models, "Data Models", "Dart Classes", "Persisted: Person, WorkFile, Area, Equipment, Contractor, TimesheetRecord, WorkingSpot, VoiceMessage, TimesheetData, StatusTimesheet. Runtime: GPSLoc, CalibrationData, Basestatus, ErrorAlert, SendAcknowledge, RadioConfig, WorkConfig.")
    }

    System_Ext(mcu, "ESP32 MCU", "Streams sensor telemetry and accepts configuration commands via RS232.")
    System_Ext(basestation, "GNSS Basestation", "RTK correction source and WebSocket sync host.")

    Rel(user, ui, "Touches, swipes, enters data")
    Rel(ui, state, "Watches providers, reads notifiers")
    Rel(ui, theme, "AppTheme.of(context) for all colors")
    Rel(state, com, "Reads UsbState, GPS/Calib streams")
    Rel(state, repo, "CRUD operations via appRepositoryProvider")
    Rel(state, proto, "Builds + sends command frames via Presenters")
    Rel(com, models, "Parses packets into GPSLoc, CalibrationData, Basestatus, etc.")
    Rel(proto, models, "Uses Parsing utility for byte conversion")
    Rel(repo, db, "Reads/writes Isar collections")
    Rel(repo, models, "Persisted model instances")
    Rel(com, mcu, "USB Serial: reads inbound packets", "115200/8N1")
    Rel(proto, mcu, "USB Serial: writes outbound frames", "115200/8N1")
    Rel(com, basestation, "WebSocket client", "ws://192.168.100.69:8080")
    Rel(services, ui, "Notifications, GeoJSON parsing, voice commands")
```

## Container Descriptions

### Presentation Layer
| Module | Path | Widget Type | Purpose |
|--------|------|-------------|---------|
| Login | `features/auth/` | `ConsumerStatefulWidget` | Operator authentication + mode selection |
| Landing | `features/landing/` | `ConsumerStatefulWidget` | Boot gatekeeper, session restore, USB auto-connect |
| Home | `features/home/` | `ConsumerStatefulWidget` | Master-detail shell with SideMenu + content area |
| Dashboard | `features/dashboard/` | `ConsumerWidget` | KPIs: production, productivity, precision, work hours |
| Map | `features/map/` | `ConsumerStatefulWidget` | Real-time MapLibre guidance (Spot/Crumbling modes) |
| Workfile | `features/workfile/` | `ConsumerWidget` | GeoJSON job file selection + creation |
| Timesheet | `features/timesheet/` | `ConsumerStatefulWidget` | Activity logging (ODT/MDT), shift tracking |
| Alarm | `features/alarm/` | `ConsumerWidget` | Voice command logs + system warning history |
| Setup | `features/setup/` | `StatelessWidget` | Grid gateway to 9 configuration sub-pages |

### State Management Layer
| Provider | Type | State | Purpose |
|----------|------|-------|---------|
| `authProvider` | `NotifierProvider` | `AuthState` | Current user, system mode, active workfile |
| `selectedMenuProvider` | `NotifierProvider` | `int` | Active SideMenu index (0-4) |
| `comServiceProvider` | `NotifierProvider` | `UsbState` | USB connection, devices, digging status, WebSocket |
| `gpsStreamProvider` | `StreamProvider` | `GPSLoc` | Live GNSS telemetry from 0xD0 |
| `calibStreamProvider` | `StreamProvider` | `CalibrationData` | Live calibration from 0xD1 |
| `bsProvider` | `NotifierProvider` | `Basestatus?` | Basestation health from 0xD3 |
| `errorProvider` | `NotifierProvider` | `List<ErrorAlert>` | Error buffer (max 100) from 0x83 |
| `radioProvider` | `NotifierProvider` | `RadioConfig?` | Radio settings from 0x86 |

### Communication Service
```
Inbound Pipeline:
  USB inputStream → .map() (liveness tracking, 500ms throttle)
    → Transaction.magicHeader([0x55, 0xAA, 0x55, 0xAA], maxLen: 200)
    → OpCode dispatch (packet[5])
    → Parser → Provider/StreamController

Outbound Pipeline:
  Presenter → ProtocolService.buildFrame(opcode, payload)
    → [Header][Length][OpCode][Payload][CRC16_LE]
    → port.write(Uint8List)
```

### Repository Layer
```
AppRepository (Singleton via Riverpod)
  ├── checkAndSeedDefaultUser()
  ├── getAllPersons() / watchPersons()
  ├── getAllWorkFiles() / watchWorkFiles()
  ├── getAllAreas() / getAllEquipment() / getAllContractors()
  ├── saveTimesheetRecord() / getTimesheetRecords()
  ├── saveWorkingSpot() / getWorkingSpots()
  └── deleteXxx() — cascading deletes where applicable
```

### Local Database
```
Isar Collections (10):
  ├── Person        (uid, firstName, lastName, kontraktor, role, password)
  ├── WorkFile      (name, equipment, geoJson, createdAt)
  ├── Area          (name, luasHa, targetDays)
  ├── Equipment     (name, model, type)
  ├── Contractor    (name, code)
  ├── TimesheetRecord (activity, startTime, endTime, duration, workspeed)
  ├── TimesheetData (category, activityName)
  ├── StatusTimesheet (status, description)
  ├── WorkingSpot   (lat, lng, status, spotID, workfileId)
  └── VoiceMessage  (text, timestamp, command)
```

### Theme System
```
AppTheme.of(context) → AppThemeData
  ├── Dark Mode  (SCADA Dark)  — 50+ tokens, hasGlowEffect: true
  ├── Light Mode (SCADA Light) — 50+ tokens, hasGlowEffect: false
  └── Auto-switch via MediaQuery.platformBrightness
```
