# App Repository Detail

The primary Data Access Object (DAO) for the application's Isar database.

## 1. Database Coverage
Manages CRUD operations for the following collections:
- `Person`: User accounts and roles.
- `WorkFile`: Job site metadata.
- `Equipment`: Machine/Excavator profiles.
- `Area` / `Contractor`: Logistical prerequisites.
- `WorkingSpot`: Real-time telemetry and work point completion.
- `TimesheetRecord` / `TimesheetData`: Operational logging.
- `StatusTimesheet`: Global pause/resume state.

## 2. Advanced Logic
- **Cascade Delete**: Deleting a `WorkFile` automatically removes all associated `WorkingSpot` records using Isar filters.
- **Shift Filtering**: Includes logic to fetch working spots based on 12-hour shifts (07:00-19:00 and 19:00-07:00).
- **Data Watchers**: Provides `Stream` methods for every collection to drive real-time UI updates via Riverpod `StreamProvider`.

## 3. Transaction Safety
- All write operations (put/delete) MUST be wrapped in `isar.writeTxn`.

---
> [!IMPORTANT]
> The repository ensures that all `WorkingSpot` timestamps are correctly stored in **seconds** for consistency.
