---
description: Standard UI and Architecture Rules for Toho EGS Flutter App
---

# Architecture Rules
1. **Presenter Pattern (MVVM)**: Every major feature or page must have its logic separated into a `Presenter` class (implementing Riverpod's `Notifier` or `StateNotifier`).
2. **Clean UI**: UI components (`Widget` classes) must remain as thin as possible. Avoid writing complex logic, boolean toggles, timers, or DB transactions directly in `StatefulWidget` states. Use `ConsumerWidget` and delegate all actions to the Presenter. 
3. **Stream Management**: Never use the classic Flutter `StreamBuilder` for fetching asynchronous list operations from Isar or APIs. Always wrap streams in a Riverpod `StreamProvider` and use the `.when(data: , loading: , error: )` syntax in the UI. This provides better caching and prevents UI flickering.

# UI / Layout Standards
4. **Scaffold & AppBar**: When creating a new page's Scaffold, the standard `AppBar` should consist of:
   - A `title` on the left.
   - The reusable `StatusBar` (containing the USB connection indicator and user `ProfileWidget`) placed in the `actions` array on the right.
5. **Theme**: Follow the dark green aesthetic (background: `#0F1410`, borders: `#1E3A2A`, accents: `#2ECC71`).

**Example implementation reference**: `lib/features/timesheet/timesheet_page.dart` and `lib/features/timesheet/presenter/timesheet_presenter.dart`.
