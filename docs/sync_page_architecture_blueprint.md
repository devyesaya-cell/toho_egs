# SYNC PAGE ARCHITECTURE BLUEPRINT
Path: `lib/features/setup/pages/sync_page.dart`

This blueprint details the UI structure and state management pattern used for the **Synchronize Feature**, ensuring consistency with the "Calibration Layout" design standard.

## 1. Grid & Layout (3:1 / 4:6 Split)
The page implements a structural grid optimized for informational displays and list management.

- **Main Container**: `Padding(16.0)` wrapping a `Row`.
- **Left Column (Control Panel - Flex 4)**:
  - **Visual Indicator**: Circular progress wheel showing `% Synced`.
  - **Status Text**: Dynamic text indicating current connection or transmission state.
  - **Primary Actions**:
    - `SYNC DATA`: Triggers core metadata synchronization (Area/Equip).
    - `GET WORK`: Requests active WorkFile from Host (includes 5s cooldown).
- **Right Column (Payload History - Flex 6)**:
  - **Header**: Live connection status indicator (Connected/Disconnected).
  - **Body**: `ListView` of `SyncDataResult` records streamed from the database.

---

## 2. State Management Architecture
Uses **Riverpod** with a clear separation of concerns.

### Presenter: `SyncPresenter`
- **Class**: `SyncPresenter extends Notifier<SyncState>`
- **Logic**:
  - WebSocket connection lifecycle via `ComService`.
  - Manual payload generation and transmission.
  - Parsing incoming JSON payloads (Workfile & Database Metadata).
  - Safe disposal via `Future.microtask`.

### Streamer: `syncDataStreamProvider`
- **Type**: `StreamProvider.autoDispose<List<SyncDataResult>>`
- **Purpose**: Real-time reactivity for the "Payload History" list. It watches the `AppRepository` for any changes in the `SyncDataResult` collection filtering by `driverID`.

---

## 3. Component Details: `SyncDataCard`
The card aesthetic used in the history list:

| Element | Description |
|---|---|
| **Pill Status** | Orange for `PENDING`, Green for `SENT`. |
| **Shift Title** | Dynamic label (e.g., "SHIFT DAY 20 Apr 2026"). |
| **Stats Row** | Displays record count (spots) and calculated payload size (Bytes/KB). |
| **Progress** | Inline `LinearProgressIndicator` shown only if the record is currently being uploaded. |
| **Actions** | "Hapus" (Delete) and "Kirim ke Server" (Manual Send). |

---

## 4. UI Rules & Theme Integration
- **Background**: `theme.pageBackground`
- **Card Surface**: `theme.cardSurface` with `theme.cardBorderColor`.
- **Typography**: Bold headers with `letterSpacing: 1.2` for professional technical feel.
- **Micro-animations**: Progress bars and status dots used to keep the interface "alive".

---

> [!IMPORTANT]
> **Cooldown Constraint**: The "GET WORK" action is guarded by a 5-second cooldown in the Presenter state (`isGetWorkfileCooldown`) to prevent network flooding and race conditions during database writes.
