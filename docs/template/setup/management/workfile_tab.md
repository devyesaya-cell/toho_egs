# Workfile Tab Detail

The Workfile tab manages the active job files (surfaces, geometries) associated with current projects.

## UI Features
- **Grid View**: Displays `WorkfileCardWidget`.
- **Responsive Layout**: Adjusts from 2 to 5 columns.

## Data Mapping (WorkFile Model)
- **ID**: `uid.toString()` is used as the file identifier.

## Business Logic
- **Permissions**: Admin and Supervisor roles are permitted to delete.
- **Cascading Delete**: Deleting a workfile will also prompt/execute the deletion of all associated `WorkingSpot` records in the database.
