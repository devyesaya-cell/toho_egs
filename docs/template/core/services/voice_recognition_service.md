# Voice Recognition Service — Blueprint

**File**: `lib/core/services/voice_recognition_service.dart`  
**Classes**: `VoiceRecognitionState` + `VoiceRecognitionNotifier` (Riverpod `Notifier`) + `voiceRecognitionProvider`

_A Riverpod-driven service that combines three offline voice capabilities: Wake-word (Standby) detection via Porcupine, Speech-to-Text (STT) via `speech_to_text`, and Text-to-Speech (TTS) via `flutter_tts`. Recognized speech is automatically persisted to the Isar database via `VoiceMessageRepository`._

---

## Imports Required

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:porcupine_flutter/porcupine.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../database/voice_message_repository.dart';
import 'dart:async';
```

---

## Required `pubspec.yaml` Packages

```yaml
dependencies:
  speech_to_text: ^6.x.x           # Offline device STT
  flutter_tts: ^4.x.x              # Text-to-Speech
  porcupine_flutter: ^3.x.x        # Wake-word detection (Picovoice)
  permission_handler: ^12.x.x      # Microphone permission
```

---

## Part 1: `VoiceRecognitionState` (Immutable State Class)

```dart
class VoiceRecognitionState {
  final bool isSTTInitialized;   // true when SpeechToText engine is ready
  final bool isListening;        // true while actively recording/listening
  final bool isStandbyActive;    // true when Porcupine wake-word engine is running
  final String text;             // Last recognized speech text (partial or final)
  final String error;            // Last error message (empty = no error)

  const VoiceRecognitionState({
    this.isSTTInitialized = false,
    this.isListening = false,
    this.isStandbyActive = false,
    this.text = '',
    this.error = '',
  });

  VoiceRecognitionState copyWith({
    bool? isSTTInitialized,
    bool? isListening,
    bool? isStandbyActive,
    String? text,
    String? error,
  }) { ... }
}
```

| Field              | Type     | Default  | Description                                   |
|--------------------|----------|----------|-----------------------------------------------|
| `isSTTInitialized` | `bool`   | `false`  | Whether `SpeechToText` has been initialized   |
| `isListening`      | `bool`   | `false`  | Whether STT is actively recording             |
| `isStandbyActive`  | `bool`   | `false`  | Whether Porcupine wake-word detection is on   |
| `text`             | `String` | `''`     | Live/final recognized text from STT           |
| `error`            | `String` | `''`     | Latest error message (empty = no error)       |

---

## Part 2: `VoiceRecognitionNotifier` (Riverpod Notifier)

```dart
class VoiceRecognitionNotifier extends Notifier<VoiceRecognitionState> {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  PorcupineManager? _porcupineManager;

  // ⚠️ MUST REPLACE with actual Picovoice AccessKey
  static const String _picovoiceAccessKey = "YOUR_PICOVOICE_ACCESS_KEY";

