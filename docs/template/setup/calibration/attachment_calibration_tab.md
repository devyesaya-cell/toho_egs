# Attachment Calibration Tab — Blueprint

**File**: `lib/features/setup/widgets/calibration/attachment_calibration_tab.dart`  
**Widget Class**: `AttachmentCalibrationTab` (extends `ConsumerStatefulWidget`)

_Purpose: Align Bucket and I-Link Tilt sensors, and define complex bucket/link geometry (lengths, widths, pivot distances)._

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
> Uses **standard 3:1 Calibration Layout**. Outer padding is `16.0`. The left column's `Column` MUST use `crossAxisAlignment: CrossAxisAlignment.stretch` to make the image and controls fill the full 75%-wide left area.

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
│       │   └── Container[themed] → Image.asset('images/calibrate_3.png', fit: BoxFit.contain)
│       ├── SizedBox(height: 16)
│       └── Expanded(flex: 1)  ← BOTTOM: Controls Container
│           └── Container[themed, horizontal padding: 24, vertical: 16]
│               └── Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly)
│                   ├── Column [Bucket Tilt Control]
│                   ├── Container [Vertical Divider]
│                   ├── Column [I-Link Tilt Control]
│                   ├── Container [Vertical Divider]
│                   └── Column [Accelero Control]
├── SizedBox(width: 16)
└── Expanded(flex: 1)  ← RIGHT COLUMN (25% width)
    └── Container[themed, padding: 12]
        └── Column(crossAxisAlignment: CrossAxisAlignment.stretch)
            ├── Text('PARAMETERS') [centered]
            ├── Divider(color: theme.dividerColor)
            └── Expanded → ListView (6 Parameter Cards)
```

> [!IMPORTANT]
> The Attachment tab has **3 control groups** in the bottom area (Bucket Tilt + I-Link Tilt + Accelero), separated by **2 vertical dividers**. This is unique — all other tabs have only 2 groups with 1 divider.

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
    child: Image.asset('images/calibrate_3.png', fit: BoxFit.contain),
  ),
)
```

> [!NOTE]
> Attachment tab uses `images/calibrate_3.png` — a detailed bucket/attachment view. This is unique to this tab.

---

## Bottom Left: Controls

### Bucket Tilt Control Column

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('BUCKET TILT: ', style: TextStyle(color: theme.textSecondary, fontWeight: FontWeight.bold)),
        Text(
          '${(data.bucketTilt > 360 ? 360.0 : data.bucketTilt).toStringAsFixed(2)}°',
          style: TextStyle(color: theme.textOnSurface, fontSize: 16, fontWeight: FontWeight.bold),
          // Note: fontSize 16 here (smaller than Body/Boom/Stick which use 20)
        ),
      ],
    ),
    const SizedBox(height: 4),  // Note: 4px not 8px
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () async { /* direct send — no dialog */ },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryButtonBackground,
            foregroundColor: theme.primaryButtonText,
            minimumSize: const Size(100, 36),  // compact size
          ),
          child: const Text('Calibrate'),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () async { /* confirmation → reset */ },
          icon: const Icon(Icons.refresh),
          color: theme.appBarAccent,
          tooltip: 'Reset Bucket Tilt',
        ),
      ],
    ),
  ],
)
```

### First Vertical Divider (between Bucket Tilt and I-Link Tilt)

```dart
Container(width: 1, height: double.infinity, color: theme.dividerColor)
```

### I-Link Tilt Control Column

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('I-LINK TILT: ', style: TextStyle(color: theme.textSecondary, fontWeight: FontWeight.bold)),
        Text(
          '${(data.iLinkTilt > 360 ? 360.0 : data.iLinkTilt).toStringAsFixed(2)}°',
          style: TextStyle(color: theme.textOnSurface, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    const SizedBox(height: 4),
    ElevatedButton(       // Note: No Row wrapper, No reset button for I-Link Tilt
      onPressed: () async { /* direct send — no dialog */ },
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryButtonBackground,
        foregroundColor: theme.primaryButtonText,
        minimumSize: const Size(100, 36),
      ),
      child: const Text('Calibrate'),
    ),
  ],
)
```

> [!WARNING]
> **I-Link Tilt has NO reset button** — only the Calibrate button. Do not add an `IconButton(Icons.refresh)` here.

### Second Vertical Divider (between I-Link Tilt and Accelero)

```dart
Container(width: 1, height: double.infinity, color: theme.dividerColor)
```

