# Stick Calibration Tab — Blueprint

**File**: `lib/features/setup/widgets/calibration/stick_calibration_tab.dart`  
**Widget Class**: `StickCalibrationTab` (extends `ConsumerStatefulWidget`)

_Purpose: Align the Stick Tilt sensor and set physical Stick geometry (Length)._

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
> Uses **standard 3:1 Calibration Layout**. Outer padding is `16.0`. The left column's `Column` MUST use `crossAxisAlignment: CrossAxisAlignment.stretch` to make both the image container and controls container fill the full 75%-width left area.

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
│       │   └── Container[themed] → Image.asset('images/calibrate_1.png', fit: BoxFit.contain)
│       ├── SizedBox(height: 16)
│       └── Expanded(flex: 1)  ← BOTTOM: Controls Container
│           └── Container[themed, horizontal padding: 24, vertical: 16]
│               └── Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly)
│                   ├── Column [Stick Tilt Control]
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
    child: Image.asset('images/calibrate_1.png', fit: BoxFit.contain),
  ),
)
```

> [!NOTE]
> Stick tab uses `images/calibrate_1.png` — the same image as Body Calibration. Both show the side-view of the excavator.

---

## Bottom Left: Controls

### Stick Tilt Control Column

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('STICK TILT: ', style: TextStyle(color: theme.textSecondary, fontWeight: FontWeight.bold)),
        Text(
          '${(data.stickTilt > 360 ? 360.0 : data.stickTilt).toStringAsFixed(2)}°',
          style: TextStyle(color: theme.textOnSurface, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    const SizedBox(height: 8),
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () async { /* direct send — no dialog */ },
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
          tooltip: 'Reset Stick Tilt',
        ),
      ],
    ),
  ],
)
```

> [!IMPORTANT]
> The Stick Tilt **"Calibrate"** button sends the command **directly without an input dialog** (`value1: 0.0`, `mode: 3`). This matches the Boom tab pattern — no inline value entry for tilt calibration.

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
          backgroundColor: theme.primaryButtonBackground,  // uses theme (not hardcoded green)
          foregroundColor: theme.primaryButtonText,
        ),
        onPressed: () async { /* mode: 22 */ },
      ),
      const SizedBox(width: 8),
      ElevatedButton.icon(
        icon: const Icon(Icons.stop),
        label: const Text('STOP'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF4444),   // Semantic red — hardcoded
          foregroundColor: Colors.white,
        ),
        onPressed: () async { /* mode: 42 */ },
      ),
      const SizedBox(width: 8),
      IconButton(
        icon: const Icon(Icons.refresh),
        color: theme.appBarAccent,
        tooltip: 'Reset Stick Accelero',
        onPressed: () async { /* confirmation → mode: 62 */ },
      ),
    ]),
  ],
)
```

> [!WARNING]
> Unlike Body/Boom tabs where START uses `Color(0xFF2ECC71)`, Stick's START button uses **`theme.primaryButtonBackground`** (teal). Replicate this exactly to match the original.

---

## OpCode Reference — Bottom Left Controls

| Control         | Action    | OpCode | Mode | value1 | Confirmation | Dialog |
|-----------------|-----------|--------|------|--------|--------------|--------|
| Stick Tilt      | Calibrate | `0x52` | `3`  | `0.0`  | No           | **No** (direct send) |
| Stick Tilt      | Reset     | `0x52` | `67` | `0.0`  | **Yes**      | No |
| Stick Accelero  | Start     | `0x52` | `22` | `0.0`  | No           | No |
| Stick Accelero  | Stop      | `0x52` | `42` | `0.0`  | No           | No |
| Stick Accelero  | Reset     | `0x52` | `62` | `0.0`  | **Yes**      | No |

---

## Right Column: Parameters Panel

### Parameter Cards — Stick Calibration

| Abbreviation | Full Name    | SET_PARAM Type | Data Field       |
|--------------|--------------|----------------|------------------|
| `SL`         | Stick Length | `1`            | `data.stickLenght` |

> [!NOTE]
> Stick tab has **only 1 parameter card**. The `ListView` contains a single `_buildParamCard` call.

---

## `_showSetParamDialog` — Set Parameter Dialog

_Identical pattern to Body Calibration Tab. See body_calibration_tab.md for full code._

---

## Theme Token Usage Summary

| Element                         | Token                              |
|---------------------------------|------------------------------------|
| Image container background      | `theme.cardSurface`                |
| Image container border          | `theme.cardBorderColor`            |
| Controls container background   | `theme.cardSurface`                |
| Controls container border       | `theme.cardBorderColor`            |
| Parameters panel background     | `theme.cardSurface`                |
| Parameters panel border         | `theme.cardBorderColor`            |
| "STICK TILT:" label             | `theme.textSecondary`              |
| Tilt value text                 | `theme.textOnSurface`              |
| Param card value                | `theme.appBarAccent`               |
| Dividers                        | `theme.dividerColor`               |
| Reset / Refresh icon buttons    | `theme.appBarAccent`               |
| Loading indicator               | `theme.appBarAccent`               |
| Dialog background               | `theme.dialogBackground`           |
| Dialog input fill               | `theme.inputFill`                  |
| Stick Tilt Calibrate button     | `theme.primaryButtonBackground` + `theme.primaryButtonText` |
| **START Accelero button**       | `theme.primaryButtonBackground` + `theme.primaryButtonText` _(not green!)_ |
| STOP Accelero button            | `Color(0xFFEF4444)` _(hardcoded)_  |
| Set button (dialog)             | `theme.primaryButtonBackground` + `theme.primaryButtonText` |