  @override
  VoiceRecognitionState build() {
    _initTTS();
    _initSpeech();
    return const VoiceRecognitionState();
  }
  ...
}
```

> [!CAUTION]
> `_picovoiceAccessKey` is a placeholder. **Must be replaced** with a real key from [console.picovoice.ai](https://console.picovoice.ai) before wake-word detection can function. The service will set an error state if the placeholder is detected.

---

## Initialization (called in `build()`)

### `_initTTS()` — Text-to-Speech Setup

```dart
void _initTTS() {
  _flutterTts.setLanguage("id-ID");     // Indonesian language
  _flutterTts.setPitch(1.0);            // Normal pitch
  _flutterTts.setSpeechRate(0.5);       // Half speed (slower, clearer)
}
```

### `_initSpeech()` — STT Engine Initialization

```dart
Future<void> _initSpeech() async {
  try {
    bool initialized = await _speechToText.initialize(
      onStatus: (status) {
        if (status == 'listening') {
          state = state.copyWith(isListening: true, error: '');
        } else if (status == 'notListening' || status == 'done') {
          state = state.copyWith(isListening: false);
        }
      },
      onError: (errorNotification) {
        state = state.copyWith(
          isListening: false,
          error: errorNotification.errorMsg,
        );
      },
    );
    state = state.copyWith(isSTTInitialized: initialized);
  } catch (e) {
    state = state.copyWith(error: 'STT Error: $e');
  }
}
```

**STT Status → State mapping:**

| STT Status      | State Change                               |
|-----------------|--------------------------------------------|
| `'listening'`   | `isListening: true`, `error: ''`           |
| `'notListening'`| `isListening: false`                       |
| `'done'`        | `isListening: false`                       |
| error callback  | `isListening: false`, `error: errorMsg`    |

---

## Public Methods

### `speak(String text)` — Text-to-Speech Output

```dart
Future<void> speak(String text) async {
  if (text.isNotEmpty) {
    await _flutterTts.speak(text);
  }
}
```

Guards against empty string. Speaks immediately using FlutterTts.

---

### `toggleStandby(bool enable)` — Wake-Word Mode Toggle

```dart
Future<void> toggleStandby(bool enable) async {
  if (enable) {
    await _startPorcupine();
  } else {
    await _stopPorcupine();
  }
}
```

**Usage:**
```dart
// Turn on standby (wake-word detection)
ref.read(voiceRecognitionProvider.notifier).toggleStandby(true);

