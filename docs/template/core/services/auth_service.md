# Auth Service Detail

Minimalist service for handling user authentication and session persistency.

## 1. Functional Scope
- **Login**: Validates credentials against the `Person` collection in Isar.
- **Logout**: Clears the active `currentUser` in `AuthState` and updates the database record `loginState` to `OFF`.

## 2. Integration
- Primarily used by the `AuthNotifier` (Riverpod) to bridge the UI login form with the `AppRepository`.

---
> [!NOTE]
> Currently relies on a hardcoded "admin / asd123" account seeded during the first application launch.
