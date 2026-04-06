# Theme System
Path: `lib/core/utils/app_theme.dart`

The application uses a custom dual-theme system (Dark SCADA / Light SCADA) managed entirely through a single `AppThemeData` class and a static `AppTheme` accessor. There is **no** reliance on Flutter's built-in `ThemeData` — all color tokens are resolved manually via `AppTheme.of(context)`.

## Architecture

### `AppThemeData` (Data Class)
A plain `const` class holding **every** color token used across the entire application. Every widget reads its colors from an instance of this class — never from hardcoded values (except semantic colors like green/red for status).

### `AppTheme` (Static Accessor)
```dart
class AppTheme {
  AppTheme._(); // private constructor, no instantiation

  static const AppThemeData dark = AppThemeData(...);
  static const AppThemeData light = AppThemeData(...);

  /// Returns the correct theme based on platform brightness (system setting).
  static AppThemeData of(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? dark : light;
  }
}
```

### Usage Pattern (Every Widget)
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final theme = AppTheme.of(context);
  // Use theme.tokenName everywhere
}
```

---

## Complete Token Reference

### Login Card Tokens

| Token                          | Dark                 | Light                | Purpose                                        |
|--------------------------------|----------------------|----------------------|------------------------------------------------|
| `cardBackground`               | `0xFF1A2235`         | `0xFFFFFFFF`         | Login form card background                     |
| `cardBorder`                   | `0xFF2A3750`         | `0xFF00BCD4`         | Login form card border                         |
| `overlayOpacity`               | `0.40`               | `0.15`               | Background image overlay darkness              |
| `titleColor`                   | `0xFFFFFFFF`         | `0xFF1A1A2E`         | Form title text                                |
| `subtitleColor`                | `0xFF8A94A6`         | `0xFF7A8290`         | Form subtitle text                             |
| `labelColor`                   | `0xFF00BCD4`         | `0xFF00BCD4`         | Form field labels (teal accent, same both)     |
| `inputFill`                    | `0xFF222B40`         | `0xFFF5F7FA`         | Input field background fill                    |
| `inputBorder`                  | `0xFF2A3040`         | `0xFFD0D4DA`         | Input field border (enabled state)             |
| `inputFocusedBorder`           | `0xFF00BCD4`         | `0xFF00BCD4`         | Input field border (focused state)             |
| `inputHintText`                | `0xFF8A94A6`         | `0xFF7A8290`         | Input hint/placeholder text                    |
| `inputTextColor`               | `0xFFFFFFFF`         | `0xFF1A1A2E`         | User-typed input text                          |
| `inputIconColor`               | `0xFF8A94A6`         | `0xFF7A8290`         | Icons inside input fields                      |
| `visibilityIconColor`          | `0xFF8A94A6`         | `0xFF7A8290`         | Password visibility toggle icon                |
| `dropdownBackground`           | `0xFF1A2235`         | `0xFFFFFFFF`         | Dropdown menu popup background                 |
| `dropdownIcon`                 | `0xFF00BCD4`         | `0xFF00BCD4`         | Dropdown expand/collapse icon                  |
| `dropdownItemText`             | `0xFFFFFFFF`         | `0xFF1A1A2E`         | Dropdown menu items text                       |
| `dropdownHintText`             | `0xFF8A94A6`         | `0xFF7A8290`         | Dropdown hint when nothing selected            |
| `modeButtonBackground`         | `transparent`        | `transparent`        | Mode toggle button (unselected)                |
| `modeButtonSelectedBackground` | `0xFF00BCD4`         | `0xFF00BCD4`         | Mode toggle button (selected)                  |
| `modeButtonText`               | `0xFF8A94A6`         | `0xFF7A8290`         | Mode toggle text (unselected)                  |
| `modeButtonSelectedText`       | `0xFF0D1118`         | `0xFFFFFFFF`         | Mode toggle text (selected)                    |
| `primaryButtonBackground`      | `0xFF00BCD4`         | `0xFF00BCD4`         | Primary CTA button background                  |
| `primaryButtonText`            | `0xFF0D1118`         | `0xFFFFFFFF`         | Primary CTA button text                        |
| `primaryButtonShadow`          | `0x8000BCD4`         | `0x6000BCD4`         | Primary CTA button shadow color                |
| `usbLabelColor`                | `0xFF8A94A6`         | `0xFF7A8290`         | USB status label text                          |
| `logoBadgeBackground`          | `0x99000000`         | `0xCCFFFFFF`         | Logo badge container background                |
| `logoBadgeBorder`              | `0xFF00BCD4`         | `0xFF00BCD4`         | Logo badge container border                    |

### Global Layout Tokens

| Token                  | Dark                 | Light                | Purpose                                        |
|------------------------|----------------------|----------------------|------------------------------------------------|
| `pageBackground`       | `0xFF0D1118`         | `0xFFE8ECF0`         | Scaffold / page-level background               |
| `surfaceColor`         | `0xFF1A2235`         | `0xFFFFFFFF`         | Cards, panels, side menu surfaces              |
| `textOnSurface`        | `0xFFFFFFFF`         | `0xFF1A1A2E`         | Primary text on surface                        |
| `textSecondary`        | `0xFF8A94A6`         | `0xFF7A8290`         | Muted/secondary text                           |
| `loadingIndicatorColor`| `0xFF00BCD4`         | `0xFF00BCD4`         | CircularProgressIndicator color                |

### AppBar Tokens

| Token                 | Dark                 | Light                | Purpose                                        |
|-----------------------|----------------------|----------------------|------------------------------------------------|
| `appBarBackground`    | `0xFF1C2030`         | `0xFFFFFFFF`         | AppBar background                              |
| `appBarForeground`    | `0xFFFFFFFF`         | `0xFF1A1A2E`         | AppBar title & icon color                      |
| `appBarAccent`        | `0xFF00BCD4`         | `0xFF00BCD4`         | AppBar subtitle accent (e.g., system mode)     |
| `iconBoxBackground`   | `0xFF222B40`         | `0xFFF5F7FA`         | Icon container box in AppBar title             |
| `iconBoxIcon`         | `0xFF00BCD4`         | `0xFF00BCD4`         | Icon inside the icon container box             |

### Side Menu Tokens

| Token                      | Dark                 | Light                | Purpose                                    |
|----------------------------|----------------------|----------------------|--------------------------------------------|
| `menuBackground`           | `0xFF0D1118`         | `0xFFFFFFFF`         | Menu panel background                      |
| `menuBorder`               | `0xFF2A3750`         | `0xFFD0D4DA`         | Menu right-side border                     |
| `menuSelectedBackground`   | `0xFF1C2030`         | `0xFFF5F7FA`         | Active menu item highlight                 |
| `menuSelectedIcon`         | `0xFF00BCD4`         | `0xFF00BCD4`         | Active menu item icon                      |
| `menuSelectedText`         | `0xFFFFFFFF`         | `0xFF1A1A2E`         | Active menu item text                      |
| `menuUnselectedIcon`       | `0xFF8A94A6`         | `0xFF7A8290`         | Inactive menu item icon                    |
| `menuUnselectedText`       | `0xFF8A94A6`         | `0xFF7A8290`         | Inactive menu item text                    |
| `sectionHeaderColor`       | `0xFF8A94A6`         | `0xFF7A8290`         | Section group headers ("MENU", "SYSTEM")   |

### DateTime Widget Tokens

| Token                    | Dark                 | Light                | Purpose                                    |
|--------------------------|----------------------|----------------------|--------------------------------------------|
| `dateTimeGradientStart`  | `0xFF1A2235`         | `0xFFF5F7FA`         | Clock card gradient start                  |
| `dateTimeGradientEnd`    | `0xFF0D1118`         | `0xFFFFFFFF`         | Clock card gradient end                    |
| `dateTimeBorder`         | `0x4D00BCD4`         | `0x6000BCD4`         | Clock card border                          |
| `dateTimeClockColor`     | `0xFF00BCD4`         | `0xFF00BCD4`         | Clock digits & icon color                  |
| `dateTimeDateColor`      | `0xFF8A94A6`         | `0xFF7A8290`         | Date string text                           |
| `dateTimeIconBackground` | `0x1A00BCD4`         | `0x1A00BCD4`         | Clock icon circle background               |

### Generic Card / Container Tokens

| Token             | Dark                 | Light                | Purpose                                    |
|-------------------|----------------------|----------------------|--------------------------------------------|
| `cardSurface`     | `0xFF1A2235`         | `0xFFFFFFFF`         | Generic card background                    |
| `cardBorderColor` | `0xFF2A3750`         | `0xFF00BCD4`         | Generic card border                        |

### Form / Dialog Tokens

| Token              | Dark                 | Light                | Purpose                                    |
|--------------------|----------------------|----------------------|--------------------------------------------|
| `dialogBackground` | `0xFF1A2235`         | `0xFFFFFFFF`         | AlertDialog background                     |
| `dividerColor`     | `0xFF2A3040`         | `0xFFD0D4DA`         | Divider lines                              |

### SCADA Specifics

| Token           | Dark                 | Light                | Purpose                                    |
|-----------------|----------------------|----------------------|--------------------------------------------|
| `mapGrid`       | `0xFF162032`         | `0xFFD5DCE4`         | Map grid overlay color                     |
| `hasGlowEffect` | `true`               | `false`              | Enable neon glow effects on elements       |

---

## Standard AppBar Pattern (Per-Page Header)

Every page inside the `HomePage` shell uses a **consistent AppBar** structure. This pattern MUST be replicated exactly on every new page.

### AppBar Blueprint
```dart
appBar: AppBar(
  backgroundColor: theme.appBarBackground,
  foregroundColor: theme.appBarForeground,
  elevation: 0,
  title: Row(
    children: [
      // 1. Icon Box
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.iconBoxBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.PAGE_ICON, color: theme.iconBoxIcon, size: 24),
      ),
      const SizedBox(width: 16),
      // 2. Title + Subtitle Column
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PAGE TITLE',
            style: TextStyle(
              color: theme.appBarForeground,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'SUBTITLE / SYSTEM MODE: $systemMode',
            style: TextStyle(
              color: theme.appBarAccent,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    ],
  ),
  // 3. Right Actions
  actions: const [GlobalAppBarActions(), SizedBox(width: 16)],
),
```

### AppBar Component Details

#### Icon Box (Left)
- **Size**: 40×40
- **Shape**: `BorderRadius.circular(8)` (rounded square)
- **Background**: `theme.iconBoxBackground`
- **Icon**: Page-specific material icon, 24px, `theme.iconBoxIcon`

#### Title Column (Center-Left)
- **Title**: UPPERCASE, `fontSize: 18`, `fontWeight: bold`, `letterSpacing: 1.2`
- **Subtitle**: UPPERCASE, `fontSize: 10`, `fontWeight: w600`, `letterSpacing: 0.5`, colored with `theme.appBarAccent` (teal)
- **Spacing**: `SizedBox(height: 2)` between title and subtitle

#### GlobalAppBarActions (Right)
Path: `lib/core/widgets/global_app_bar_actions.dart`

A reusable `ConsumerWidget` placed in the `actions` array of every AppBar. Contains:

##### USB Connection Status
```
Row:
  Icon(Icons.usb, color: usbColor, size: 14)
  SizedBox(width: 4)
  Text(isActive ? 'RS232 Active' : 'RS232 Inactive')
    color: usbColor, fontSize: 12, fontWeight: bold

