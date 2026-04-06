# Testing Presenter Blueprint

**Path**: `lib/features/setup/pages/testing_presenter.dart`  
**Type**: State/Logic Controller  
**Class Name**: `TestingPresenter`

## 1. Overview
The `TestingPresenter` centralizes hardware-related diagnostic actions—primarily focusing on Voice Recognition (STT) and Text-to-Speech (TTS)—to keep the UI thin and reactive.

## 2. Core Functions

### A. Voice Standby Control
- **`toggleStandby(bool value)`**
- **Logic**: Directly interacts with `ref.read(voiceRecognitionProvider.notifier).toggleStandby(value)`.
- **Purpose**: Enables low-power "wake word" listening (Standby Mode).

### B. Manual Voice Recording
- **`startListening()`**
- **Logic**: Calls `ref.read(voiceRecognitionProvider.notifier).startListening()`.
- **`stopListening()`**
- **Logic**: Calls `ref.read(voiceRecognitionProvider.notifier).stopListening()`.

### C. Text-To-Speech (TTS)
- **`speak(String text)`**
- **Logic**: 
    - Validates `text` is not empty.
    - Triggers `ref.read(voiceRecognitionProvider.notifier).speak(text)`.
    - Commonly used to test offline auditory feedback.

## 3. Provider Integration
- **State Source**: Re-exposes components of `voiceRecognitionProvider` (listening status, recognized text, errors).
- **Navigation/UX**: Manages coordinate transformations or logic required by the UI (e.g., degree-to-radian conversion) if needed, though most raw sensor logic remains in `comServiceProvider` / `gpsStreamProvider`.

---
> [!NOTE]
> This presenter ensures the logic for "Testing" can be reused or moved without modifying the visual implementation of the compass or input fields.
