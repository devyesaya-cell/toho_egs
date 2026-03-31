# Hardware Testing Detail

This document outlines the interactive diagnostic testing tools for sensors and GPS.

## 1. Page Layout
- **Style**: `SingleChildScrollView` with central alignment.
- **Top Secton**: Real-time Heading text indicator.
- **Center Section**: Large compass-style visualizer using a rotating SVG (`exca_full.svg`).
- **Control Section**:
  - `SwitchListTile` for Voice Standby mode.
  - `FloatingActionButton` for manual Voice Recognition testing (Mic).
- **Bottom Section**: "TEXT TO SPEECH TEST" with an input field and "SPEAK" button.

## 2. Core Widgets
### A. Compass Visualizer
- **Implementation**: `Transform.rotate` wrapped around an `SvgPicture`.
- **Logic**: Driven by the `heading` value from the `gpsStreamProvider`.

## 3. State Management
- **Services**: Integrates `VoiceRecognitionService` for testing both STT (Speech-to-Text) and TTS (Text-to-Speech).

---
> [!TIP]
> Use `FittedBox` or `LayoutBuilder` to ensure the compass SVG scales appropriately across different tablet sizes.
