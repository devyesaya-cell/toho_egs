---
description: Layout grid and styling patterns for Calibration Tabs
---
# Calibration Layout Rule

When the user asks to use the **"calibration layout"**, apply the following predefined structural grid and styling for the current tab/page:

## 1. Grid Structure
- Use a single `Padding(padding: EdgeInsets.all(16.0))` wrapping a `Row`.
- **Main Layout Divide**: Split the screen `3:1` horizontally using `Expanded(flex: ...)`
  - **Left Column**: `Expanded(flex: 3)`
  - **Right Column**: `Expanded(flex: 1)`

## 2. Left Column Details
- Container: Replace standard `Column` with `Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [...])` to ensure full width block occupation.
- **Top Image Region**: `Expanded(flex: 3)`
  - Decoration: `Color(0xFF1E293B)`, `BorderRadius.circular(16)`, `Border.all(color: Color(0xFF1E3A2A))`
  - Purpose: Hosts an informational/reference graphic or 3D view (typically `images/calibrate_...png`) with `BoxFit.contain`.
- Spacer: `SizedBox(height: 16)`
- **Bottom Control Region**: `Expanded(flex: 1)`
  - Decoration: Same as Top
  - Content: A `Row` (`mainAxisAlignment: MainAxisAlignment.spaceEvenly`) housing core action groups (e.g., Pitch/Roll forms or Start/Stop Accelero signals).
  - Divider: Separate distinct control groups with `Container(width: 1, height: double.infinity, color: Colors.white24)`.

## 3. Right Column Details (Parameters List)
- Decoration: Same as Left Column elements.
- Structure:
  - Header: Centered text "PARAMETERS" (`Color(0xFFFFFFFF)`, `FontWeight.bold`, `letterSpacing: 1.2`, `fontSize: 16`).
  - Divider: `Divider(color: Color(0xFF1E3A2A))`.
  - Body: `Expanded(child: ListView(children: [...]))` containing Parameter Cards.

## 4. Parameter Cards Details
When generating the Input Parameter form values for the right-hand stack, use this exact Card aesthetic:
```dart
Card(
  color: const Color(0xFF1E293B),
  margin: const EdgeInsets.symmetric(vertical: 6.0),
  child: InkWell(
    onTap: () { /* Show parameter input ShowDialog() */ },
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(abbreviation, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16)),
              Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
          Text(
            value.toString(),
            style: const TextStyle(color: Color(0xFF2ECC71), fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  ),
)
```

## 5. Parameter Input Form Modal (`_showSetParamDialog`)
If tapping a Card opens an edit prompt:
- Component: `AlertDialog` with `backgroundColor: const Color(0xFF1E293B)`
- Input Field: `TextField` populated with initial current value.
  - `fillColor: const Color(0xFF0F1410)`
  - Text style is white, hint is `white54`.
  - Disable default underlined border: `border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)`
- Buttons:
  - Cancel: `TextButton` with `Colors.white54`
  - Set: `ElevatedButton` mapped to `Color(0xFF2ECC71)` with `Colors.white` text.
