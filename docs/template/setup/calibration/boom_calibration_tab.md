# Boom Calibration Tab — Blueprint

**File**: `lib/features/setup/widgets/calibration/boom_calibration_tab.dart`  
**Widget Class**: `BoomCalibrationTab` (extends `ConsumerStatefulWidget`)

_Purpose: Align the Boom Tilt sensor and set physical Boom geometry (Length, Base Height)._

---

## Imports Required

```dart
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/coms/com_service.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../../core/services/notification_service.dart';
import '../../presenter/calibration_presenter.dart';
```

---

## State

```dart
final CalibrationPresenter _presenter = CalibrationPresenter();
```

---

## Layout Structure (Widget Tree)

> [!IMPORTANT]
> Uses **standard 3:1 Calibration Layout**. Outer padding is `16.0`. The left column's `Column` MUST use `crossAxisAlignment: CrossAxisAlignment.stretch` to make the image and controls fill the 75%-width space.

```
Padding(all: 16.0)
└── calibAsync.when(
      loading: CircularProgressIndicator(color: theme.appBarAccent),
      error:   Text('Error: $err', color: Color(0xFFEF4444)),
      data:    Row(crossAxisAlignment: CrossAxisAlignment.start)
    )

Row:
├── Expanded(flex: 3)  ← LEFT COLUMN (75% width)
│   └── Column(crossAxisAlignment: CrossAxisAlignment.stretch)  ← REQUIRED
│       ├── Expanded(flex: 3)  ← TOP: Image Container
│       │   └── Container[themed] → Image.asset('images/calibrate_2.png', fit: BoxFit.contain)
│       ├── SizedBox(height: 16)
│       └── Expanded(flex: 1)  ← BOTTOM: Controls Container
│           └── Container[themed, horizontal padding: 24, vertical: 16]
│               └── Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly)
│                   ├── Column [Boom Tilt Control]
│                   ├── Container [Vertical Divider]
│                   └── Column [Accelero Control]
├── SizedBox(width: 16)
└── Expanded(flex: 1)  ← RIGHT COLUMN (25% width)
    └── Container[themed, padding: 12]
        └── Column(crossAxisAlignment: CrossAxisAlignment.stretch)
            ├── Text('PARAMETERS') [centered]
            ├── Divider(color: theme.dividerColor)
            └── Expanded → ListView (Parameter Cards)
```

---

## Top Left: Image Container

```dart
Expanded(
  flex: 3,
  child: Container(
    decoration: BoxDecoration(
      color: theme.cardSurface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: theme.cardBorderColor),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Image.asset('images/calibrate_2.png', fit: BoxFit.contain),
  ),
)
```

> [!NOTE]
> **Boom tab uses `images/calibrate_2.png`** — a side-view image with the boom raised. This differs from Body/Stick which use `calibrate_1.png`.

---

## Bottom Left: Controls

