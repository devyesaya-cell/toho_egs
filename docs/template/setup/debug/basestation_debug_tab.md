# Basestation Debug Tab Blueprint

**Path**: `lib/features/setup/widgets/debug/basestation_debug_tab.dart`  
**Type**: Widget (ConsumerWidget)

## 1. Overview
The `BasestationDebugTab` provides diagnostics for the system's stationary base unit. It focuses on GNSS status, precise positioning, and extensive battery health monitoring (Voltage, Current, Capacity, Charging Status).

---

## 2. Architecture & State Management
- **Provider**: `bsProvider` (from `com_service.dart`).
- **Data Model**: `Basestatus`.
- **Async Handling**: Null check on `bsData` (watches provider).
- **Responsiveness**: Uses `SingleChildScrollView` with `FittedBox` for maintaining card proportions on different screen scales.

---

## 3. Layout Specification

### Base Container
- **Padding**: `EdgeInsets.all(24.0)`
- **Structure**: `Column` with two main horizontal segments.

### Segment 1: Status & Position (Flex: 1)
- **Content**: Two `Expanded` cards for GNSS Status and Position.
- **Spacing**: `SizedBox(width: 24.0)` between cards.

### Segment 2: Multi-Column Diagnostics (Flex: 2)
- **Structure**: `Row` containing three `Expanded` Columns.
- **Column 1 (Battery)**: `Battery Voltage` + `Battery Current` (Stacked).
- **Column 2 (Capacity)**: `BMC` (Max Capacity) + `BCC` (Current Capacity) (Stacked).
- **Column 3 (Wireless)**: `Charging Status` + `BS Distance` (Stacked).
- **Spacing**: `SizedBox(width: 24.0)` between columns; `SizedBox(height: 24.0)` between cards within columns.

---

## 4. Custom Card Blueprint (`_buildCardTemplate`)

Standardized diagnostic containers for the Basestation:

### Container Decoration
- **Color**: `theme.cardSurface`
- **BorderRadius**: `BorderRadius.circular(24)`
- **Border**: `Border.all(color: theme.appBarAccent.withOpacity(0.3), width: 2)`
- **Shadow**: `BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: Offset(0, 5))`

### Accent Bar (Right Side)
- **Component**: `Positioned` element inside a `Stack`.
- **Dimensions**: `width: 8` (Slender design), `top/bottom: 24`.
- **Color**: `theme.appBarAccent`

### Responsive Content Scaling
- **FittedBox**: `fit: BoxFit.scaleDown, alignment: Alignment.topLeft`.
- **Target Size**: `SizedBox(width: 280, height: 160)`.
- **Structure**: `Column` (crossAxisAlignment: start, mainAxisAlignment: spaceBetween).
- **Typography**:
  - Title: `fontSize: 16`, `fontWeight: w500`, `color: theme.textSecondary`.
  - Value: `fontSize: 32`, `fontWeight: bold`, `color: theme.textOnSurface`.
  - Suffix: `fontSize: 16`, `fontWeight: bold`, `color: theme.textSecondary`.
  - Bottom Info: `fontSize: 13`, `color: theme.textSecondary`.

---

## 5. Theme Token Mapping

| UI Element | Property | Token | Source Reference |
| :--- | :--- | :--- | :--- |
| Card Background | `color` | `theme.cardSurface` | `0xFF1E293B` |
| Card Border | `color` | `theme.appBarAccent.withOpacity(0.3)` | `0xFF2ECC71` |
| Accent Bar | `color` | `theme.appBarAccent` | `0xFF2ECC71` |
| Primary Text | `color` | `theme.textOnSurface` | `Colors.white` |
| Secondary Text | `color` | `theme.textSecondary` | `Colors.white54` |
| Icons | `color` | `theme.textOnSurface` | `Colors.white` |

---

## 6. Verification Checklist
- [ ] Watches `bsProvider`.
- [ ] Row 1 contains 2 status cards.
- [ ] Row 2 contains 3 columns with 2 cards each.
- [ ] All card decorations match the specific blueprint (Border, Shadow, Accent Bar).
- [ ] Data rounding: `batteryVoltage.toStringAsFixed(2)`, `batteryCurrent.toStringAsFixed(2)`, `lat/long.toStringAsFixed(7)`.
- [ ] `FittedBox` is used for content scaling.
