# AREA MODEL BLUEPRINT
Path: `lib/core/models/area.dart`

## Overview
The `Area` model represents a geographical or logical work area within a project. it is stored locally using **Isar Database** and synchronized with the server.

## Database Schema
- **Collection**: `Area`
- **Primary Key**: `id` (Isar AutoIncrement)
- **Indexing**: `uid` is unique and replaced on conflict.

## Fields Reference

| Field            | Type      | Indexing          | Description / Mapping               |
|------------------|-----------|-------------------|-------------------------------------|
| `id`             | `Id`      | Primary Key       | Isar auto-incrementing identifier   |
| `uid`            | `String?` | Unique, Replace   | Remote UUID from server             |
| `projectID`      | `String?` | -                 | Associated Project Identifier        |
| `areaID`         | `String?` | -                 | Specific Area ID from server        |
| `areaName`       | `String?` | -                 | Display name of the area             |
| `contractorName` | `String?` | -                 | Name of the assigned contractor      |
| `companyID`      | `String?` | -                 | Associated Company Identifier        |
| `contractorID`   | `String?` | -                 | Associated Contractor Identifier     |
| `target`         | `double?` | -                 | Production or work target            |
| `targetUnit`     | `String?` | -                 | Unit for the target (e.g., m3, tons) |
| `createAt`       | `String?` | -                 | Timestamp of creation                |
| `endAt`          | `String?` | -                 | Timestamp of scheduled end           |
| `lastUpdate`     | `String?` | -                 | Timestamp of last synchronization    |

---

## Usage
Used primarily in the sync service to store area metadata for offline access and selection in the work mode setup.
