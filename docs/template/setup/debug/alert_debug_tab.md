# Alert Debug Tab Detail

The Alert tab provides a searchable/filterable historical log of system issues consumed from the application's global error buffer.

## Data Model
- **Provider**: `errorProvider` (Riverpod)
- **Model**: `ErrorAlert`
- **Fields**: `timestamp` (DateTime), `sourceID` (String), `alertType` (String), `message` (String).

## Table Columns
| Column | Detail | Format |
| :--- | :--- | :--- |
| **DATE / TIME** | Event occurrence | `yyyy-MM-dd HH:mm:ss` (Monospace) |
| **SOURCE** | Component that threw the alert | Tagged & Color-coded |
| **TYPE** | Category of alert | Semi-bold text |
| **MESSAGE** | Detailed description | Multi-line text support |

## Source Color Mapping
- **ROVER**: Blue (`0xFF3498DB`)
- **TABLET PAIR**: Purple (`0xFF9B59B6`)
- **BOOM**: Orange (`0xFFE67E22`)
- **STICK**: Teal (`0xFF1ABC9C`)
- **BUCKET**: Red (`0xFFE74C3C`)
- **DEFAULT**: Grey (`0xFFBDC3C7`)
