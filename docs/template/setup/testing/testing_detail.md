# Hardware Testing Detail

**Path**: `lib/features/setup/pages/testing_page.dart`  
**Pattern**: Full-Screen Diagnostic Stack

## 1. Page Layout
- **Container**: `Scaffold` with `SingleChildScrollView` for scrollable diagnostic indicators.
- **Top Region**:
    - **Header**: Large heading text `Heading: ${gps.heading.toStringAsFixed(2)}°`.
- **Compass Visualizer (Center)**:
    - **Widget**: `Container` (300x300, `BoxShape.circle`, shadow).
    - **Implementation**: Uses `Transform.rotate` to calculate rotation based on `gps.heading`.
    - **Graphic**: `SvgPicture.asset('images/exca_full.svg')`.

## 2. Control Layout
- **Voice Standby Toggle**:
    - **Placement**: `Padding` horizontally 48.
    - **Widget**: `SwitchListTile` inside a themed `Container`.
    - **Logic**: Calls `TestingPresenter.notifier.toggleStandby`.
- **Manual Recognition (Mic)**:
    - **Widget**: `FloatingActionButton` with `heroTag: 'voice_mic'`.
    - **Icons**: `Icons.mic` (Listening) vs `Icons.mic_none` (Standby).
    - **Logic**: Toggles `TestingPresenter.notifier.start/stopListening`.

## 3. TTS Test Section (Bottom)
- **Header**: "TEXT TO SPEECH TEST" in uppercase, themed text.
- **Input**: `TextField` with a persistent `TextEditingController`.
- **Button**: `ElevatedButton.icon` (Style: `Color(0xFF2ECC71)`, Icon: `Icons.volume_up`).
- **Logic**: Calls `TestingPresenter.notifier.speak(text)`.

## 4. Integration Specifications
- **Provider**: `gpsStreamProvider` for raw heading data.
- **Provider**: `TestingPresenter` for user-driven interactions.
- **Theme**: Uses `AppTheme.of(context)` for all background and border colors.

---
> [!IMPORTANT]
> The compass SVG represents the vehicle's orientation. Ensure the `headingRadians` conversion (`heading * (math.pi / 180.0)`) is accurate to prevent visual drift.
