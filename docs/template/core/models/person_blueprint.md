# PERSON MODEL BLUEPRINT
Path: `lib/core/models/person.dart`

## Overview
The `Person` model represents users, operators, or personnel registered in the system. It defines their roles, contact information, and group memberships.

## Database Schema
- **Collection**: `Person`
- **Primary Key**: `id` (Isar AutoIncrement)
- **Indexing**: `uid` is unique and replaced on conflict.

## Fields Reference

| Field         | Type            | Indexing          | Description / Mapping               |
|---------------|-----------------|-------------------|-------------------------------------|
| `id`          | `Id`            | Primary Key       | Isar auto-incrementing identifier   |
| `uid`         | `String?`       | Unique, Replace   | Mapped from server 'id'             |
| `username`    | `String?`       | -                 | Login username or handle            |
| `email`       | `String?`       | -                 | Personal or work email address      |
| `fullname`    | `String?`       | -                 | Display name                        |
| `role`        | `String?`       | -                 | Assigned role (e.g., Driver, Admin) |
| `status`      | `String?`       | -                 | Account status (Active/Suspended)   |
| `groupId`     | `List<String>?` | -                 | List of group/team identifiers      |
| `created`     | `String?`       | -                 | Timestamp of record creation        |
| `lastUpdate`  | `String?`       | -                 | Timestamp of last synchronization   |

---

## Technical Notes
- The `role` field determines access levels within certain app modules (e.g., restricted access to Calibration for Drivers).
- Use `groupId` to filter data availability or to assign people to specific shifts or areas.
