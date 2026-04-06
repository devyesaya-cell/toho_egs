# Debug Page Blueprint

**Path**: `lib/features/setup/pages/debug_page.dart`  
**Type**: Page (StatelessWidget)

## 1. Overview
The `DebugPage` serves as the central diagnostic hub for the EGS system. it utilizes a tab-based navigation to separate Rover, Basestation, and Alert data streams.

---

## 2. Architecture & State Management
- **Navigation**: Managed via `DefaultTabController` (length: 3).
- **Theme Integration**: All styling is derived from `AppTheme.of(context)`.
- **Global Actions**: Includes `GlobalAppBarActions` for system-wide status (USB, Profile).

---

## 3. Layout Specification

### Scaffold Structure
- **BackgroundColor**: `theme.pageBackground`
- **AppBar**: Custom Tabbed AppBar (see [theme_system](file:///c:/apps/toho_EGS/docs/template/theme_system.md))
- **Body**: `TabBarView` containing:
  1. `RoverDebugTab()`
  2. `BasestationDebugTab()`
  3. `AlertDebugTab()`

### AppBar Details
- **BackgroundColor**: `theme.appBarBackground`
- **ForegroundColor**: `theme.appBarForeground`
- **Elevation**: `0`
- **Title Component**:
  - **Left Icon Box**: 40x40, `color: theme.iconBoxBackground`, `borderRadius: 8`, contains `Icon(Icons.bug_report, color: theme.iconBoxIcon, size: 24)`.
  - **Text Column**:
    - Title: "DEBUG" (`theme.appBarForeground`, `bold`, `fontSize: 18`, `letterSpacing: 1.2`).
    - Subtitle: "EGS DEBUG V4.0.0" (`theme.appBarAccent`, `fontSize: 10`, `fontWeight: w600`, `letterSpacing: 0.5`).
- **Actions**: `[GlobalAppBarActions(), SizedBox(width: 16)]`.
- **Bottom (TabBar)**:
  - `isScrollable: true`
  - `indicatorColor: theme.appBarAccent`
  - `labelColor: theme.appBarAccent`
  - `unselectedLabelColor: theme.textSecondary`
  - `labelStyle`: `bold`
  - **Tabs**: ["ROVER", "BASESTATION", "ALERT"]

### Body Styling
- **Decoration**: `BoxDecoration` with a top border (`theme.cardBorderColor`) to separate the TabBar from content.

---

## 4. Theme Token Mapping

| Component | Property | Token |
| :--- | :--- | :--- |
| Scaffold | `backgroundColor` | `theme.pageBackground` |
| AppBar | `backgroundColor` | `theme.appBarBackground` |
| AppBar Title | `color` | `theme.appBarForeground` |
| AppBar Subtitle | `color` | `theme.appBarAccent` |
| Icon Box | `background` | `theme.iconBoxBackground` |
| Icon Box | `iconColor` | `theme.iconBoxIcon` |
| TabBar | `indicatorColor` | `theme.appBarAccent` |
| TabBar | `labelColor` | `theme.appBarAccent` |
| TabBar | `unselectedLabelColor` | `theme.textSecondary` |
| Body Border | `color` | `theme.cardBorderColor` |

---

## 5. Verification Checklist
- [ ] `DefaultTabController` length is 3.
- [ ] AppBar matches the standard [theme_system](file:///c:/apps/toho_EGS/docs/template/theme_system.md) pattern.
- [ ] Subtitle text matches "EGS DEBUG V4.0.0".
- [ ] Body contains the three specific debug tab widgets.
- [ ] Top border decoration is present on the body container.
