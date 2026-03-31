# Person Tab Detail

The Person tab manages the operators permitted to use the system.

## UI Features
- **Filters**: Horizontal capsule buttons for `ALL UNITS`, `SPOT`, and `CRUMBLING`.
- **Primary Action**: `REGISTER OPERATOR` button (Top Right).

## Data Mapping (Person Model)
- **Grid View**: Displays `PersonCardWidget`.
- **Dialog**: `PersonEditDialog` for adding/editing.

## Business Logic
- **Admin Only**: Only users with the `admin` role can see the **Delete** button.
- **Self-Protection**: Admins cannot delete their own profile.
- **Filtering**: Filters locally by the `preset` field (converted to uppercase).
