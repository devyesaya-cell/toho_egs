# Alert Debug Tab Blueprint

**Path**: `lib/features/setup/widgets/debug/alert_debug_tab.dart`  
**Type**: Widget (ConsumerWidget)

## 1. Overview
The `AlertDebugTab` provides a chronological log of system errors and alerts. It uses a tabular layout to display timestamps, error sources, alert types, and descriptive messages.

---

## 2. Architecture & State Management
- **Provider**: `errorProvider` (from `com_service.dart`).
- **Data Model**: `ErrorAlert`.
- **Logic**: Uses `DateFormat('yyyy-MM-dd HH:mm:ss')` for timestamps.
- **Empty State**: Displays a centered icon and "No active alerts" message when the list is empty.

---

## 3. Layout Specification

### Base Container
- **Padding**: `EdgeInsets.all(24.0)`
- **Decoration**:
  - `color`: `theme.cardSurface`
  - `borderRadius`: `16`
  - `border`: `theme.cardBorderColor`
  - `shadow`: `BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 4))`

### Table structure
- **Structure**: `Column` containing a header and a scrollable body (`ListView.separated`).

#### Header Row (`_buildTableHeader`)
- **Background**: `theme.appBarAccent.withOpacity(0.1)`
- **Padding**: `EdgeInsets.symmetric(horizontal: 24, vertical: 16)`
- **Flex Ratios**:
  - `DATE / TIME`: `flex: 3`
  - `SOURCE`: `flex: 2`
  - `TYPE`: `flex: 2`
  - `MESSAGE`: `flex: 5`
- **Typography**: `fontSize: 12`, `fontWeight: bold`, `letterSpacing: 1.1`, `theme.appBarAccent`.

#### Data Rows (`_buildTableRow`)
- **Padding**: `EdgeInsets.symmetric(horizontal: 24, vertical: 16)`
- **Separator**: `Divider(height: 1, color: theme.dividerColor)`
- **Typography**:
  - Timestamp: `theme.textSecondary`, `fontSize: 13`, `monospace`.
  - Type/Message: `theme.textOnSurface`, `fontSize: 14`.

---

## 4. Semantic Color Mapping (Source ID)

The "SOURCE" tag is dynamically color-coded based on the source identity. These are **Semantic Colors** independent of the dark/light theme toggle.

| Source ID | Color (Light/Dark) | Source Reference |
| :--- | :--- | :--- |
| `rover` | `0xFF3498DB` (Blue) | Rover unit alerts |
| `tablet pair` | `0xFF9B59B6` (Purple) | Connection/Paring issues |
| `boom` | `0xFFE67E22` (Orange) | Hydraulic/Boom sensors |
| `stick` | `0xFF1ABC9C` (Teal) | Stick sensors |
| `bucket` | `0xFFE74C3C` (Red) | Attachment alerts |
| default | `0xFFBDC3C7` (Grey) | Other system alerts |

---

## 5. Theme Token Mapping

| UI Element | Property | Token | Source Reference |
| :--- | :--- | :--- | :--- |
| Table Container | `color` | `theme.cardSurface` | `theme.cardSurface` |
| Table Border | `color` | `theme.cardBorderColor` | `theme.cardBorderColor` |
| Header Background | `color` | `theme.appBarAccent.withOpacity(0.1)` | `theme.appBarAccent` |
| Header Text | `color` | `theme.appBarAccent` | `theme.appBarAccent` |
| Row Separator | `color` | `theme.dividerColor` | `theme.dividerColor` |
| Timestamp Text | `color` | `theme.textSecondary` | `theme.textSecondary` |
| Alert Text | `color` | `theme.textOnSurface` | `theme.textOnSurface` |

---

## 6. Verification Checklist
- [ ] Watches `errorProvider`.
- [ ] Table structure matches the 3/2/2/5 flex ratio perfectly.
- [ ] Timestamp formatting is `yyyy-MM-dd HH:mm:ss`.
- [ ] Source tags use the specific hex values defined in the semantic map.
- [ ] Empty state icon (`Icons.check_circle_outline`) uses `theme.textSecondary.withOpacity(0.2)`.
- [ ] Row background is transparent; separator uses `theme.dividerColor`.
