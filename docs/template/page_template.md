# Page & Widget Template

Standard layout and component guide for creating new UI elements.

## 1. Main Page Scaffold
Every feature page should follow this structure.

```dart
class MyFeaturePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: theme.pageBackground,
      appBar: AppBar(
        title: Text('FEATURE NAME'),
        actions: [
          StatusBar(), // Custom USB/Status indicator
          ProfileWidget(), // User profile & Logout
        ],
      ),
      body: MyBodyWidget(),
    );
  }
}
```

## 2. Calibration Layout (Predefined Grid)
If a page requires a "Calibration Layout", use the 3:1 split:
- **Left Column (flex: 3)**:
  - Top (flex: 3): Visual reference (Image/3D).
  - Bottom (flex: 1): Control buttons row.
- **Right Column (flex: 1)**:
  - Header: "PARAMETERS"
  - Body: Scrollable list of `ParameterCard` widgets.

## 3. Parameter Card Widget
Use this standard card for input parameters:
```dart
Card(
  color: theme.surfaceColor,
  child: InkWell(
    onTap: () => _showInputDialog(context),
    child: Row(
      children: [
        Column(children: [Text(abbr), Text(title)]),
        Text(value, style: TextStyle(color: theme.activeColor)),
      ],
    ),
  ),
)
```

---
> [!NOTE]
> Angle or Tilt values must be capped at **360.00°** in the UI display.
