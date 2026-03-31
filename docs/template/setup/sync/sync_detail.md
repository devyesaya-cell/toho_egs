# Data Synchronization Detail

This document covers the real-time data synchronization dashboard.

## 1. Page Layout
- **Grid**: Splits 4:6 horizontally.
- **Left Panel (flex: 4)**: 
  - Large `CircularProgressIndicator` showing total sync percentage.
  - Central text displaying `% SYNCED`.
  - Status text footer (e.g., "Scanning for new records...").
- **Right Panel (flex: 6)**:
  - Header: Item count and "LIVE STREAM" indicator (blinking/solid green).
  - Body: `ListView` of data packets being processed.

## 2. Core Widgets
### A. Packet Item
- **Roles**: Visualizes the status of individual files (Completed, Uploading, Waiting).
- **Indicators**:
  - `CircularProgressIndicator` or `LinearProgressIndicator` for active transfers.
  - `check_circle_outline` for completed tasks.

## 3. State Management (Presenter)
- **Presenter**: `SyncPresenter`.
- **Logic**: Manages the queue of data packets and maps them to the visual `PacketStatus` enum.

---
> [!TIP]
> Use distinct icons for different file types (e.g., `insert_drive_file` for logs, `location_on` for GPS paths).
