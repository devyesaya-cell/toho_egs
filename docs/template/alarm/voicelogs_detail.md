# Voice Logs & Alerts Detail

**Path**: `lib/features/alarm/alarm_page.dart`  
**Page Class**: `VoicelogsPage`  
**Pattern**: Log History List (Standardized Card Flow)

## 1. Page Layout
- **Style**: `Scaffold` with themed `AppBar` and a full-width `ListView`.
- **Title**: "VOICE LOGS / ALARM" with icon `warning_amber_rounded`.
- **Subtitle**: "EGS ALARM V4.0.0" in small, secondary font.
- **Actions**:
    - `delete_sweep_outlined`: Triggers `_confirmClearLogs` dialog.
    - `GlobalAppBarActions`: Reusable status icons.

## 2. Body Implementation
- **Provider**: `voiceMessageStreamProvider` (Riverpod `.when` syntax).
- **Empty State**: Displays `speaker_notes_off_outlined` icon and "Belum ada rekaman suara."
- **Data State**: `ListView.builder` for historical voice logs.

## 3. Message Card Specification
- **Implementation**: `_buildMessageCard` widget.
- **Interactivity**: `InkWell` on the card triggers verbal playback via `voiceRecognitionProvider.notifier.speak(msg.text)`.
- **Card visual components**:
    - **Play Button (Leading)**: Circle shape (Green 10% opacity) with `play_arrow_rounded` icon.
    - **Header**: Sender name (bold) on left, timestamp (`HH:mm:ss - dd MMM yyyy`) on right.
    - **Body**: The alert message text in semi-bold (16px).

## 4. Logical Behaviors
- **Clear Logs**:
    - **UI**: `AlertDialog` with Red `ElevatedButton` for confirmation.
    - **Mechanism**: Calls `ref.read(voiceMessageRepositoryProvider).clearAll()`.
- **Playback**: Single tap on any card repeats the voice message through the local hardware speaker.

---
> [!IMPORTANT]
> This page relies on the `voiceMessageStreamProvider` for real-time streaming of incoming alerts from the hardware or background services. Any new message saved to the database will automatically appear at the top of the list.
