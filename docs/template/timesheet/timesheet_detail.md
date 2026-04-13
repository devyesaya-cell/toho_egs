# Timesheet Page Blueprint
Path: `lib/features/timesheet/timesheet_page.dart`

This page provides a dual-interface for the Timesheet feature: an active logging interface (Activity Tab) and a historical audit log (Timesheet View Tab).

## 1. Page Architecture (Widget Tree)

The core structure utilizes a `DefaultTabController` paired with the standard application `Scaffold` and a Tabbed `AppBar`.

```
DefaultTabController (length: 2)
└── Scaffold
    ├── AppBar (Tabbed Pattern)
    │   ├── Title: 'TIMESHEET' + Icon
    │   ├── Actions: USB Status + Profile Widget
    │   └── bottom: TabBar ('ACTIVITY', 'TIMESHEET VIEW')
    └── Body: Container (with top border)
        └── TabBarView
            ├── _buildActivityTab
            └── _buildTimesheetViewTab
```

### Riverpod Integration
The page uses two top-level auto-disposing `StreamProvider`s to maintain data freshness:
- `timesheetDataStreamProvider`: Fetches available activity types (MDT/ODT).
- `timesheetRecordStreamProvider`: Fetches historical timesheet logs.

## 2. Division of Tabs

### A. Activity Tab (`_buildActivityTab`)
This tab acts as the primary "Logger" interface for starting, pausing, and stopping current work activities.
- **Constraints**: Uses a `ConstrainedBox(maxWidth: 400)` to keep the form centered and readable on large screens.
- **Components**:
  1. **MDT | ODT Toggle**: A pill-shaped row of two custom `_buildToggleBtn`s to switch between equipment activity sets.
  2. **Activity Dropdown**: A `DropdownButton` populated from `timesheetDataStreamProvider`. It is *disabled* when `state.isRunning` is true.
  3. **Timer View**: A large bounding box displaying elapsed time in `HH:mm:ss`.
     - Uses `fontFeatures: [FontFeature.tabularFigures()]` to prevent text jitter during updates.
     - **Visual Feedback**: When running, it displays an animated `BoxShadow` and changes border color to green (`0xFF2ECC71`).
  4. **Control Buttons**:
     - **START/STOP**: A primary `ElevatedButton`. Color swaps between green (START) and red (STOP).
     - **CLOSE**: Secondary button to exit the app (`SystemNavigator.pop()`).

### B. Timesheet View Tab (`_buildTimesheetViewTab`)
This tab acts as an "Audit" interface where operators can review their past shifts.
- **Shift Filter**: A toggle group at the top (`Morning Shift` vs `Night Shift`). Filtering logic relies on strict 12-hour boundaries (07:00 - 19:00).
- **Data Table Layout (`_buildDataTable`)**: Rendered via a complex arrangement of `SingleChildScrollView` and `Table` widgets to ensure accurate tabular display on all screen sizes.
  - **Scroll Wrapping**: Wrapped in a vertical and horizontal `SingleChildScrollView`.
  - **Column Sizing Logic**: Crucially relies on explicit `FixedColumnWidth` mapping across all `Table`s instead of flex values. This is strictly required for horizontal scrolling.
    ```dart
    const columnWidths = {
      0: FixedColumnWidth(180), // Activity Name
      1: FixedColumnWidth(100), // Time Machine Start
      2: FixedColumnWidth(100), // Time Machine End
      3: FixedColumnWidth(80),  // Time Operator Start
      4: FixedColumnWidth(80),  // Time Operator End
      5: FixedColumnWidth(80),  // Time Operator Hour
      6: FixedColumnWidth(100), // Total Spots
      7: FixedColumnWidth(100), // Ha/hour
      8: FixedColumnWidth(100), // Worktime
    };
    ```
  - **Top Grouped Headers**: A dedicated `Table` that merges columns to create overarching categories:
    - Empty cell (width 180)
    - **TIME MACHINE**: Merges Start + End (width 200)
    - **TIME OPERATOR**: Merges Oper Start + End + Hour (width 240)
    - Empty cell (width 300)
  - **Sub-Headers**: A second `Table` using `columnWidths` with explicit labels matching the fixed widths above: *Activity, Start, End, Start, End, Hour, Total, Ha/hour, Worktime*.
  - **Table Borders**:
    - Header uses `Color(0xFF1E3A2A)` for its `bottom` and `horizontalInside` borders.
    - Data rows use `Colors.black26` to separate records.
- **Data Rows & Logic**: 
  - Iterates over `filteredRecords`.
  - **Timestamp formatting**: Epoch times (`startTime` / `endTime`) are formatted to `HH:mm`.
  - **Duration calculation (`hourDiff`)**: Subtracts `startDt` from `endDt` to render string format `HH:mm` for the current record.
  - **Row Coloring**: Each row's background relies on a `_colorStatus(record.activityType)` helper function based on the activity type context.
- **Summary Footer**: A fixed area below the data matrix to calculate column totals (Total Worktime, Total Ha, etc.).

## 3. Theme Token Mapping

The entire page strictly adheres to the `AppTheme` system to avoid hardcoded colors (except for explicit semantic overrides).

| Component | Token | Property |
|-----------|-------|----------|
| Page Body | `theme.pageBackground` | `Scaffold.backgroundColor` |
| AppBar | `theme.appBarBackground` | `backgroundColor` |
| Active Tab Indicator | `theme.appBarAccent` | `TabBar.indicatorColor` |
| Dropdown Box | `theme.cardSurface` | Activity Dropdown `backgroundColor` |
| Dropdown Text | `theme.dropdownItemText`| Activity Text |
| Table Borders | `theme.cardBorderColor` | Data table wrapping border |

### Semantic Color Overrides (Fixed)
- **USB Icon**: Green (`0xFF2ECC71`) if active, Red (`0xFFEF4444`) if inactive.
- **Start Button**: Green (`0xFF2ECC71`).
- **Stop Button**: Red (`0xFFEF4444`).
- **Running Timer Accent**: Active state uses Green (`0xFF2ECC71`) text and box-shadow.

## 4. UI Generation Rules

- **State Syncing**: The `TimesheetNotifier` state (e.g., `isRunning`) directly dictates the visual availability of the Stop/Start buttons and the dropdown.
- **Snackbars**: Show a Green semantic snackbar (`0xFF2ECC71`) upon successfully saving a timesheet record, and a Red one (`0xFFEF4444`) if trying to start without selecting an activity.
- **Logout Warning**: The logout dialog (`_showLogoutDialog`) should use an Orange icon (`semantic warning`) and explicitly stop any running timer before executing the logout via `authProvider`.

---
> [!NOTE]
> The division of responsibilities on this page is strict: The UI only handles presentation and invoking actions on the `timesheetProvider`. All interval timing, timer restoration, and database queries are abstracted to the Notifier.
