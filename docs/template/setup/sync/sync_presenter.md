# Sync Presenter Blueprint

**Path**: `lib/features/setup/presenter/sync_presenter.dart`  
**Type**: State/Logic Controller  
**Class Name**: `SyncPresenter` (Notifier)

## 1. Overview
The `SyncPresenter` is responsible for managing the lifecycle of the data synchronization process. It orchestrates WebSocket connectivity, database queries (Fetching Spots), and the construction of byte payloads to be sent to the Host.

---

## 2. Dependencies
- `ComService`: Handles the low-level WebSocket connection to the Host hotspot.
- `AppRepository`: Queries the local Isar database.
- `PayloadBuilder`: Converts objects into binary protocol packets.
- `AuthStatus`: Retrieves the `driverID` for the current session.

---

## 3. State Structure (`SyncState`)

| Property | Type | Default | Purpose |
| :--- | :--- | :--- | :--- |
| `status` | `SyncConnectionStatus` | `idle` | Enum (idle, connecting, connected, sendingPayload, payloadSent, error) |
| `statusText` | `String` | 'Waiting...' | Human-readable feedback for the UI |
| `progress` | `double` | 0.0 | Sync percentage (0.0 to 1.0) |
| `spots` | `List<WorkingSpot>` | `[]` | The collection of records fetched for current sync |

---

## 4. Core Logic Flow

### A. Initialization (`build()`)
- Watches `comServiceProvider.notifier` for WebSocket control.
- Listens to `comServiceProvider` for WebSocket connection drops. 
- Auto-triggers `disconnectWebSocket()` on disposal using `Future.microtask()`.

### B. `startSync()`
1. **Connectivity**: Sets status to `connecting` and calls `_comService.connectToHostWebSocket()`.
2. **Success**: Updates status to `connected` (progress: 0.5) and triggers `_sendWorkingspotPayload()`.
3. **Failure**: Transitions state to `error` and displays "Failed to connect".

### C. `_sendWorkingspotPayload()` (The Sync Hammer)
1. **Fetching Logged Person**: Obtains `driverID` from the `authProvider`.
2. **Isar Query**: Fetches `WorkingSpot` records from `AppRepository` based on the current shift (07:00 / 19:00 boundary).
3. **State Buffering**: Stores the fetched `spots` in the `SyncState`.
4. **Binary Building**: Uses `PayloadBuilder.buildSyncPayload()` to generate the byte array.
5. **Transmission**: Pushes the binary payload over the WebSocket via `_comService.sendRawDataToHost()`.
6. **Completion**: Sets status to `payloadSent` (progress: 1.0).

---

## 5. Error Management
The presenter uses a `try/catch` block wrapping the entire sync operation. Errors are captured and stored in the `statusText` while the `SyncConnectionStatus` is set to `error`. This ensures the UI can reactively display the error state.

---

## 6. Architecture Note (State Management)
- **Notifier Implementation**: Inherits from Riverpod's `Notifier`.
- **Auto-Dispose**: Uses `NotifierProvider.autoDispose` to ensure that WebSocket sessions are cleaned up when the user navigates away from the Sync page.
