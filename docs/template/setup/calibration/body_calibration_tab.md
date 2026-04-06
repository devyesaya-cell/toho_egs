# Body Calibration Tab — Blueprint

**File**: `lib/features/setup/widgets/calibration/body_calibration_tab.dart`  
**Widget Class**: `BodyCalibrationTab` (extends `ConsumerStatefulWidget`)

_Purpose: Align body-mounted sensors (Pitch, Roll) and set antenna/axis geometry parameters._

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

No other local state. All sensor data from `calibStreamProvider`.

---

## Layout Structure (Widget Tree)

> [!IMPORTANT]
> This tab uses the **standard 3:1 Calibration Layout**. Outer padding is `16.0`. The **LEFT column** (`flex: 3`) uses `Column(crossAxisAlignment: CrossAxisAlignment.stretch)` — this is **critical**: it forces the image container and controls container to fill the full 3-flex width.

```
Padding(all: 16.0)
└── calibAsync.when(
      loading: CircularProgressIndicator(color: theme.appBarAccent),
      error:   Text('Error: $err', color: Color(0xFFEF4444)),
      data:    Row(crossAxisAlignment: CrossAxisAlignment.start) ← MAIN LAYOUT
    )

Row:
├── Expanded(flex: 3)  ← LEFT COLUMN — fills 75% of screen width
│   └── Column(crossAxisAlignment: CrossAxisAlignment.stretch)  ← MUST be stretch
│       ├── Expanded(flex: 3)  ← TOP LEFT: Image Container
│       │   └── Container [dark card, 16px radius, themed border]
│       │       └── Image.asset('images/calibrate_1.png', fit: BoxFit.contain)
│       ├── SizedBox(height: 16)
│       └── Expanded(flex: 1)  ← BOTTOM LEFT: Controls Container
│           └── Container [dark card, 16px radius, themed border]
│               └── Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly)
│                   ├── Column [Pitch Control]
│                   ├── Column [Roll Control]
│                   ├── Container [Vertical Divider]
│                   └── Column [Accelero Control]
├── SizedBox(width: 16)
└── Expanded(flex: 1)  ← RIGHT COLUMN — fills 25% of screen width
    └── Container [dark card, 16px radius, themed border]
        └── Column(crossAxisAlignment: CrossAxisAlignment.stretch)
            ├── Text('PARAMETERS', centered, themed)
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

---

## Bottom Left: Controls Container

```dart
Expanded(
  flex: 1,
  child: Container(
    decoration: BoxDecoration(
      color: theme.cardSurface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: theme.cardBorderColor),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /* Pitch Column */,
        /* Roll Column */,
        /* Vertical Divider */,
        /* Accelero Column */,
      ],
    ),
  ),
)
```

### Pitch Control Column

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('PITCH: ', style: TextStyle(color: theme.textSecondary, fontWeight: FontWeight.bold)),
        Text(
          '${(data.pitch > 360 ? 360.0 : data.pitch).toStringAsFixed(2)}°',
          style: TextStyle(color: theme.textOnSurface, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    const SizedBox(height: 8),
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () => _showCalibrateDialog(context, 'Pitch', 0, data.pitch),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2ECC71),  // Semantic green — hardcoded
            foregroundColor: Colors.white,
          ),
          child: const Text('Calibrate'),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () async { /* Reset Pitch */ },  // shows confirmation dialog first
          icon: const Icon(Icons.refresh),
          color: theme.appBarAccent,
          tooltip: 'Reset Pitch',
        ),
      ],
    ),
  ],
)
```

**Pitch Calibrate Dialog** — calls `_showCalibrateDialog('Pitch', mode: 0, currentValue: data.pitch)`.

**Pitch Reset** — requires `DialogUtils.showConfirmationDialog` first, then sends:
```
calibrateCommand(value1: 0.0, mode: 64) // OpCode 0x52
```

### Roll Control Column

Identical structure to Pitch. Replace:
- Label: `'ROLL: '` and value: `data.roll`
- Calibrate mode: `1`
- Reset mode: `65`