Logic:
  - Watches `comServiceProvider`
  - hasDataStream = lastDataReceived != null && diff < 2 seconds
  - isActive = isConnected && hasDataStream
  - Colors are SEMANTIC (fixed, not themed):
      Active:   Colors.greenAccent
      Inactive: Colors.red
```

##### Vertical Divider
```dart
Container(width: 1, height: 24, color: theme.menuBorder)
```

##### Profile Widget
```
InkWell(onTap: _showLogoutDialog, borderRadius: 8):
  Padding(horizontal: 8, vertical: 4):
    Row:
      CircleAvatar(radius: 16)
        backgroundImage: person.picURL ?? 'images/driver_exca.png'
        backgroundColor: theme.surfaceColor
      SizedBox(width: 8)
      Column(crossAxisAlignment: start, mainAxisAlignment: center):
        Text(name)
          color: theme.appBarForeground, fontWeight: bold, fontSize: 12
        Text(contractor)
          color: theme.appBarAccent, fontSize: 10
```

##### Logout Dialog (`_showLogoutDialog`)
```
AlertDialog:
  backgroundColor: theme.dialogBackground
  title: Row [Icon(Icons.logout, color: Colors.orange), Text('Sign Out', color: theme.textOnSurface)]
  content: Text('Are you sure you want to sign out?', color: theme.textSecondary)
  actions:
    TextButton('CANCEL', color: theme.textSecondary)
    ElevatedButton('SIGN OUT', backgroundColor: Colors.orange, foregroundColor: white)
      onPressed:
        1. Pop dialog
        2. If timesheet is running → stop it first
        3. Call authProvider.notifier.logout()
