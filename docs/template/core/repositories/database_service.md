# Database Service Detail

Singleton manager for Isar database lifecycle.

## 1. Initialization
- **Path**: Uses `getApplicationDocumentsDirectory` for persistent storage.
- **Schema Management**: Registers all 10 schemas (WorkingSpot, Person, WorkFile, etc.) in a single `Isar.open` call.
- **Concurrency**: Prevents multiple open instances using `Isar.getInstance()`.

## 2. Integration
- Injected into the `AppRepository` via Riverpod.

---
> [!NOTE]
> Database initialization MUST be awaited during the app's `main()` function before the UI renders.
