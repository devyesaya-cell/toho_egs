# CONTRACTOR MODEL BLUEPRINT
Path: `lib/core/models/contractor.dart`

## Overview
The `Contractor` model stores information about external companies or entities performing work. It is stored locally using **Isar Database** for offline availability.

## Database Schema
- **Collection**: `Contractor`
- **Primary Key**: `id` (Isar AutoIncrement)
- **Indexing**: `uid` is unique and replaced on conflict.

## Fields Reference

| Field           | Type            | Indexing          | Description / Mapping               |
|-----------------|-----------------|-------------------|-------------------------------------|
| `id`            | `Id`            | Primary Key       | Isar auto-incrementing identifier   |
| `uid`           | `String?`       | Unique, Replace   | Mapped from server 'id'             |
| `name`          | `String?`       | -                 | Trading name of the contractor      |
| `title`         | `String?`       | -                 | Official title or legal name        |
| `address`       | `String?`       | -                 | Physical office address             |
| `phone`         | `String?`       | -                 | Contact phone number                |
| `email`         | `String?`       | -                 | Contact email address               |
| `location`      | `String?`       | -                 | Primary operating location          |
| `status`        | `String?`       | -                 | Operational status (Active/Inactive)|
| `category`      | `List<String>?` | -                 | Categories or tags for filtering    |
| `createdAt`     | `String?`       | -                 | Timestamp of record creation        |
| `lastUpdate`    | `String?`       | -                 | Timestamp of last synchronization   |

---

## Technical Notes
- The `uid` field MUST be used as the primary identifier when communicating with the server to ensure consistency.
- Categories are stored as a list of strings within the Isar collection.