### Boom Tilt Control Column

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('BOOM TILT: ', style: TextStyle(color: theme.textSecondary, fontWeight: FontWeight.bold)),
        Text(
          '${(data.boomTilt > 360 ? 360.0 : data.boomTilt).toStringAsFixed(2)}°',
          style: TextStyle(color: theme.textOnSurface, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    const SizedBox(height: 8),
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () async { /* calibrate boom tilt, no dialog — direct send */ },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryButtonBackground,  // teal from theme
            foregroundColor: theme.primaryButtonText,
          ),
          child: const Text('Calibrate'),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () async { /* confirmation dialog → reset */ },
          icon: const Icon(Icons.refresh),
          color: theme.appBarAccent,
          tooltip: 'Reset Boom Tilt',
        ),
      ],
    ),
  ],
)
```

> [!IMPORTANT]
> **Boom Tilt's "Calibrate" button does NOT open a dialog.** It sends the command directly with `value1: 0.0`. This is different from Body's Pitch/Roll which use `_showCalibrateDialog`.

### Vertical Divider

```dart
Container(width: 1, height: double.infinity, color: theme.dividerColor)
```

### Accelero Control Column

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('ACCELERO CALIBRATION',
        style: TextStyle(color: theme.textSecondary, fontWeight: FontWeight.bold)),
    const SizedBox(height: 16),
    Row(children: [
      ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow),
        label: const Text('START'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2ECC71),   // Semantic green — hardcoded
          foregroundColor: Colors.white,
        ),
        onPressed: () async { /* mode: 21 */ },
      ),
      const SizedBox(width: 8),
      ElevatedButton.icon(
        icon: const Icon(Icons.stop),
        label: const Text('STOP'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF4444),   // Semantic red — hardcoded
          foregroundColor: Colors.white,
        ),
        onPressed: () async { /* mode: 41 */ },
      ),
      const SizedBox(width: 8),
      IconButton(
        icon: const Icon(Icons.refresh),
        color: theme.appBarAccent,
        tooltip: 'Reset Boom Accelero',
        onPressed: () async { /* confirmation → mode: 61 */ },
      ),
    ]),
  ],
)
```

---

## OpCode Reference — Bottom Left Controls

| Control         | Action    | OpCode | Mode | value1 | Confirmation | Dialog |
|-----------------|-----------|--------|------|--------|--------------|--------|
| Boom Tilt       | Calibrate | `0x52` | `2`  | `0.0`  | No           | **No** (direct send) |
| Boom Tilt       | Reset     | `0x52` | `66` | `0.0`  | **Yes**      | No |
| Boom Accelero   | Start     | `0x52` | `21` | `0.0`  | No           | No |
| Boom Accelero   | Stop      | `0x52` | `41` | `0.0`  | No           | No |
| Boom Accelero   | Reset     | `0x52` | `61` | `0.0`  | **Yes**      | No |

---

## Right Column: Parameters Panel

### Parameter Cards — Boom Calibration

| Abbreviation | Full Name        | SET_PARAM Type | Data Field          |
|--------------|------------------|----------------|---------------------|
| `BL`         | Boom Length      | `0`            | `data.boomLenght`   |
| `BBH`        | Boom Base Height | `10`           | `data.boomBaseHeight` |

> [!NOTE]
> Note the intentional typo in `boomLenght` (no 't') — this matches the `CalibrationData` model field name exactly.

---

## `_showSetParamDialog` — Set Parameter Dialog

_Identical pattern to Body Calibration Tab. See body_calibration_tab.md for full code._

Key differences: none. The dialog behavior is the same — integer input, `setParam(newValue, type)`, notification on success.

---

## Theme Token Usage Summary

| Element                         | Token                             |
|---------------------------------|-----------------------------------|
| Image container background      | `theme.cardSurface`               |
| Image container border          | `theme.cardBorderColor`           |
| Controls container background   | `theme.cardSurface`               |
| Controls container border       | `theme.cardBorderColor`           |
| Parameters panel background     | `theme.cardSurface`               |
| Parameters panel border         | `theme.cardBorderColor`           |
| "BOOM TILT:" label              | `theme.textSecondary`             |
| Tilt value text                 | `theme.textOnSurface`             |
| Param card value                | `theme.appBarAccent`              |
| Dividers                        | `theme.dividerColor`              |
| Reset / Refresh icon buttons    | `theme.appBarAccent`              |
| Loading indicator               | `theme.appBarAccent`              |
| Dialog background               | `theme.dialogBackground`          |
| Dialog input fill               | `theme.inputFill`                 |
| Boom Tilt Calibrate button      | `theme.primaryButtonBackground` + `theme.primaryButtonText` |
| Set button (dialog)             | `theme.primaryButtonBackground` + `theme.primaryButtonText` |
| START Accelero button           | `Color(0xFF2ECC71)` _(hardcoded)_ |
| STOP Accelero button            | `Color(0xFFEF4444)` _(hardcoded)_ |