// Turn off standby
ref.read(voiceRecognitionProvider.notifier).toggleStandby(false);
```

---

### `startListening()` — Manual STT Start

```dart
Future<void> startListening() async {
  var status = await Permission.microphone.request();
  if (status != PermissionStatus.granted) {
    state = state.copyWith(error: 'Izin mikrofon tidak diberikan.');
    return;
  }

  if (!state.isSTTInitialized) {
    await _initSpeech();  // Lazy init if not yet initialized
  }

  if (state.isSTTInitialized) {
    state = state.copyWith(text: '', error: '');  // Clear previous
    await _speechToText.listen(
      onResult: _onSpeechResult,
      localeId: 'id_ID',        // Indonesian
      onDevice: true,            // Offline processing
      listenMode: ListenMode.dictation,
      cancelOnError: true,
      partialResults: true,      // Streams partial text as user speaks
    );
  }
}
```

**STT `listen()` parameters:**

| Parameter       | Value                       | Description                              |
|-----------------|-----------------------------|------------------------------------------|
| `localeId`      | `'id_ID'`                   | Indonesian language locale               |
| `onDevice`      | `true`                      | Fully offline — no network required      |
| `listenMode`    | `ListenMode.dictation`      | Continuous dictation mode                |
| `cancelOnError` | `true`                      | Auto-cancel on recognition error         |
| `partialResults`| `true`                      | Fire `onResult` with intermediate words  |

---

### `stopListening()` — Manual STT Stop

```dart
Future<void> stopListening() async {
  await _speechToText.stop();
  state = state.copyWith(isListening: false);
}
```

---

## Private Methods

### `_startPorcupine()` — Wake-Word Engine Start

```dart
Future<void> _startPorcupine() async {
  // Guard: block if no real API key
  if (_picovoiceAccessKey == "YOUR_PICOVOICE_ACCESS_KEY") {
    state = state.copyWith(error: "Mohon masukkan Picovoice AccessKey di service.");
    return;
  }

  // Request microphone permission
  var status = await Permission.microphone.request();
  if (status != PermissionStatus.granted) {
    state = state.copyWith(error: 'Izin mikrofon diperlukan untuk Standby.');
    return;
  }

  try {
    _porcupineManager = await PorcupineManager.fromBuiltInKeywords(
      _picovoiceAccessKey,
      [BuiltInKeyword.PORCUPINE, BuiltInKeyword.BUMBLEBEE],  // Wake-words
      (keywordIndex) {
        if (keywordIndex >= 0) {
          speak("Iya, saya mendengarkan.");  // TTS acknowledgment
          startListening();                  // Auto-start STT
        }
      },
    );
    await _porcupineManager?.start();
    state = state.copyWith(isStandbyActive: true, error: '');
  } on PorcupineException catch (e) {
    state = state.copyWith(error: "Standby Error: ${e.message}");
  } catch (e) {
    state = state.copyWith(error: "Standby Error: $e");
  }
}
```

**Configured Wake-Words:**

| Keyword               | Trigger phrase      |
|-----------------------|---------------------|
| `BuiltInKeyword.PORCUPINE`   | "Porcupine" |
| `BuiltInKeyword.BUMBLEBEE`   | "Bumblebee" |

**Wake-word detection callback behavior:**
1. Calls `speak("Iya, saya mendengarkan.")` — Indonesian TTS acknowledgment
2. Calls `startListening()` — immediately starts STT recording

---

### `_stopPorcupine()` — Wake-Word Engine Stop

```dart
Future<void> _stopPorcupine() async {
  await _porcupineManager?.stop();
  await _porcupineManager?.delete();   // Must call delete() to release native resources
  _porcupineManager = null;
  state = state.copyWith(isStandbyActive: false);
}
```

> [!CAUTION]
> Both `stop()` AND `delete()` must be called to properly release Porcupine's native audio resources. Failing to call `delete()` causes memory leaks.

---

### `_onSpeechResult(SpeechRecognitionResult result)` — STT Result Handler

```dart
void _onSpeechResult(SpeechRecognitionResult result) {
  state = state.copyWith(text: result.recognizedWords);

  if (result.finalResult && result.recognizedWords.isNotEmpty) {
    // Persist to database only on final result (not partial)
    ref.read(voiceMessageRepositoryProvider).addMessage(
      result.recognizedWords,
      sender: 'Driver',
    );
  }
}
```

**Result handling logic:**

| Condition                                    | Action                                    |
|----------------------------------------------|-------------------------------------------|
| Always (partial or final)                    | Update `state.text` with recognized words |
| `result.finalResult == true` AND non-empty   | Save to database via `VoiceMessageRepository` |
| `result.finalResult == false` (partial)      | Only update state — no DB write           |

---

## Provider

```dart
final voiceRecognitionProvider =
    NotifierProvider<VoiceRecognitionNotifier, VoiceRecognitionState>(() {
  return VoiceRecognitionNotifier();
});
```

---

## State Flow Diagram

```
App Start
  └── build() → _initTTS() + _initSpeech()
                    └── state.isSTTInitialized = true/false

User toggles Standby ON
  └── toggleStandby(true) → _startPorcupine()
        ├── Request microphone permission
        ├── PorcupineManager.fromBuiltInKeywords(...)
        └── state.isStandbyActive = true

[Wake-word "Porcupine" or "Bumblebee" detected]
  └── callback(keywordIndex)
        ├── speak("Iya, saya mendengarkan.")  [TTS]
        └── startListening()
              ├── state.text = '', error = ''
              └── _speechToText.listen(...) → state.isListening = true

[User speaks]
  └── _onSpeechResult(result)
        ├── state.text = recognizedWords  [partial updates]
        └── if finalResult → VoiceMessageRepository.addMessage(...)  [DB save]

[STT done]
  └── status = 'done' → state.isListening = false

User toggles Standby OFF
  └── toggleStandby(false) → _stopPorcupine()
        ├── porcupineManager.stop() + .delete()
        └── state.isStandbyActive = false
```

---

## Required Android Permissions (`AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.INTERNET" />
```

> [!NOTE]
> `RECORD_AUDIO` is required for both Porcupine (wake-word) and `speech_to_text`. It must be declared in the manifest AND requested at runtime via `Permission.microphone.request()`. The service handles the runtime request internally.
