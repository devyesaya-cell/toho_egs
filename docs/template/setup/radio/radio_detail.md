# Radio Configuration Detail

This document outlines the specialized 2-column layout used for radio hardware tuning.

## 1. Page Layout
- **Grid**: Splits the screen 1:1 horizontally.
- **Left Column**:
  - `Image.asset` for visual context (Light/Dark variants).
  - Large "SAVE CONFIG" button (`ElevatedButton.icon`).
- **Right Column**:
  - `Container` with shadow and border.
  - `Refresh` button in header to pull live config.
  - `ListView` of `_buildConfigItem` widgets.

## 2. Core Widgets
### A. Config Item
- **Structure**: Icon (Left), Label (Middle), Bold Value (Right).
- **Style**: Uses `theme.pageBackground` for the inner item container.

## 3. State Management (Presenter)
- **Presenter**: `RadioPresenter`.
- **Commands**: 
  - `getRadioConfig`: Requests current parameters from the device.
  - `setRadio`: Sends updated parameters (Channel, Key, Address, Net ID, Air Data Rate).

## 4. Input Dialog
- **Type**: `AlertDialog` with multiple `TextField` inputs.
- **Inputs**: Number-only keyboards for decimal/hex parameter entry.

---
> [!IMPORTANT]
> Radio parameters like `Key` and `Address` are often displayed as Hexadecimal (`0x...`) but entered/stored as Decimals.
