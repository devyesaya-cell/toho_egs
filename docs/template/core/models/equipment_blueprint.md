# EQUIPMENT MODEL BLUEPRINT
Path: `lib/core/models/equipment.dart`

## Overview
The `Equipment` model tracks physical assets (machines, vehicles) in the field. It includes specifications and health status for operational tracking.

## Database Schema
- **Collection**: `Equipment`
- **Primary Key**: `id` (Isar AutoIncrement)
- **Indexing**: `uid` is unique and replaced on conflict.

## Fields Reference

| Field         | Type            | Indexing          | Description / Mapping               |
|---------------|-----------------|-------------------|-------------------------------------|
| `id`          | `Id`            | Primary Key       | Isar auto-incrementing identifier   |
| `uid`         | `String?`       | Unique, Replace   | Mapped from server 'id'             |
| `username`    | `String?`       | -                 | Assigned operator or username       |
| `email`       | `String?`       | -                 | Contact email for management        |
| `part_numb`   | `String?`       | -                 | Asset tag or serial number          |
| `type`        | `String?`       | -                 | Category (e.g., Excavator, Truck)   |
| `brand`       | `String?`       | -                 | Manufacturer brand                  |
| `model`       | `String?`       | -                 | Model name / number                 |
| `year`        | `String?`       | -                 | Manufacture year                    |
| `state`       | `String?`       | -                 | Condition state (New, Used, etc.)   |
| `phone`       | `String?`       | -                 | Attached IoT/SIM phone number       |
| `category`    | `List<String>?` | -                 | Tags for classification             |
| `created_at`  | `String?`       | -                 | Timestamp of record creation        |
| `last_update` | `String?`       | -                 | Timestamp of last synchronization   |

---

## Technical Notes
- Field names like `part_numb`, `created_at`, and `last_update` follow snake_case to match the server-side API response structure.
- Synchronization logic uses the `uid` to ensure local updates merge correctly with server records.
