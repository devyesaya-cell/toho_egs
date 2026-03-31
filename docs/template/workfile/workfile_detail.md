# Workfile Feature Detail

This document covers the management of job sites, area assignments, and GeoJSON-based work point ingestion.

## 1. Page Layouts
### A. Workfile List Page
- **Type**: `ConsumerWidget`.
- **Structure**:
  - `Scaffold` with `GridView` (3 columns).
  - **Filtering**: Files are automatically filtered by the current `SystemMode` (e.g., "SPOT", "CRUMBLING").
  - **Action**: Tapping a `WorkfileCard` sets it as "Active" and navigates to the Map.

### B. Create Workfile Page
- **Type**: `ConsumerStatefulWidget`.
- **Structure**:
  - Centered form (max width 600) with vertical `Column`.
  - **Form Fields**: Custom `_buildDropdown` for Area, Contractor, Mode, and Spacing.
  - **File Ingestion**: `ElevatedButton.icon` for picking GeoJSON files.
  - **Preview**: Summary card showing `Total Spots` and `Calculated Area` before saving.

## 2. Core Widgets
### A. [WorkfileCard](file:///c:/apps/toho_EGS/lib/features/workfile/widgets/workfile_card.dart)
- **Role**: Visual representation of a job file in the grid.
- **Details**: Shows Job Name, Area Name, Date, and a status icon.

### B. Form Selectors (Dropdowns)
- **Styling**: `BoxDecoration` with `white.withOpacity(0.05)` and `greenAccent` icons for a premium dark-mode look.

## 3. State Management (Presenter)
- **Presenter**: `WorkfilePresenter`.
- **Key Logic**:
  - `pickFile`: Uses `file_picker` to load GeoJSON.
  - `saveWorkfile`: Parses the GeoJSON into `WorkingSpot` objects and saves the `WorkFile` metadata to Isar.
  - `loadData`: Fetches prerequisites (Areas, Contractors) from the database.

## 4. UI Generation Rules
- **Consistency**: Use the same header style (Icon Box + Title + Subtitle) as other major pages (Dashboard, Alarm).
- **Feedback**: Use a `SnackBar` with `Colors.greenAccent[700]` to confirm successful file creation.

---
> [!NOTE]
> Workfiles are the logical parent of all work telemetry. A valid workfile must contain at least one GeoJSON work point to be usable in the Map.
