# Work Config Detail

This document outlines the implementation of the "Work Config" page, which handles non-mechanical parameters like GPS references and orientation offsets.

## 1. Page Layout
- **Pattern**: 3:1 Calibration Layout.
- **Left Column**:
  - **Graphic**: Large `Image.asset('images/exca_cal.png')`.
  - **Controls**: `DropdownButton` for Parameter Type (Index) and Value.
- **Right Column**:
  - `ListView` of `Card` widgets representing current settings.

## 2. Supported Parameters
| Index | Name | Options |
| :--- | :--- | :--- |
| **0** | GNSS Altitude Ref | 0: MSL, 1: Ellipsoid |
| **1** | Altitude Reference | 0: GNSS, 1: OGL |
| **2** | Bucket Length Ref | 0: Teeth, 1: Back |
| **3** | Bucket Horiz Ref | 0: Center, 1: Left, 2: Right |
| **4** | Pitch Compensation | 0: No, 1: Yes |

## 3. UI Generation Rules
- **Dropdown Styling**: Dark theme background (`0xFF1E241E`) with `greenAccent` icons.
- **Button Feedback**: Use `NotificationService.showCommandNotification` upon clicking "SET".

## 4. State Management
- **Presenter**: `WorkConfigPresenter`.
- **Logic**: Handles mapping of indices to readable names and values for both display and serialization.

---
> [!TIP]
> Use the `indexNames` and `valueOptions` maps in the UI to ensure consistent labeling across the page.
