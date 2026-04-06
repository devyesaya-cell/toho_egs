# Rover Debug Tab Blueprint

**Path**: `lib/features/setup/widgets/debug/rover_debug_tab.dart`  
**Type**: Widget (ConsumerStatefulWidget)

## 1. Overview
The `RoverDebugTab` provides real-time GNSS, power, and positioning diagnostics for the rover unit. It consumes live GPS data streams and displays them in a high-contrast dashboard format.

---

## 2. Architecture & State Management
- **Provider**: `gpsStreamProvider` (from `com_service.dart`).
- **Data Model**: `GPSLoc`.
- **Logic**: Uses `DebugPresenter` for time formatting (`formatTime`).
- **Async Handling**: `.when(data: , loading: , error: )` via Riverpod.

---

## 3. Layout Specification

### Base Container
- **Padding**: `EdgeInsets.all(24.0)`
- **Structure**: `Column` with two main rows separated by `SizedBox(height: 24.0)`.

### Row 1: GNSS Status (Flex: 1)
- **Content**: Two `Expanded` cards for GNSS 1 and GNSS 2.
- **Spacing**: `SizedBox(width: 24.0)` between cards.

### Row 2: Diagnostics (Flex: 1)
- **Content**: Three `Expanded` cards for Power, Radio, and Position.
- **Spacing**: `SizedBox(width: 24.0)` between cards.

---

## 4. Custom Card Blueprint (`_buildCardTemplate`)

All diagnostic data is housed in standardized containers with the following specifications:

### Container Decoration
- **Color**: `theme.cardSurface`
- **BorderRadius**: `BorderRadius.circular(24)`
- **Border**: `Border.all(color: theme.appBarAccent.withOpacity(0.3), width: 2)`
- **Shadow**: `BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: Offset(0, 5))`

### Accent Bar (Right Side)
- **Component**: `Positioned` element inside a `Stack`.
- **Dimensions**: `width: 20`, `top/bottom: 24`.
- **Decoration**: `BoxDecoration` with `borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))`.
- **Color**: `theme.appBarAccent`

### Content Layout
- **Padding**: `EdgeInsets.all(20.0)`
- **Structure**: `Column` (crossAxisAlignment: start, mainAxisAlignment: spaceBetween).
- **Elements**:
  1. **Icon**: `size: 28`, `color: theme.textOnSurface`.
  2. **Title**: `fontSize: 16`, `fontWeight: w500`, `color: theme.textSecondary`.
  3. **Main Value Row**:
     - Value: `fontSize: 36`, `fontWeight: bold`, `color: theme.textOnSurface`.
     - Suffix: `fontSize: 18`, `fontWeight: bold`, `color: theme.textSecondary`.
  4. **Bottom Info**: Custom widget for secondary diagnostics (e.g., Accuracy, Temp, Lat/Lng).

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
| Loading Spinner | `color` | `theme.appBarAccent` | `0xFF2ECC71` |

---

## 6. Verification Checklist
- [ ] Watches `gpsStreamProvider`.
- [ ] Row 1 contains 2 GNSS cards.
- [ ] Row 2 contains 3 diagnostic cards (Power, Radio, Position).
- [ ] All card decorations match the specified blueprint (Border, Shadow, Accent Bar).
- [ ] Uses `DebugPresenter.formatTime` for correction and packet timings.
- [ ] GPS data rounding: `vin.toStringAsFixed(2)`, `mcuTemp.toStringAsFixed(1)`, `lat/lng.toStringAsFixed(5)`.
