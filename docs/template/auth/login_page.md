# Auth: Login Page
Path: `lib/features/auth/login_page.dart`

The entry point for operators to authenticate and initialize the Excavator Guidance System.

## UI Structure
The page uses a split-screen design over a cinematic background (`images/login_bg.jpeg`):
1.  **Left Panel (Branding)**: Displays the **Toho EGS** logo badge and operational readiness status. 
2.  **Right Panel (Login Form)**: A floating card containing the interactive authentication elements.

## Core Components
### 1. Operator Selection
- **Source**: Fetches all `Person` records from the local Isar database.
- **Component**: `DropdownButton<Person>` displaying `firstName` and `lastName`.
- **Initialization**: Automatically seeds a default user if the database is empty upon first run.

### 2. Access Code (Password)
- **Component**: `TextField` with `obscureText` toggle.
- **Validation**: Passwords must exactly match the `selectedPerson.password` stored in the Isar collection.
- **Error Feedback**: Utilizes `NotificationService.showError()` for failed attempts (Empty password, user not selected, or incorrect code).

### 3. System Mode Selection
The operator selects their working context before initialization. Each mode shifts the guidance logic:
- **SPOT**: Targeted point-based excavation.
- **CRUMBLING**: Continuous line/segment-based excavation.
- **MAINT**: Technical maintenance and sensor calibration access.

### 4. USB / RS232 Status
A real-time indicator (`_buildUsbStatus`) at the bottom of the form shows the connectivity to the hardware gateway.
- **Active (Green)**: USB connected AND recent data received (< 2s).
- **Inactive (Red)**: Disconnected or stale data stream.

## Authentication Flow
1.  Operator selects their profile from the dropdown.
2.  Operator enters their unique access code.
3.  Operator selects the intended `SystemMode`.
4.  **Initialize System**: Calls `authProvider.notifier.login(person, mode)` which persists the session and triggers the transition to the **LandingPage**.
