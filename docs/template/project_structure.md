# Project Structure Template

This guide defines the standard directory structure and architectural patterns for new projects.

## 1. Directory Structure
The project follows a **Feature-Driven Architecture**.

```text
lib/
├── core/
│   ├── auth/           # Authentication logic and state
│   ├── coms/           # Serial/USB communication services
│   ├── database/       # Isar database initialization
│   ├── models/         # Global data models (Isar collections)
│   ├── protocol/       # Byte protocol parsers/encoders
│   ├── repositories/    # Data access layer (AppRepository)
│   ├── services/       # External service integrations (Notifications, etc.)
│   ├── state/          # Global application state (Auth, Settings)
│   ├── utils/          # Navigation, Theme, Constants
│   └── widgets/        # Reusable global UI components (StatusBar, ProfileWidget)
├── features/
│   ├── [feature_name]/
│   │   ├── widgets/    # Feature-specific sub-widgets
│   │   ├── presenter/  # Logic layer (Notifier/StateNotifier)
│   │   └── [feature_page].dart # Main UI Entry point (ConsumerWidget)
└── main.dart           # App entry point & initialization
```

## 2. Key Components
- **Core**: Contains static logic, global services, and common utilities that do not change based on the feature.
- **Features**: Each major piece of functionality resides in its own folder.
- **Presenter**: Acts as the ViewModel in MVVM. It manages the state and business logic for a specific feature.

---
> [!IMPORTANT]
> - Keep UI widgets "thin" (no business logic).
> - Delegate all actions (button clicks, data fetching) to the `Presenter`.
> - Use `core/widgets` for components shared across multiple features.
