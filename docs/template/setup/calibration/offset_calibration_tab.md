# Offset Calibration Tab — Blueprint

**File**: `lib/features/setup/widgets/calibration/offset_calibration_tab.dart`  
**Widget Class**: `OffsetCalibrationTab` (extends `ConsumerStatefulWidget`)

_Purpose: Align the machine heading (compass offset). The user physically rotates the arm 180° while the app listens to sensor data._

---

## Imports Required

```dart
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/coms/com_service.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/services/notification_service.dart';
import '../../presenter/calibration_presenter.dart';
```

---

## State

No local state variables. All data sourced from Riverpod providers:
- `calibStreamProvider` → `CalibrationData` (OpCode `0xD1` stream)
- `comServiceProvider` → `UsbState` (for `port`)

---

## Layout Structure (Widget Tree)

> [!IMPORTANT]
> This tab does **NOT** use the standard 3:1 Calibration Layout. It is a **1:1 horizontal split** (two equal `Expanded(flex: 1)` columns) inside a `Padding(24.0)`.

```
Padding(all: 24.0)
└── Row(crossAxisAlignment: CrossAxisAlignment.start)
    ├── Expanded(flex: 1)  ← LEFT COLUMN
    │   └── Column(mainAxisAlignment: MainAxisAlignment.center)
    │       ├── Expanded(child: Center → LayoutBuilder → SizedBox → Transform.rotate → Image)
    │       ├── SizedBox(height: 24)
    │       ├── Row(mainAxisAlignment: MainAxisAlignment.center)
    │       │   ├── ElevatedButton.icon [START]
    │       │   ├── SizedBox(width: 16)
    │       │   └── ElevatedButton.icon [STOP]
    │       └── SizedBox(height: 24)
    ├── SizedBox(width: 32)
    └── Expanded(flex: 1)  ← RIGHT COLUMN
        └── Column(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.center)
            ├── Container [HEADING DISPLAY]
            ├── SizedBox(height: 24)
            └── Container [NOTES PANEL]
```

---

## Left Column: Rotating Image

The image region uses `LayoutBuilder` to compute a safe size so the image never clips when rotating.

```dart
Expanded(
  child: Center(
    child: LayoutBuilder(
      builder: (context, constraints) {
        final minAxis = min(constraints.maxWidth, constraints.maxHeight);
        final imageSize = minAxis * 0.70; // 70% of shortest dimension
        return SizedBox(
          width: imageSize,
          height: imageSize,
          child: Transform.rotate(
            angle: rotationRadians,  // heading * (pi / 180.0)
            child: Image.asset('images/exca2_top.png', fit: BoxFit.contain),
          ),
        );
      },
    ),
  ),
)
```

**Pre-calculation in `build()`:**
```dart
final double heading = calibData?.heading ?? 0.0;
final double rotationRadians = heading * (pi / 180.0);
```

> [!NOTE]
> `calibData` comes from `calibAsync.asData?.value`. This tab reads the provider **but does NOT** use `.when()`. It uses `.asData?.value` directly so it always renders the UI, even while loading (showing `heading: 0.0` as fallback).

---

