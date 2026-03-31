# Voice Message Repository Detail

Specialized DAO for managing offline voice logs and alarms.

## 1. Functional Scope
- **Storage**: Persists `VoiceMessage` entities (Source, Text, Timestamp).
- **Auditing**: Primarily used by the `TestingPage` and `AlarmPage` to show historical voice commands.

## 2. Implementation
- Linked directly to the `VoiceRecognitionService` result callbacks.
