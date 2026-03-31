# Voice Recognition Service Detail

Multimodal offline voice interaction system.

## 1. Components
- **Wake-Word (Porcupine)**:
  - Uses `PorcupineManager` from Picovoice.
  - Listens for "Porcupine" or "Bumblebee" (offline).
  - Triggers the STT listener automatically upon detection.
- **STT (SpeechToText)**:
  - Supports `id-ID` for localized operator commands.
  - Final results are automatically persisted to the `VoiceMessageRepository`.
- **TTS (FlutterTts)**:
  - Configured for `id-ID` with a rate of `0.5` and pitch `1.0`.
  - Used for confirming commands ("Iya, saya mendengarkan") and reading alerts.

## 2. Configuration
- Requires a valid **Picovoice AccessKey**.
- Microphone permission MUST be granted for both Standby (Wake-Word) and Listening (STT) modes.

## 3. State Management
- `VoiceRecognitionNotifier` (Riverpod) tracks `isListening`, `isStandbyActive`, and error states.

---
> [!NOTE]
> All recognized words are stored as `VoiceMessage` entities in the database for historical audit.