## Left Column: Action Buttons

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    ElevatedButton.icon(
      onPressed: () async { /* START logic */ },
      icon: const Icon(Icons.play_arrow),
      label: const Text('START'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2ECC71),       // Semantic green — hardcoded
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
    ),
    const SizedBox(width: 16),
    ElevatedButton.icon(
      onPressed: () async { /* STOP logic */ },
      icon: const Icon(Icons.stop),
      label: const Text('STOP'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFEF4444),       // Semantic red — hardcoded
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
    ),
  ],
)
```

**Button Command Logic (shared pattern):**
```dart
final port = ref.read(comServiceProvider).port;
if (port != null) {
  final command = CalibrationPresenter().calibrateCommand(value1: 0.0, mode: MODE);
  await port.write(Uint8List.fromList(command));
  if (context.mounted) {
    NotificationService.showCommandNotification(
      context,
      title: 'OFFSET',
      message: 'Offset Calibration Started',    // or 'Stopped'
      modeStr: 'START',                          // or 'STOP'
      icon: Icons.check_circle,                 // START: check_circle | STOP: stop_circle
      iconColor: const Color(0xFF2ECC71),        // START: green | STOP: Color(0xFFEF4444)
      headerColor: const Color(0xFF1E3A2A),      // START: dark green | STOP: Color(0xFF3F1D1D)
    );
  }
} else {
  // Show error notification: title 'OFFSET', icon Icons.error, iconColor 0xFFEF4444, headerColor 0xFF3F1D1D
}
```

| Action | Mode | Icon              | iconColor    | headerColor  |
|--------|------|-------------------|--------------|--------------|
| START  | `7`  | `Icons.check_circle` | `0xFF2ECC71` | `0xFF1E3A2A` |
| STOP   | `8`  | `Icons.stop_circle`  | `0xFFEF4444` | `0xFF3F1D1D` |

---

## Right Column: Heading Value Card

```dart
Container(
  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  decoration: BoxDecoration(
    color: theme.cardSurface,                // e.g., 0xFF1A2235 dark, 0xFFFFFFFF light
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: theme.cardBorderColor),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text('HEADING',
          style: TextStyle(
            color: theme.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          )),
      const SizedBox(height: 4),
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading.toStringAsFixed(1).padLeft(5, '0'), // "000.0" format
            style: const TextStyle(
              color: Color(0xFF2ECC71),   // Semantic green — hardcoded
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text('°',
                style: TextStyle(
                  color: Color(0xFF2ECC71),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
    ],
  ),
)
```

---

## Right Column: Notes Panel

```dart
Container(
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(
    color: theme.cardSurface,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: theme.appBarAccent.withValues(alpha: 0.3),  // teal border, 30% opacity
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Icon(Icons.info_outline, color: theme.appBarAccent),
        const SizedBox(width: 8),
        Text('NOTES',
            style: TextStyle(
              color: theme.textOnSurface,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            )),
      ]),
      Divider(color: theme.dividerColor, height: 32),
      _buildNoteStep('1', 'Arahkan Arm searah dengan track'),
      _buildNoteStep('2', 'Tekan tombol start'),
      _buildNoteStep('3', 'Putar arm excavator 180 derajat'),
      _buildNoteStep('4', 'Tekan stop dan tunggu sampai notifikasi muncul'),
    ],
  ),
)
```

### `_buildNoteStep` Helper

```dart
Widget _buildNoteStep(String number, String text) {
  final theme = AppTheme.of(context);
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: theme.appBarAccent.withValues(alpha: 0.2),  // teal circle bg
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(number,
                style: TextStyle(
                  color: theme.appBarAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text,
              style: TextStyle(
                color: theme.textSecondary,
                fontSize: 13,
                height: 1.5,
              )),
        ),
      ],
    ),
  );
}
```

---

## Theme Token Usage Summary

| Widget Element            | Token Used                                      |
|---------------------------|-------------------------------------------------|
| Heading card background   | `theme.cardSurface`                            |
| Heading card border       | `theme.cardBorderColor`                        |
| Notes card background     | `theme.cardSurface`                            |
| Notes card border         | `theme.appBarAccent.withValues(alpha: 0.3)`    |
| "HEADING" label text      | `theme.textSecondary`                          |
| "NOTES" title text        | `theme.textOnSurface`                          |
| Notes info icon           | `theme.appBarAccent`                           |
| Note step number circle   | `theme.appBarAccent` (text) + `alpha:0.2` (bg) |
| Note step body text       | `theme.textSecondary`                          |
| Divider                   | `theme.dividerColor`                           |
| Heading numeric value     | `Color(0xFF2ECC71)` _(semantic hardcoded)_     |
| START button              | `Color(0xFF2ECC71)` _(semantic hardcoded)_     |
| STOP button               | `Color(0xFFEF4444)` _(semantic hardcoded)_     |

> [!CAUTION]
> The outer padding is `24.0` (not `16.0`). The horizontal gap between the two columns is `SizedBox(width: 32)` (not `16`). Do NOT confuse this with the 3:1 layout used in Body/Boom/Stick/Attachment tabs.
