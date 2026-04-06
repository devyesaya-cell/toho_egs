# Notification Service — Blueprint

**File**: `lib/core/services/notification_service.dart`  
**Class**: `NotificationService` (pure static class, no instantiation)

_A centralized service for all user-facing feedback. Provides simple semantic snackbars and a high-impact themed command notification overlay._

---

## Imports Required

```dart
import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
```

---

## Class Structure

```dart
class NotificationService {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackbar(String message, {Color? backgroundColor}) { ... }
  static void showError(String message) { ... }
  static void showSuccess(String message) { ... }
  static void showWarning(String message) { ... }
  static void showCommandNotification(BuildContext context, { ... }) { ... }
}
```

> [!IMPORTANT]
> `messengerKey` must be registered as the `scaffoldMessengerKey` on the root `MaterialApp` to allow `showSnackbar`, `showError`, `showSuccess`, and `showWarning` to work **without a `BuildContext`**. Without this registration, only `showCommandNotification` (which takes a `BuildContext`) will work.
>
> ```dart
> MaterialApp(
>   scaffoldMessengerKey: NotificationService.messengerKey,
>   ...
> )
> ```

---

## Method 1: `showSnackbar`

The base method. Displays a simple floating `SnackBar` using the global `messengerKey`.

```dart
static void showSnackbar(String message, {Color? backgroundColor}) {
  messengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor ?? Colors.black87,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}
```

| Parameter         | Type     | Default          | Description                    |
|-------------------|----------|------------------|--------------------------------|
| `message`         | `String` | required         | Text to display in the snackbar |
| `backgroundColor` | `Color?` | `Colors.black87` | Background color of the snackbar |

---

## Method 2: `showError`

Semantic wrapper for error feedback.

```dart
static void showError(String message) {
  showSnackbar(message, backgroundColor: Colors.red);
}
```

**Usage example:**
```dart
NotificationService.showError('Port not connected');
```

---

## Method 3: `showSuccess`

Semantic wrapper for success feedback.

```dart
static void showSuccess(String message) {
  showSnackbar(message, backgroundColor: Colors.green);
}
```

**Usage example:**
```dart
NotificationService.showSuccess('Header 0x81: Success from Rover');
```

---

## Method 4: `showWarning`

Semantic wrapper for warning feedback.

```dart
static void showWarning(String message) {
  showSnackbar(message, backgroundColor: Colors.orange);
}
```

---

## Method 5: `showCommandNotification`

The primary UI notification for hardware command results. Displays a themed, centered floating overlay with a header + body layout. Auto-dismisses after 2 seconds.

### Signature

```dart
static void showCommandNotification(
  BuildContext context, {
  required String title,
  required String message,
  required String modeStr,
  required IconData icon,
  required Color iconColor,
  required Color headerColor,
})
```

### Parameters

| Parameter     | Type        | Description                                                              |
|---------------|-------------|--------------------------------------------------------------------------|
| `context`     | `BuildContext` | Used for `MediaQuery` sizing and `ScaffoldMessenger` access           |
| `title`       | `String`    | Text displayed in the **header** bar (e.g., `'SET PARAM'`, `'CALIBRATE'`, `'RESET'`)  |
| `message`     | `String`    | Descriptive text in the **body** (e.g., `'Antenna Height updated to 150'`) |
| `modeStr`     | `String`    | Large bold text in the **body** (e.g., `'150'`, `'START'`, `'STOP'`, `'Completed'`) |
| `icon`        | `IconData`  | Icon displayed in the header next to the title                           |
| `iconColor`   | `Color`     | Color of the header icon                                                 |
| `headerColor` | `Color`     | Background color of the header section                                   |

### Implementation

```dart
static void showCommandNotification(
  BuildContext context, {
  required String title,
  required String message,
  required String modeStr,
  required IconData icon,
  required Color iconColor,
  required Color headerColor,
}) {
  if (!context.mounted) return;

  final mediaQuery = MediaQuery.of(context);
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  final double screenWidth = mediaQuery.size.width;
  final double screenHeight = mediaQuery.size.height;
  final double leftRightMargin = screenWidth * 0.4;   // 40% each side → 20% total width
  final double bottomMargin = screenHeight * 0.4;      // 40% from bottom → vertically centered

  final theme = AppTheme.of(context);

  scaffoldMessenger.clearSnackBars();  // Always clear existing snackbars first
  scaffoldMessenger.showSnackBar(
    SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(
        bottom: bottomMargin,
        left: leftRightMargin,
        right: leftRightMargin,
      ),
      content: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: theme.dialogBackground,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── HEADER ──
            Container(
              width: double.infinity,
              color: headerColor,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  Icon(icon, color: iconColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: theme.textOnSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // ── BODY ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: [
                  Text(
                    message,
                    style: TextStyle(color: theme.textSecondary, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    modeStr,
                    style: TextStyle(
                      color: theme.textOnSurface,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
```

---

## Visual Layout of `showCommandNotification`

```
┌─────────────────────────────────┐
│ [icon] TITLE                    │  ← headerColor background
│                                 │    icon: 20px, text: bold 16px
├─────────────────────────────────┤    text color: theme.textOnSurface
│                                 │
│        message text             │  ← theme.dialogBackground background
│       (14px, centered)          │    text color: theme.textSecondary
│                                 │
│          MODESTR                │  ← 24px, bold, centered
│                                 │    text color: theme.textOnSurface
│                                 │
└─────────────────────────────────┘
     ↑ Positioned at 40% from bottom, 40% margin each side
```

