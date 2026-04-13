# Timesheet Presenter Blueprint
Path: `lib/features/timesheet/presenter/timesheet_presenter.dart`

The `TimesheetPresenter` (implmented as `TimesheetNotifier`) is responsible for managing the state of the active timesheet session, handling the background timer logic, and interfacing with the Isar data layer through the `AppRepository`.

## 1. Provider Definition
- **Type**: `NotifierProvider<TimesheetNotifier, TimesheetState>`.
- **Reasoning**: Maintains state globally while the app is active, allowing the timer to continue running even if the user navigates away from the Timesheet page.

## 2. State Model Detail (`TimesheetState`)
The state model uses immutable design pattern to ensure predictable rebuilds.

| Property | Type | Default | Purpose |
|----------|------|---------|---------|
| `isMdt` | `bool` | `true` | Tracks the active MDT/ODT toggle on the activity tab. |
| `selectedActivity` | `TimesheetData?` | `null` | Tracks the currently selected activity type from the dropdown. |
| `isRunning` | `bool` | `false` | True when an activity timer is progressing. |
| `elapsedSeconds` | `int` | `0` | Controls the UI ticking timer on the activity tab. |
| `currentTimesheetId` | `int?` | `null` | The ID belonging to the currently active record in the database. |
| `isMorningShift` | `bool` | `true` | Tracks the active Morning/Night toggle on the timesheet view tab. |

## 3. Business Logic (Core Subsystems)

### A. Lifecycle & Recovery (`_checkActiveTimesheet`)
- **Action**: Runs automatically via `Future.microtask` when the presenter is initialized.
- **Purpose**: Recovers a potentially active timer if the application was closed unexpectedly.
- **Logic**:
  1. Calls `getStatusTimesheet()` to look for an ID flag with `"PAUSE"` status.
  2. If found, queries the full `getAllTimesheetRecords()` to find the matching `id`.
  3. Re-calculates `elapsedSeconds` by taking the `DateTime.now().difference` against the record's cached `startTime`.
  4. Flips `isRunning` to true and calls `_startTimer()`.

### B. The Timer Mechanism (`_startTimer` & `disposeTimer`)
- **Mechanism**: Utilizes `dart:async` `Timer.periodic`.
- **Update Frequency**: Excecutes roughly every 1.0 seconds.
- **Mutation**: Mutates the state via `state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1)`.
- **Safety**: Always calls `_timer?.cancel()` before kicking off a new periodic instance.

### C. Persistent Operations (Start / Stop)

#### `startActivity()`
- Gathers context: User ID (`authProvider`) and active Equipment Mode.
- Generates a random session ID (`Random().nextInt(90000) + 10000`).
- Saves a preliminary `TimesheetRecord` to the repository using the current epoch time (`startTime`).
- **Crucial step**: Invokes `repo.pauseTimesheet(generatedId)` to register this ID in the active status flag.
- Triggers the timer.

#### `stopActivity()`
- Cancels the active `Timer` instance.
- Fetches the active `TimesheetRecord` from the database.
- Registers the current epoch time as `endTime`.
- Computes `diffMinutes`: The difference between `endTime` and `startTime` in whole minutes. Updates `totalTime`.
- Saves the finalized record back to the repository.
- Clears the active status flag via `repo.clearTimesheetStatus()`.
- Resets local variables (`isRunning: false, currentTimesheetId: null, elapsedSeconds: 0`).

## 4. UI Command Handlers
Functions explicitly designed to be bound to UI gestures.
- `toggleMdt(bool)`: Short-circuits if `isRunning` is true.
- `setActivity(TimesheetData?)`: Short-circuits if `isRunning` is true.
- `toggleShift(bool)`: Determines the morning/night filtering window context.
- `closeAppActivity()`: Wraps `SystemNavigator.pop()`. Safe-guards exit by running `stopActivity()` automatically if a timer is running.

---
> [!IMPORTANT]
> Because `TimesheetNotifier` manages long-running asynchronous background properties (like `Timer`), ensure that it operates independently of the UI widget lifecycle preventing memory leak scenarios.
