# Landing: Gatekeeper Page
Path: `lib/features/landing/landing_page.dart`

The `LandingPage` acts as the primary gatekeeper for the application, handling the initial boot sequence and directing the user to the appropriate environment based on authentication state.

## Purpose
- **Session Restoration**: Restores any previously persisted user session.
- **Hardware Initialization**: Redundant connection to CP2102N (USB) gateway on startup.
- **Set Mode Command**: Sends the `setNormal` (OpCode 0x50, Payload 0x01) command to the MCU if a port is available.

## Routing Logic
The `LandingPage` is a `ConsumerStatefulWidget` that watches the `authProvider`. Its `build` method is a reactive switch:

### 1. Authenticated State
- **Condition**: `authState.currentUser != null`.
- **Destination**: Redirects to the `HomePage`.
- **Context**: Bypasses login if a valid session is detected from the local Isar database.

### 2. Unauthenticated State
- **Condition**: `authState.currentUser == null`.
- **Destination**: Redirects to the `LoginPage`.
- **Context**: Forces the user to provide an access code and select a `SystemMode`.

## Hardware Auto-Connect
Upon entry, the page triggers a `Future.microtask` loop:
- **Identifier**: Searches for "CP2102N".
- **Protocol Handshake**: If the port is successfully opened, it immediately informs the MCU to transition from "Config" or "Boot" state into "Normal" (streaming) operation via the **0x50/0x01** frame combination.