---

## Positioning Logic

| Property          | Value                    | Result                                          |
|-------------------|--------------------------|-------------------------------------------------|
| `left margin`     | `screenWidth * 0.4`      | 40% from left edge                              |
| `right margin`    | `screenWidth * 0.4`      | 40% from right edge → card is **20% screen width** |
| `bottom margin`   | `screenHeight * 0.4`     | 40% from bottom → appears near vertical center  |
| `behavior`        | `floating`               | Floats above bottom navigation if present        |
| `backgroundColor` | `Colors.transparent`     | SnackBar itself is invisible, only content shows |
| `elevation`       | `0`                      | No SnackBar shadow (shadow is on the Container)  |
| `padding`         | `EdgeInsets.zero`        | No default SnackBar padding                      |
| `duration`        | `Duration(seconds: 2)`   | Auto-dismiss after 2 seconds                     |

---

## Standard Usage Patterns

### Success — Calibration / Set Param

```dart
NotificationService.showCommandNotification(
  context,
  title: 'SET PARAM',
  message: 'Antenna Height updated to 150',
  modeStr: '150',
  icon: Icons.check_circle,
  iconColor: const Color(0xFF2ECC71),     // Semantic green
  headerColor: const Color(0xFF1E3A2A),   // Dark green header
);
```

### Success — Calibrate Action

```dart
NotificationService.showCommandNotification(
  context,
  title: 'CALIBRATE',
  message: 'Boom Tilt calibrated',
  modeStr: 'Completed',
  icon: Icons.check_circle,
  iconColor: const Color(0xFF2ECC71),
  headerColor: const Color(0xFF1E3A2A),
);
```

### Start Accelero

```dart
NotificationService.showCommandNotification(
  context,
  title: 'ACCELERO',
  message: 'Calibration Started',
  modeStr: 'START',
  icon: Icons.play_arrow,
  iconColor: const Color(0xFF2ECC71),
  headerColor: const Color(0xFF1E3A2A),
);
```

### Stop Accelero

```dart
NotificationService.showCommandNotification(
  context,
  title: 'ACCELERO',
  message: 'Calibration Stopped',
  modeStr: 'STOP',
  icon: Icons.stop,
  iconColor: const Color(0xFFEF4444),     // Semantic red
  headerColor: const Color(0xFF3F1D1D),   // Dark red header
);
```

### Reset

```dart
NotificationService.showCommandNotification(
  context,
  title: 'RESET',
  message: 'Pitch Berhasil di reset',
  modeStr: 'Completed',
  icon: Icons.refresh,
  iconColor: theme.appBarAccent,          // Theme teal
  headerColor: theme.cardSurface,         // Theme card surface
);
```

### Error — Port Not Connected

```dart
NotificationService.showCommandNotification(
  context,
  title: 'ERROR',
  message: 'Port not connected',
  modeStr: 'ERROR',
  icon: Icons.error,
  iconColor: const Color(0xFFEF4444),
  headerColor: const Color(0xFF3F1D1D),
);
```

---

## Standard Color Combinations Reference

| Scenario            | `iconColor`          | `headerColor`        | `icon`                   |
|---------------------|----------------------|----------------------|--------------------------|
| Success / Set / Cal | `0xFF2ECC71` (green) | `0xFF1E3A2A` (dk grn)| `Icons.check_circle`     |
| START               | `0xFF2ECC71` (green) | `0xFF1E3A2A` (dk grn)| `Icons.play_arrow`       |
| STOP                | `0xFFEF4444` (red)   | `0xFF3F1D1D` (dk red)| `Icons.stop` / `stop_circle` |
| RESET               | `theme.appBarAccent` | `theme.cardSurface`  | `Icons.refresh`          |
| ERROR               | `0xFFEF4444` (red)   | `0xFF3F1D1D` (dk red)| `Icons.error`            |
| OFFSET START        | `0xFF2ECC71` (green) | `0xFF1E3A2A` (dk grn)| `Icons.check_circle`     |
| OFFSET STOP         | `0xFFEF4444` (red)   | `0xFF3F1D1D` (dk red)| `Icons.stop_circle`      |

---

## Theme Token Usage Inside `showCommandNotification`

| Element                       | Token Used                             |
|-------------------------------|----------------------------------------|
| Card/container background     | `theme.dialogBackground`               |
| Header title text color       | `theme.textOnSurface`                  |
| Body message text color       | `theme.textSecondary`                  |
| Body modeStr text color       | `theme.textOnSurface`                  |
| Header background             | Caller-provided `headerColor` (hardcoded semantic) |
| Header icon color             | Caller-provided `iconColor` (hardcoded semantic)   |

> [!NOTE]
> `showError`, `showSuccess`, `showWarning`, and `showSnackbar` use **semantic hardcoded colors** (`Colors.red`, `Colors.green`, etc.) because they are contextless and do not have access to a `BuildContext`. Only `showCommandNotification` is theme-aware.

> [!TIP]
> Always call `context.mounted` check before `showCommandNotification` in async functions. The service itself also guards with `if (!context.mounted) return;` at the top, but it's good practice to check before calling:
> ```dart
> await port.write(command);
> if (context.mounted) {
>   NotificationService.showCommandNotification(context, ...);
> }
> ```
