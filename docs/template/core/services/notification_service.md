# Notification Service Detail

Global utility for consistent user feedback and command confirmation.

## 1. Basic Notifications
- `showSnackbar`: Standard floating toast.
- `showError` / `showSuccess` / `showWarning`: Semantic wrappers with predefined colors (Red, Green, Orange).

## 2. Command Notifications (`showCommandNotification`)
- **Purpose**: High-impact overlay shown after sending hardware configuration commands (e.g., Calibration "SET").
- **Layout**:
  - Centered UI using responsive margins (`screenWidth * 0.4`).
  - **Header**: Colored block (e.g., Green for Success, Blue for Info) with an icon and title.
  - **Body**: Large, bold status text (`modeStr`) and a descriptive message.
- **UX**: Automatically clears previous snackbars to prevent stack buildup.

## 3. Global Messenger
- Uses a `GlobalKey<ScaffoldMessengerState>` to allow notification triggering from any service without needing a `BuildContext`.

---
> [!TIP]
> Use this service instead of standard `SnackBar` to maintain the premium dashboard aesthetic.
