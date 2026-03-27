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

class VoiceRecognitionState {
  final bool isSTTInitialized;
  final bool isListening;
  final bool isStandbyActive;
  final String text;
  final String error;

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
  }) {
    return VoiceRecognitionState(
      isSTTInitialized: isSTTInitialized ?? this.isSTTInitialized,
      isListening: isListening ?? this.isListening,
      isStandbyActive: isStandbyActive ?? this.isStandbyActive,
      text: text ?? this.text,
      error: error ?? this.error,
    );
  }
}

class VoiceRecognitionNotifier extends Notifier<VoiceRecognitionState> {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  PorcupineManager? _porcupineManager;
  
  // TO USER: Replace with your actual Picovoice AccessKey
  static const String _picovoiceAccessKey = "YOUR_PICOVOICE_ACCESS_KEY";

  @override
  VoiceRecognitionState build() {
    _initTTS();
    _initSpeech();
    return const VoiceRecognitionState();
  }

  void _initTTS() {
    _flutterTts.setLanguage("id-ID");
    _flutterTts.setPitch(1.0);
    _flutterTts.setSpeechRate(0.5);
  }

  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

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

  Future<void> toggleStandby(bool enable) async {
    if (enable) {
      await _startPorcupine();
    } else {
      await _stopPorcupine();
    }
  }

  Future<void> _startPorcupine() async {
    if (_picovoiceAccessKey == "YOUR_PICOVOICE_ACCESS_KEY") {
      state = state.copyWith(error: "Mohon masukkan Picovoice AccessKey di service.");
      return;
    }

    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      state = state.copyWith(error: 'Izin mikrofon diperlukan untuk Standby.');
      return;
    }

    try {
      _porcupineManager = await PorcupineManager.fromBuiltInKeywords(
        _picovoiceAccessKey,
        [BuiltInKeyword.PORCUPINE, BuiltInKeyword.BUMBLEBEE],
        (keywordIndex) {
          if (keywordIndex >= 0) {
            // Wake-word detected!
            speak("Iya, saya mendengarkan.");
            startListening();
          }
        }
      );
      await _porcupineManager?.start();
      state = state.copyWith(isStandbyActive: true, error: '');
    } on PorcupineException catch (e) {
      state = state.copyWith(error: "Standby Error: ${e.message}");
    } catch (e) {
      state = state.copyWith(error: "Standby Error: $e");
    }
  }

  Future<void> _stopPorcupine() async {
    await _porcupineManager?.stop();
    await _porcupineManager?.delete();
    _porcupineManager = null;
    state = state.copyWith(isStandbyActive: false);
  }

  Future<void> startListening() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      state = state.copyWith(error: 'Izin mikrofon tidak diberikan.');
      return;
    }

    if (!state.isSTTInitialized) {
      await _initSpeech();
    }

    if (state.isSTTInitialized) {
      state = state.copyWith(text: '', error: '');
      await _speechToText.listen(
        onResult: _onSpeechResult,
        localeId: 'id_ID',
        onDevice: true,
        listenMode: ListenMode.dictation,
        cancelOnError: true,
        partialResults: true,
      );
    }
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    state = state.copyWith(isListening: false);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    state = state.copyWith(text: result.recognizedWords);
    if (result.finalResult && result.recognizedWords.isNotEmpty) {
      ref.read(voiceMessageRepositoryProvider).addMessage(
        result.recognizedWords,
        sender: 'Driver',
      );
    }
  }
}

final voiceRecognitionProvider =
    NotifierProvider<VoiceRecognitionNotifier, VoiceRecognitionState>(() {
  return VoiceRecognitionNotifier();
});
