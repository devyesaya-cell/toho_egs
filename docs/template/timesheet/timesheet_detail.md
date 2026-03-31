# Timesheet Feature Detail

This document outlines the dual-purpose Timesheet feature, covering both active logging and historical list views.

## 1. Page Layout
- **Type**: `ConsumerWidget` with `DefaultTabController`.
- **Tabs**:
  1. **ACTIVITY**: For starting, pausing, and stopping current work activities.
  2. **TIMESHEET VIEW**: For auditing past activity records within specific shifts.

## 2. Core Widgets
### A. Activity Tab (Logger)
- **Toggle**: `MDT` vs `ODT` selection using specialized toggle buttons.
- **Activity Selector**: `DropdownButton` populated from `TimesheetData` stream.
- **Timer Display**: Large bold text formatting `elapsedSeconds` (HH:mm:ss) with tabular figures for no-jitter updates.
- **Control Buttons**: `START/STOP ACTIVITY` (adaptive color) and `CLOSE` (system exit).

### B. Timesheet View Tab (Audit)
- **Shift Filter**: `Morning Shift` vs `Night Shift` toggle that filters records based on 12-hour windows (07:00-19:00).
- **Data Table**: 
  - **Scrollable**: Wrapped in both vertical and horizontal `SingleChildScrollView`.
  - **Structure**: Nested `Table` widgets for complex headers (grouping "Time Machine" and "Time Operator" columns).
  - **Formatting**: Timestamps are converted from seconds-since-epoch to `HH:mm`.
- **Summary Footer**: Displays total hours or counts for the filtered view.

## 3. State Management (Presenter)
- **Notifier**: `TimesheetNotifier`.
- **Key Logic**:
  - `_checkActiveTimesheet`: Recovers active timer if the app was closed during an activity.
  - `startActivity`: Generates a random 5-digit ID and saves a new `TimesheetRecord`.
  - `stopActivity`: Updates `endTime` and calculates `totalTime` in minutes.

## 4. UI Generation Rules
- **Scrolling**: Use `FixedColumnWidth` instead of flex for the data table to ensure horizontal scrolling works correctly.
- **Micro-interactions**: Use `AnimatedContainer` or `BoxShadow` on the timer view when `isRunning` is true to provide visual "heartbeat" feedback.

---
> [!TIP]
> When implementing tables with many columns, always provide a summary footer to calculate totals (e.g., total work hours).
