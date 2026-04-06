# Radio Page Blueprint

**Path**: `lib/features/setup/pages/radio_page.dart`  
**Type**: Page (ConsumerStatefulWidget)

## 1. Overview
The `RadioPage` offers a split-screen 1:1 view for the user to tune the EGS radio hardware configurations. It relies on Riverpod for state management.

## 2. Architecture & State Management
- **State/Providers**: Watches `radioProvider` and `comServiceProvider`.
- **Initialization**: `initState()` calls `_presenter.getRadioConfig(usbState.port)` inside `addPostFrameCallback` assuming USB is connected.
- **Data Model**: `RadioConfig`.

## 3. Layout Specification

### Base Layout
- **Scaffold**: Single-page setup (no Tabs).
- **BackgroundColor**: `theme.pageBackground`
- **AppBar**: Uses the standard single-page AppBar Blueprint found in [theme_system](file:///c:/apps/toho_EGS/docs/template/theme_system.md).
  - Title: 'RADIO CONFIG' 
  - Subtitle: 'EGS RADIO V4.0.0'
  - Leading Icon: `Icons.radio`
- **Body**: `Row` splitting the screen exactly in half `Expanded(flex: 1)`.

### Left Column (Visuals & Actions)
- **Padding**: `EdgeInsets.all(32.0)`
- **Structure**: `Column` with `mainAxisAlignment: spaceBetween`.
- **Top Section**: `Image.asset` varying by light/dark mode (`images/light_cfg.jpeg` or `images/dark_cfg.jpeg`), wrapped in `Expanded` & `Center` with `fit: BoxFit.contain`.
- **Spacing**: `SizedBox(height: 32)` below the image.
- **Bottom Section**: "SAVE CONFIG" button.
  - **Widget**: `ElevatedButton.icon` inside `SizedBox(width: double.infinity, height: 64)`.
  - **Colors**: `backgroundColor: theme.primaryButtonBackground`, `foregroundColor: theme.primaryButtonText`.
  - **Icon Size**: 28.
  - **Text Style**: `fontSize: 20`, `fontWeight: bold`, `letterSpacing: 1.5`.
  - **BorderRadius**: 16.
  - **Elevation**: 4.

### Right Column (Parameter Preview)
- **Container Styling**:
  - `margin`: `EdgeInsets.all(32.0)`
  - `padding`: `EdgeInsets.all(32.0)`
  - `decoration`: `color: theme.cardSurface`, `borderRadius: 24`
  - `border`: `Border.all(color: theme.appBarAccent.withValues(alpha: 0.3), width: 2)`
  - `shadow`: `BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 10, offset: Offset(0, 5))`
- **Header Structure**:
  - `Row` with title "RADIO PARAMETERS PREVIEW" (`color: theme.textOnSurface`, `fontSize: 20`, `bold`).
  - `Spacer()`.
  - Refresh `IconButton` (`Icons.refresh`, `color: theme.textSecondary`), triggers `_presenter.getRadioConfig()`.
  - "LIVE" badge: Visible if `radioData != null`. `color: theme.appBarAccent.withValues(alpha: 0.2)` with text color `theme.appBarAccent`.
- **Divider**: `height: 48, thickness: 1, color: theme.dividerColor`.
- **Main Content (`radioData != null`)**:
  - A `SingleChildScrollView` of `_buildConfigItem` rows: Channel, Key, Address, Net ID, Air Data Rate, Last Update.
- **Main Content (`radioData == null`)**:
  - Center loading/wait state: `Icon(Icons.wifi_off, size: 48, color: theme.textSecondary)` with warning text.

---

## 4. Sub-Components

### Config Item Container (`_buildConfigItem`)
- **Margin**: `marginBottom: 16.0`
- **Padding**: `EdgeInsets.all(16.0)`
- **Decoration**: `color: theme.pageBackground`, `borderRadius: 12`, `border: Border.all(color: theme.cardBorderColor)`.
- **Structure**:
  - Icon (`theme.textSecondary`).
  - Label (`theme.textSecondary`).
  - `Spacer()`.
  - Value text (`theme.textOnSurface`, `fontSize: 18`, `bold`, `letterSpacing: 1.1`).

### Save Action Dialog (`_showSaveDialog`)
- **Widget**: `AlertDialog`.
- **Shape**: `RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))`.
- **BackgroundColor**: `theme.dialogBackground`.
- **TextField Elements (`_buildInputField`)**:
  - Type: `TextInputType.number`.
  - `style`: `color: theme.inputTextColor`.
  - `decoration`: `filled: true, fillColor: theme.inputFill`, label styling with `theme.textSecondary`.
  - `enabledBorder`: `theme.inputBorder`.
  - `focusedBorder`: `theme.inputFocusedBorder`.
- **Actions**:
  - **Cancel**: `TextButton` (`color: theme.textSecondary`).
  - **Set Config**: `ElevatedButton` (`backgroundColor: theme.primaryButtonBackground`, `foregroundColor: theme.primaryButtonText`).
  - Calls `_presenter.setRadio(...)` then displays a `SnackBar` containing success message (`backgroundColor: theme.appBarAccent`).

---

## 5. Formatting Logic

> [!IMPORTANT]
> Radio parameters like `Key` and `Address` are often displayed as Hexadecimal (`0x...`) but entered/stored as Decimals.

**Hex Conversion for Preview:**
- Address/Key rendering: `'0x${val.toRadixString(16).padLeft(4, '0').toUpperCase()}'`

**Time Formatting for Preview:**
- Time rendering: `DateTime.fromMillisecondsSinceEpoch(epochMs)` rendering `HH:mm:ss`. Default logic implemented directly within the file `_formatTime(int epochMs)`.
