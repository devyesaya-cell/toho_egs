# Map Feature Detail

This document provides a technical breakdown of the Map feature, focusing on GIS integration and real-time excavator guidance.

## 1. Page Layout
- **Type**: `ConsumerStatefulWidget`
- **Structure**:
  - `Scaffold` with `Stack` for layered UI.
  - **Layer 1: MapLibreMap**: The base GIS layer.
    - Initialized with `Geographic` coordinates and zoom.
    - Managed by `MapController`.
  - **Layer 2: UI Overlays**:
    - **Top Left**: Menu button for zoom and work mode toggle.
    - **Top Right**: Connection status (USB Active) and Exit button.
    - **Top Center**: `CrumblingDeviationBar` (Conditional on mode).
    - **Right**: `GuidanceWidget` (Conditional on work mode).
    - **Bottom**: `MapInfoPanel` (Essential telemetry).

## 2. Core Widgets
### A. [MapLibreMap](https://pub.dev/packages/maplibre)
- **Role**: Visualizing terrain, work areas, and excavator position.
- **Customization**: Uses `addExcavatorLayers` to render 3D-like excavator icons and `loadSpots` for work points.

### B. [MapInfoPanel](file:///c:/apps/toho_EGS/lib/features/map/widgets/map_info_panel.dart)
- **Role**: Unified telemetry display.
- **RTK Status Logic**: 
  - `RTK` -> Green
  - `FLOAT` -> Orange
  - `NO RTK` -> Red
- **Inclination**: Shows Pitch and Roll using rotated assets (`exca_left_color.png`, `exca_back_color.png`).

### C. [GuidanceWidget](file:///c:/apps/toho_EGS/lib/features/map/widgets/guidance_widget.dart)
- **Role**: Directional guidance icon/widget that appears when moving towards a target spot.

## 3. State Management (Presenter)
- **Provider**: `mapPresenterProvider` (AsyncNotifier).
- **Key Responsibilities**:
  - Managing `MapController` lifecycle.
  - Handling GPS/USB serial data stream.
  - Calculation logic for spot completion (Distance < threshold + Delay).
  - Toggling "Work Mode" (centers camera and locks map panning).

## 4. UI Generation Rules
- **AbsorbPointer**: Wrap the Map in `AbsorbPointer` during Work Mode to prevent accidental panning.
- **Floating Buttons**: Use `FloatingActionButton.mini` for zoom and mode toggles.
- **Dialogs**: Use `TimesheetStartDialog` and `TimesheetEndDialog` to gate map entry/exit.

---
> [!IMPORTANT]
> The map bearling should be linked to either the excavator's heading or a target bearing provided by the guidance logic.