### Accelero Control Column

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('ACCELERO',                          // Note: shorter label than other tabs
        style: TextStyle(
          color: theme.textSecondary,
          fontWeight: FontWeight.bold,
          fontSize: 12,                       // smaller font: 12 (vs other tabs: default)
        )),
    const SizedBox(height: 8),               // Note: 8px not 16px
    Row(children: [
      ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow, size: 16),  // smaller icon: 16
        label: const Text('START', style: TextStyle(fontSize: 12)),  // smaller label
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.primaryButtonBackground,  // uses theme (not hardcoded green)
          foregroundColor: theme.primaryButtonText,
          minimumSize: const Size(80, 36),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: () async { /* mode: 23 */ },
      ),
      const SizedBox(width: 8),
      ElevatedButton.icon(
        icon: const Icon(Icons.stop, size: 16),
        label: const Text('STOP', style: TextStyle(fontSize: 12)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF4444),  // Semantic red — hardcoded
          foregroundColor: Colors.white,
          minimumSize: const Size(80, 36),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: () async { /* mode: 43 */ },
      ),
      const SizedBox(width: 8),
      IconButton(
        icon: const Icon(Icons.refresh),
        color: theme.appBarAccent,
        tooltip: 'Reset Bucket Accelero',
        onPressed: () async { /* confirmation → mode: 63 */ },
      ),
    ]),
  ],
)
```

> [!WARNING]
> Attachment Accelero buttons use **compact sizing** (`minimumSize: Size(80, 36)`, font size 12, icon size 16) to fit all 3 control groups horizontally. Do not use the full-size button style from other tabs.

---

## OpCode Reference — Bottom Left Controls

| Control           | Action    | OpCode | Mode | value1 | Confirmation | Dialog |
|-------------------|-----------|--------|------|--------|--------------|--------|
| Bucket Tilt       | Calibrate | `0x52` | `4`  | `0.0`  | No           | **No** (direct) |
| Bucket Tilt       | Reset     | `0x52` | `68` | `0.0`  | **Yes**      | No |
| I-Link Tilt       | Calibrate | `0x52` | `5`  | `0.0`  | No           | **No** (direct) |
| Bucket Accelero   | Start     | `0x52` | `23` | `0.0`  | No           | No |
| Bucket Accelero   | Stop      | `0x52` | `43` | `0.0`  | No           | No |
| Bucket Accelero   | Reset     | `0x52` | `63` | `0.0`  | **Yes**      | No |

---

## Right Column: Parameters Panel

### Parameter Cards — Attachment Calibration (6 cards)

| Abbreviation | Full Name          | SET_PARAM Type | Data Field          |
|--------------|--------------------|----------------|---------------------|
| `BCL`        | Bucket Length      | `2`            | `data.bucketLenght` |
| `BCW`        | Bucket Width       | `4`            | `data.bucketWidth`  |
| `ILK`        | I-Link Length      | `6`            | `data.iLink`        |
| `HLK`        | H-Link Length      | `7`            | `data.hLink`        |
| `BPD`        | Bucket Pivot Disc  | `8`            | `data.bpd`          |
| `SPD`        | Stick Pivot Disc   | `9`            | `data.spd`          |

> [!NOTE]
> The Attachment tab has **6 parameter cards** — the most of any calibration tab. All use integer values (`int`) and are sent via OpCode `0x53`.

---

## `_showSetParamDialog` — Set Parameter Dialog

_Identical pattern to Body Calibration Tab. See body_calibration_tab.md for full code._

---

## Key Differences Unique to Attachment Tab

| Feature              | Attachment Tab                     | Other Tabs (Body/Boom/Stick)         |
|----------------------|------------------------------------|--------------------------------------|
| Image used           | `calibrate_3.png`                  | `calibrate_1.png` or `calibrate_2.png` |
| Control groups       | **3** (Bucket + I-Link + Accelero) | **2** (Tilt + Accelero)              |
| Vertical dividers    | **2** dividers in controls row     | **1** divider                        |
| I-Link reset button  | **None**                           | N/A                                  |
| Value font size      | `fontSize: 16`                     | `fontSize: 20`                       |
| Vertical gap below label | `SizedBox(height: 4)`          | `SizedBox(height: 8)`               |
| Button spacing below label | `SizedBox(height: 8)`        | `SizedBox(height: 16)`              |
| Accelero label       | `'ACCELERO'` (fontSize: 12)        | `'ACCELERO CALIBRATION'` (default)   |
| Button size          | `minimumSize: Size(80, 36)` + `padding: horizontal 12` | Default size   |
| START accelero color | `theme.primaryButtonBackground`    | Varies (Body: hardcoded green, Stick: theme) |

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
| Tilt label text                 | `theme.textSecondary`              |
| Tilt value text                 | `theme.textOnSurface`              |
| Param card value                | `theme.appBarAccent`               |
| Dividers                        | `theme.dividerColor`               |
| Reset / Refresh icon buttons    | `theme.appBarAccent`               |
| Loading indicator               | `theme.appBarAccent`               |
| Dialog background               | `theme.dialogBackground`           |
| Dialog input fill               | `theme.inputFill`                  |
| Bucket/I-Link Calibrate buttons | `theme.primaryButtonBackground` + `theme.primaryButtonText` |
| **START Accelero button**       | `theme.primaryButtonBackground` + `theme.primaryButtonText` _(not green!)_ |
| STOP Accelero button            | `Color(0xFFEF4444)` _(hardcoded)_  |
| Set button (dialog)             | `theme.primaryButtonBackground` + `theme.primaryButtonText` |