```

---

## Standard Tabbed AppBar Pattern

For pages that use a `TabBar` (such as Setup layout, Calibration page), wrap the `Scaffold` in a `DefaultTabController` and add the `bottom` property to the standard `AppBar`.

### Tabbed AppBar Blueprint
```dart
return DefaultTabController(
  length: 5, // Number of tabs
  child: Scaffold(
    backgroundColor: theme.pageBackground,
    appBar: AppBar(
      title: Row(
        children: [
          // 1. Icon Box
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.iconBoxBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.precision_manufacturing, // Page-specific icon
              color: theme.iconBoxIcon,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // 2. Title + Subtitle Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PAGE TITLE UPPERCASE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontSize: 18,
                  color: theme.appBarForeground,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'SUBTITLE UPPERCASE',
                style: TextStyle(
                  color: theme.appBarAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          // 3. Right Actions inside the Title Row
          _buildAppBarActions(context, ref, theme),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: theme.appBarBackground,
      foregroundColor: theme.appBarForeground,
      elevation: 0,
      
      // 4. Add the TabBar here
      bottom: TabBar(
        isScrollable: true,
        indicatorColor: theme.appBarAccent,
        labelColor: theme.appBarAccent,
        unselectedLabelColor: theme.textSecondary,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: 'TAB 1 UPPERCASE'),
          Tab(text: 'TAB 2 UPPERCASE'),
          // ... 
        ],
      ),
    ),
    body: Container(
      // Top border to separate tabs from body content
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: theme.cardBorderColor)),
      ),
      child: const TabBarView(
        children: [
          Tab1Widget(),
          Tab2Widget(),
          // ...
        ],
      ),
    ),
  ),
);
```

> [!NOTE]  
> Unlike the non-tab AppBar which uses the `actions: const [ ... ]` parameter, the Tabbed AppBar places the actions (like `StatusBar` or `ProfileWidget`) **inside the `title` Row**, pushed to the right using `Spacer()`. This ensures precise sizing and layout compatibility when interacting with the `bottom: TabBar()` element.

### TabBar Styling Rules
- **Scrollable**: `isScrollable: true` (prevents crowding on smaller screens)
- **Active State**: Both indicator and text use `theme.appBarAccent`
- **Inactive State**: Text uses `theme.textSecondary`
- **Typography**: Labels `UPPERCASE`, `labelStyle` has `fontWeight: FontWeight.bold`
- **Body Styling**: Wrap the `TabBarView` in a `Container` with a top border (`theme.cardBorderColor`) to create a defining line between the tabs and the content.

---

## Semantic Colors (Theme-Independent)
These colors remain the same in both Dark and Light mode because they carry semantic meaning:

| Context              | Color               | Usage                                       |
|----------------------|---------------------|---------------------------------------------|
| USB Active           | `Colors.greenAccent` | RS232 connected + streaming in AppBar       |
| USB Inactive         | `Colors.red`        | RS232 disconnected / stale in AppBar        |
| USB Active (Login)   | `Colors.green`      | RS232 status on the Login page              |
| USB Inactive (Login) | `Colors.red`        | RS232 status on the Login page              |
| Logout Warning       | `Colors.orange`     | Sign-out icon and button                    |
| Error text           | `Colors.red` / `Colors.redAccent` | Error messages                   |
| SnackBar success     | `Colors.green`      | Device connected notification               |
| System Mode SPOT     | `Colors.orange`     | SideMenu system status                      |
| System Mode CRUMBLING| `Colors.blue`       | SideMenu system status                      |
| System Mode MAINT    | `Colors.red`        | SideMenu system status                      |

---

## Typography Rules
- **Title Case**: All AppBar titles and section headers are UPPERCASE.
- **Title**: `fontSize: 18`, `fontWeight: bold`, `letterSpacing: 1.2`
- **Subtitle**: `fontSize: 10`, `fontWeight: w600`, `letterSpacing: 0.5`
- **Section Headers**: `fontSize: 10`, `fontWeight: bold`, `letterSpacing: 1.1`, UPPERCASE via `.toUpperCase()`
- **Form Labels**: `fontSize: 12`, `fontWeight: bold`, `letterSpacing: 0.5`
- **Body text**: `fontSize: 12-14`, normal weight
- **Clock digits**: `fontSize: 22`, `fontWeight: bold`, `letterSpacing: 2.0`

---

## SCADA Glow Effects
- In Dark mode (`hasGlowEffect: true`), widgets may apply `BoxShadow` with teal-tinted glow to active status indicators (e.g., USB dot, active cards).
- In Light mode (`hasGlowEffect: false`), these glow effects are disabled for a cleaner aesthetic.

> [!TIP]
> Always preserve the semantic meaning of colors (e.g., Green for Active, Red for Error, Orange for Warning) across both themes. These should NEVER change between Dark and Light mode.
