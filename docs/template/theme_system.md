# Theme System Template

This document defines the standard dual-theme (Light & Dark) tokens and styling rules, ensuring a consistent and premium look across the application.

## 1. Dark Mode (SCADA Dark)
The primary mode for industrial and low-light environments.

| Token | Hex Code | Description |
| :--- | :--- | :--- |
| **Page Background** | `0xFF0D1118` | Deep foundation background. |
| **Surface/Card** | `0xFF1A2235` | Background for cards and panels. |
| **Active Accent** | `0xFF00BCD4` | Teal accent for active elements. |
| **Text Primary** | `0xFFFFFFFF` | High contrast white text. |
| **Text Secondary** | `0xFF8A94A6` | Muted grey for non-essential info. |
| **AppBar Background**| `0xFF1C2030` | Header background. |
| **Border Color** | `0xFF2A3750` | Subtle lines for structure. |

## 2. Light Mode (SCADA Light)
Alternative mode for high-ambient light environments.

| Token | Hex Code | Description |
| :--- | :--- | :--- |
| **Page Background** | `0xFFE8ECF0` | Light grey foundation background. |
| **Surface/Card** | `0xFFFFFFFF` | Pure white background for cards. |
| **Active Accent** | `0xFF00BCD4` | Same teal accent for consistency. |
| **Text Primary** | `0xFF1A1A2E` | Deep dark blue/black text. |
| **Text Secondary** | `0xFF7A8290` | Soft grey for hints. |
| **AppBar Background**| `0xFFFFFFFF` | Pure white header. |
| **Border Color** | `0xFFD0D4DA` | Subtle divider color. |

## 3. Typography & Styling Rules
- **Font**: Modern sans-serif (e.g., Inter).
- **Titles**: Bold, capitalized, letter spacing `1.2`.
- **Glow Effects**: Enabled in Dark Mode (`hasGlowEffect: true`) for premium feel.
- **Dynamic Access**: Use `AppTheme.of(context)` to automatically switch colors based on system brightness.

---
> [!TIP]
> Always preserve the semantic meaning of colors (e.g., Green for Active, Red for Error) across both themes.
