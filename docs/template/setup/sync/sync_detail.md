# Data Synchronization Blueprint

**Path**: `lib/features/setup/pages/sync_page.dart`  
**Type**: Page (ConsumerStatefulWidget)

## 1. Overview
The `SyncPage` provides a real-time dashboard for transmitting locally captured work records (Spots) to the Host network via WebSocket. It features a high-impact progress visualization on the left and a dynamic stream of data packets on the right.

---

## 2. Architecture & State Management
- **Provider**: Watches `syncPresenterProvider` (Notifier).
- **Initialization**: Automatically triggers `startSync()` on page entry.
- **Data Source**: Replaces hardcoded placeholders with `List<WorkingSpot>` fetched from the persistent database.

---

## 3. Layout Specification

### Base Container
- **Padding**: `EdgeInsets.all(24.0)`
- **Structure**: `Row` splitting the screen 4:6 (`Expanded(flex: 4 / 6)`).

### Left Panel: Sync Status (Flex: 4)
- **Container**: `theme.cardSurface`, `borderRadius: 24`, border `theme.cardBorderColor`.
- **Top Region**: 160x160 `Stack` housing a `CircularProgressIndicator`.
  - `strokeWidth: 12`, `valueColor: theme.appBarAccent`.
  - Center text: `[progress]% SYNCED` (`theme.textOnSurface`, `fontSize: 36`).
- **Bottom Region**:
  - `statusText` (`theme.textOnSurface`, `fontSize: 18`, `bold`).
  - Warning footer: "Automatic transmission active..." (`theme.textSecondary`, `fontSize: 13`).

### Right Panel: Data Stream (Flex: 6)
- **Header**: 
  - Title: "DATA PACKETS ([spots.length])" (`theme.textSecondary`).
  - Live Indicator: "LIVE STREAM" with a blinking-capable dot (Green `0xFF2ECC71` when active, `theme.textSecondary` when idle).
- **Body**: `ListView` (dynamic) iterating over `state.spots`.

---

## 4. UI Data Model (WorkingSpot Mapping)

The right panel items are generated dynamically from the `WorkingSpot` model using the following design mapping:

| UI Field | Mapping Logic / Source |
| :--- | :--- |
| **Title** | `Spot #[spotID] - [mode]` |
| **Subtitle** | `File: [fileID] • Acc: [akurasi.toStringAsFixed(2)]m` |
| **Icon** | `Icons.construction` (DIGGING), `Icons.minor_crash` (TRAVEL), or `Icons.location_on_outlined` (default) |
| **Trailing Text** | Time formatted as `HH:mm` from `lastUpdate` |
| **Status Logic** | **Completed**: `payloadSent` \| **Uploading**: `sendingPayload` (static 0.7 progress) \| **Waiting**: otherwise |

---

## 5. Theme Token Mapping

| UI Element | Property | Token |
| :--- | :--- | :--- |
| Scaffold | `backgroundColor` | `theme.pageBackground` |
| Progress Ring | `valueColor` | `theme.appBarAccent` |
| Sync Percentage | `color` | `theme.textOnSurface` |
| Packet Title | `color` | `theme.textOnSurface` |
| Packet Subtitle | `color` | `theme.textSecondary` |
| Packet Background | `color` | `theme.cardSurface` |
| Active Border | `color` | `theme.appBarAccent` (with opacity) |

---

## 6. Verification Checklist
- [ Yes ] 4:6 horizontal split is maintained using `Expanded`.
- [ Yes ] `DATA PACKETS` count accurately reflects `state.spots.length`.
- [ Yes ] Live Stream indicator turns green only when connected (`!idle && !error`).
- [ Yes ] WorkingSpot `mode` logic correctly switches Icons (Construction vs Crash vs Location).
- [ Yes ] Progress value is clamped between 0.0 and 1.0.