### Vertical Divider (between Roll and Accelero)

```dart
Container(width: 1, height: double.infinity, color: theme.dividerColor)
```

### Accelero Control Column

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('ACCELERO CALIBRATION', style: TextStyle(color: theme.textSecondary, fontWeight: FontWeight.bold)),
    const SizedBox(height: 16),
    Row(
      children: [
        ElevatedButton.icon(       // START
          icon: const Icon(Icons.play_arrow),
          label: const Text('START'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2ECC71),   // Semantic green — hardcoded
            foregroundColor: Colors.white,
          ),
          onPressed: () async { /* Send mode: 20 */ },
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(       // STOP
          icon: const Icon(Icons.stop),
          label: const Text('STOP'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEF4444),   // Semantic red — hardcoded
            foregroundColor: Colors.white,
          ),
          onPressed: () async { /* Send mode: 40 */ },
        ),
        const SizedBox(width: 8),
        IconButton(                // RESET
          icon: const Icon(Icons.refresh),
          color: theme.appBarAccent,
          tooltip: 'Reset Body Accelero',
          onPressed: () async { /* Confirmation → mode: 60 */ },
        ),
      ],
    ),
  ],
)
```

---

## OpCode Reference — Bottom Left Controls

| Control         | Action    | OpCode | Mode | value1 | Confirmation Required |
|-----------------|-----------|--------|------|--------|-----------------------|
| Pitch           | Calibrate | `0x52` | `0`  | user input (dialog) | No |
| Pitch           | Reset     | `0x52` | `64` | `0.0`  | **Yes** |
| Roll            | Calibrate | `0x52` | `1`  | user input (dialog) | No |
| Roll            | Reset     | `0x52` | `65` | `0.0`  | **Yes** |
| Body Accelero   | Start     | `0x52` | `20` | `0.0`  | No |
| Body Accelero   | Stop      | `0x52` | `40` | `0.0`  | No |
| Body Accelero   | Reset     | `0x52` | `60` | `0.0`  | **Yes** |

---

## Right Column: Parameters Panel

```dart
Expanded(
  flex: 1,
  child: Container(
    decoration: BoxDecoration(
      color: theme.cardSurface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: theme.cardBorderColor),
    ),
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('PARAMETERS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.textOnSurface,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 16,
              )),
        ),
        Divider(color: theme.dividerColor),
        Expanded(child: ListView(children: [ /* _buildParamCard calls */ ])),
      ],
    ),
  ),
)
```

### Parameter Cards — Body Calibration

| Abbreviation | Full Name        | SET_PARAM Type | Data Field      |
|--------------|------------------|----------------|-----------------|
| `Ant Height` | Antenna Height   | `15`           | `data.antHeight` |
| `BCX`        | Boom Center X    | `11`           | `data.bcx`      |
| `BCY`        | Boom Center Y    | `12`           | `data.bcy`      |
| `ACX`        | Axis Center X    | `13`           | `data.acx`      |
| `ACY`        | Axis Center Y    | `14`           | `data.acy`      |
| `Ant Pole Height` | Antenna Pole | `16`          | `data.antPole`  |

---

## `_buildParamCard` Widget Blueprint

```dart
Widget _buildParamCard(BuildContext context, String title, String abbreviation, int type, int value) {
  final theme = AppTheme.of(context);
  return Card(
    color: theme.cardSurface,
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: theme.cardBorderColor),
    ),
    child: InkWell(
      onTap: () => _showSetParamDialog(context, title, type, value),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(abbreviation,
                    style: TextStyle(color: theme.textOnSurface, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(title,
                    style: TextStyle(color: theme.textSecondary, fontSize: 12)),
              ],
            ),
            Text(value.toString(),
                style: TextStyle(color: theme.appBarAccent, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ),
  );
}
```

---

## `_showSetParamDialog` — Set Parameter Dialog

```dart
Future<void> _showSetParamDialog(BuildContext context, String title, int type, int currentValue) async {
  final controller = TextEditingController(text: currentValue.toString());
  return showDialog<void>(
    context: context,
    builder: (ctx) {
      final theme = AppTheme.of(ctx);
      return AlertDialog(
        backgroundColor: theme.dialogBackground,
        title: Text('Set $title', style: TextStyle(color: theme.textOnSurface)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: TextStyle(color: theme.textOnSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.inputFill,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            hintText: 'Enter new value',
            hintStyle: TextStyle(color: theme.textSecondary),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(color: theme.textSecondary)),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryButtonBackground,
              foregroundColor: theme.primaryButtonText,
            ),
            child: const Text('Set'),
            onPressed: () async {
              final port = ref.read(comServiceProvider).port;
              final newValue = int.tryParse(controller.text);
              if (port != null && newValue != null) {
                await port.write(Uint8List.fromList(_presenter.setParam(newValue, type)));
                if (context.mounted) {
                  NotificationService.showCommandNotification(
                    context, title: 'SET PARAM', message: '$title updated to $newValue',
                    modeStr: '$newValue', icon: Icons.check_circle,
                    iconColor: const Color(0xFF2ECC71), headerColor: const Color(0xFF1E3A2A),
                  );
                  Navigator.of(context).pop();
                }
              }
              // else show error notification
            },
          ),
        ],
      );
    },
  );
}
```

---

## `_showCalibrateDialog` — Calibrate Pitch/Roll Dialog

```dart
Future<void> _showCalibrateDialog(BuildContext context, String title, int mode, double currentValue) async {
  final controller = TextEditingController(text: currentValue.toStringAsFixed(2));
  return showDialog<void>(
    context: context,
    builder: (ctx) {
      final theme = AppTheme.of(ctx);
      return AlertDialog(
        backgroundColor: theme.dialogBackground,
        title: Text('Calibrate $title', style: TextStyle(color: theme.textOnSurface)),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(color: theme.textOnSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.inputFill,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            hintText: 'Enter reference value',
            hintStyle: TextStyle(color: theme.textSecondary),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(color: theme.textSecondary)),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2ECC71)),
            child: const Text('Calibrate', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              final port = ref.read(comServiceProvider).port;
              final newValue = double.tryParse(controller.text);
              if (port != null && newValue != null) {
                await port.write(Uint8List.fromList(
                  _presenter.calibrateCommand(value1: newValue, mode: mode)
                ));
                if (context.mounted) {
                  NotificationService.showCommandNotification(
                    context, title: 'CALIBRATE', message: '$title calibrated',
                    modeStr: 'with $newValue', icon: Icons.check_circle,
                    iconColor: const Color(0xFF2ECC71), headerColor: const Color(0xFF1E3A2A),
                  );
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        ],
      );
    },
  );
}
```

---

## Theme Token Usage Summary

| Element                      | Token                          |
|------------------------------|--------------------------------|
| Image container background   | `theme.cardSurface`            |
| Image container border       | `theme.cardBorderColor`        |
| Controls container background| `theme.cardSurface`            |
| Controls container border    | `theme.cardBorderColor`        |
| Parameters panel background  | `theme.cardSurface`            |
| Parameters panel border      | `theme.cardBorderColor`        |
| Label text (PITCH:, ROLL:)   | `theme.textSecondary`          |
| Value text (20.00°)          | `theme.textOnSurface`          |
| Param card value             | `theme.appBarAccent`           |
| Dividers                     | `theme.dividerColor`           |
| Reset icon buttons           | `theme.appBarAccent`           |
| Loading indicator            | `theme.appBarAccent`           |
| Dialog background            | `theme.dialogBackground`       |
| Dialog input fill            | `theme.inputFill`              |
| Set button                   | `theme.primaryButtonBackground` + `theme.primaryButtonText` |
| Calibrate button (dialog)    | `Color(0xFF2ECC71)` _(hardcoded)_ |
| START Accelero button        | `Color(0xFF2ECC71)` _(hardcoded)_ |
| STOP Accelero button         | `Color(0xFFEF4444)` _(hardcoded)_ |
| Pitch/Roll Calibrate button  | `Color(0xFF2ECC71)` _(hardcoded)_ |
