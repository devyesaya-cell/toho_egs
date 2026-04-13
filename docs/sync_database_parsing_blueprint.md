# SYNC DATABASE PARSING BLUEPRINT
Path: `lib/ui/sync/sync_page.dart`

This blueprint details the JSON structure used for synchronizing metadata between the **Basestation (Host)** and the **Rover (Client)** via WebSocket.

## Protocol Detail
- **Command**: String `'sync_database'`
- **Transmission**: WebSocket (Text Frame)
- **Response Format**: JSON String

---

## JSON Root Structure

| Key       | Type     | Description                                      |
|-----------|----------|--------------------------------------------------|
| `status`  | `String` | Status of the request (e.g., `"success"`)        |
| `command` | `String` | Echo of the requested command (`"sync_database"`)|
| `data`    | `Object` | Container for the database collections           |

### Data Container Object (`data`)
The `data` object contains four indexed lists representing the local collections.

| Key          | Type    | Description                                      |
|--------------|---------|--------------------------------------------------|
| `Area`       | `List`  | List of Area objects                             |
| `Contractor` | `List`  | List of Contractor objects                       |
| `Person`     | `List`  | List of Person objects                           |
| `Equipment`  | `List`  | List of Equipment objects (Filtered: Excavators) |

---

## Model Schemas

### Area Object
| Field            | Type     | Description                          |
|------------------|----------|--------------------------------------|
| `uid`            | `String` | Unique Identifier (Server UUID)      |
| `projectID`      | `String` | Parent Project ID                    |
| `areaID`         | `String` | Specific Area ID                     |
| `areaName`       | `String` | Display Name                         |
| `contractorName` | `String` | Assigned Contractor Name             |
| `companyID`      | `String` | Assigned Company ID                  |
| `contractorID`   | `String` | Assigned Contractor ID               |
| `target`         | `double` | Production Target                    |
| `targetUnit`     | `String` | Target Unit (e.g., "m3")             |
| `createAt`       | `String` | Creation Timestamp                   |
| `endAt`          | `String` | Expiry/End Timestamp                 |
| `lastUpdate`     | `String` | Last Sync Timestamp                  |

### Contractor Object
| Field        | Type     | Description                          |
|--------------|----------|--------------------------------------|
| `uid`        | `String` | Unique Identifier                    |
| `name`       | `String` | Contractor Name                      |
| `title`      | `String` | Legal/Official Title                 |
| `address`    | `String` | Office Address                       |
| `phone`      | `String` | Contact Phone                        |
| `email`      | `String` | Contact Email                        |
| `location`   | `String` | Operating Location                   |
| `status`     | `String` | Active/Inactive Status               |
| `category`   | `List`   | Strings representing categories      |
| `createdAt`  | `String` | Record Creation Timestamp            |
| `lastUpdate` | `String` | Last Sync Timestamp                  |

### Person Object
| Field        | Type     | Description                          |
|--------------|----------|--------------------------------------|
| `uid`        | `String` | Unique Identifier                    |
| `username`   | `String` | Login Username                       |
| `email`      | `String` | Email Address                        |
| `fullname`   | `String` | User Full Name                       |
| `role`       | `String` | System Role (e.g., "Driver")         |
| `status`     | `String` | Account Status                       |
| `groupId`    | `List`   | Strings representing team IDs        |
| `created`    | `String` | Record Creation Timestamp            |
| `lastUpdate` | `String` | Last Sync Timestamp                  |

### Equipment Object
| Field         | Type     | Description                          |
|---------------|----------|--------------------------------------|
| `uid`         | `String` | Unique Identifier                    |
| `username`    | `String` | Assigned Operator                    |
| `email`       | `String` | Management Email                     |
| `part_numb`   | `String` | Serial/Part Number                   |
| `type`        | `String` | Equipment Type (e.g., "Excavator")   |
| `brand`       | `String` | Brand/Manufacturer                   |
| `model`       | `String` | Model Name                           |
| `year`        | `String` | Manufacturing Year                   |
| `state`       | `String` | Condition State                      |
| `phone`       | `String` | Attached IoT Phone Number            |
| `category`    | `List`   | Strings for classification           |
| `created_at`  | `String` | Creation Timestamp                   |
| `last_update` | `String` | Last Sync Timestamp                  |

---

## Implementation Example (JSON)

```json
{
  "status": "success",
  "command": "sync_database",
  "data": {
    "Area": [
      {
        "uid": "area-123",
        "areaName": "Sector Alpha",
        "target": 500.0,
        "targetUnit": "m3"
      }
    ],
    "Equipment": [
      {
        "uid": "exca-001",
        "type": "excavator",
        "brand": "Komatsu",
        "model": "PC200"
      }
    ]
  }
}
```

> [!TIP]
> Client applications should use the `uid` field as the primary key to check for existing records before performing a local DB insert to avoid duplication.
