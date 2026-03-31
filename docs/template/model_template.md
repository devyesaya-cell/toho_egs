# Model Template (Isar Collection)

Guide for defining data models that persist in the Isar database.

## 1. Class Structure
Use `@collection` for top-level entities and `@embedded` for nested objects.

```dart
import 'package:isar/isar.dart';

part 'my_model.g.dart';

@collection
class MyModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uid;

  late String name;
  
  // Always use seconds (int) for timestamps, not milliseconds
  late int createdAt;

  // Enums should be stored as Strings or Ints
  late String status; 
}
```

## 2. Best Practices
- **Package Selection**: Use `isar_community` and `isar_community_flutter_libs` (standard `isar` is deprecated/not compatible with current Flutter versions).
- **ID**: Always include a unique ID (auto-increment or specific int).
- **Indices**: Use `@Index` for fields frequently used in filters or queries (e.g., `uid`, `type`).
- **Timestamps**: Consistent use of `seconds since epoch` is critical for cross-compatibility with APIs and calculation logic.
- **Code Generation**: Run `dart run build_runner build` (or `flutter pub run build_runner build`) after creating or modifying models.

---
> [!WARNING]
> Do not store large binary data (images) directly in Isar. Store file paths instead.
