# Work Config Page Blueprint

**Path**: `lib/features/setup/pages/work_config_page.dart`  
**Pattern**: 3:1 Calibration Layout (Horizontal)

## 1. Grid Structure
- **Main Wrapper**: `Padding(padding: EdgeInsets.all(16.0))` wrapping a `Row`.
- **Layout Divide**: 
  - **Left Column**: `Expanded(flex: 3)`
  - **Right Column**: `Expanded(flex: 1)`

## 2. Left Column Details
- **Container**: `Column(crossAxisAlignment: CrossAxisAlignment.stretch)`
- **Top Image Region (Expanded flex: 3)**:
  - **Decoration**: `Color(0xFF1E293B)`, `BorderRadius.circular(16)`, `Border.all(color: Color(0xFF1E3A2A))`
  - **Content**: `Image.asset('images/exca_cal.png')` with `BoxFit.contain`.
- **Bottom Control Region (Expanded flex: 1)**:
  - **Decoration**: Same as Top Region.
  - **Content**: A `Row` (`mainAxisAlignment: MainAxisAlignment.spaceEvenly`) housing:
    - **Parameter Dropdown**: `DropdownButton<int>` mapped to `_indexNames`.
    - **Vertical Divider**: `Container(width: 1, height: double.infinity, color: Colors.white24)`.
    - **Value Dropdown**: `DropdownButton<int>` mapped to `_valueOptions[_selectedIndex]`.
    - **Vertical Divider**: Same as above.
    - **Action Button**: `ElevatedButton` (Style: `Color(0xFF2ECC71)`, Text: "SET").
      - **Logic**: Calls `ref.read(workConfigProvider.notifier).setWorkConfigParam(_selectedIndex, _selectedValue)`.
      - **Feedback**: Triggers `NotificationService.showCommandNotification`.

## 3. Right Column Details (Parameters List)
- **Decoration**: Same as Left Column.
- **Header**: Centered text "PARAMETERS" (`Color(0xFFFFFFFF)`, `FontWeight.bold`).
- **Divider**: `Divider(color: Color(0xFF1E3A2A))`.
- **Body**: `Expanded(child: ListView)` containing 5 Parameter Cards.

### Parameter Card Aesthetic (`_buildParamCard`)
```dart
Card(
  color: const Color(0xFF1E293B),
  margin: const EdgeInsets.symmetric(vertical: 6.0),
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Idx $index', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16)),
            Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
        Text(
          valueDisplay,
          style: const TextStyle(color: Color(0xFF2ECC71), fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ),
)
```

## 4. Data Mappings
### Parameter Index Names
| Index | Name |
| :--- | :--- |
| 0 | 0 - GNSS Altitude Ref |
| 1 | 1 - Altitude Reference |
| 2 | 2 - Bucket Length Ref |
| 3 | 3 - Bucket Horiz Ref |
| 4 | 4 - Pitch Compensation |

### Value Options
- **Index 0/1 (Ref)**: 0: MSL/GNSS, 1: Ellipsoid/OGL
- **Index 2 (Bucket Len)**: 0: Teeth, 1: Back
- **Index 3 (Bucket Horiz)**: 0: Center, 1: Left, 2: Right
- **Index 4 (Pitch)**: 0: No, 1: Yes

---
> [!IMPORTANT]
> The page relies on `workConfigProvider` for real-time state updates in the right-hand column list, ensuring the "SET" command's local fallback update is reflected immediately.
