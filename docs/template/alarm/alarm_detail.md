# Alarm & Voice Logs Feature Detail

This document covers the implementation of historical alert logs and voice-notification synchronization.

## 1. Page Layout
- **Type**: `ConsumerWidget`.
- **Structure**:
  - `Scaffold` with `AppBar` featuring an alarm icon and "VOICE LOGS / ALARM" title.
  - **AppBar Actions**: `delete_sweep` icon for clearing all logs and `GlobalAppBarActions`.
  - **Body**: 
    - `Riverpod`'s `.when` handling for the `voiceMessageStreamProvider`.
    - Empty state: Centered `speaker_notes_off_outlined` icon with "No records" message.
    - Data state: `ListView.builder` for the log entries.

## 2. Core Widgets
### A. Message Card
- **Role**: Displays individual alarm or voice notification details.
- **Interactivity**: `InkWell` on the card triggers `voiceRecognitionProvider.notifier.speak(msg.text)` for audible playback.
- **Visuals**:
  - Circle-shaped play icon (Green).
  - Header: Sender name on the left, `HH:mm:ss - dd MMM yyyy` on the right.
  - Body: Large, bold message text.

## 3. State Management (Presenter)
- **Repository**: `VoiceMessageRepository` for Isar CRUD operations.
- **Service**: `VoiceRecognitionService` for offline Text-to-Speech and (potentially) command processing.
- **Flow**:
  1. System or hardware triggers an alarm.
  2. A `VoiceMessage` object is created and saved to the database.
  3. The `StreamProvider` automatically updates the UI to show the new alert.
  4. User can replay the alert voice or clear the logs.

## 4. UI Generation Rules
- **Feedback**: Cards should have a subtle border (`theme.cardBorderColor`) and elevation to look elevated against the background.
- **Icons**: Use semantic icons like `warning_amber_rounded` for the page header and `play_arrow_rounded` for message replay.

---
> [!IMPORTANT]
> The timestamp must be human-readable. Use the `intl` package to format the raw database integer into a standard date and time string.
