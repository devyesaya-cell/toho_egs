# State Management Template (Riverpod + Presenter)

New projects must use the **Presenter Pattern** (MVVM) powered by **Riverpod**.

## 1. Implementation Pattern
Every feature consists of a `State` class and a `Notifier` (Presenter).

### Feature State
Define a dedicated class for the feature's state. Always use `copyWith` for immutable updates.
```dart
class FeatureState {
  final bool isLoading;
  final List<Data> items;
  // ...
  const FeatureState({this.isLoading = false, this.items = const []});
  
  FeatureState copyWith({bool? isLoading, List<Data>? items}) {
    return FeatureState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
    );
  }
}
```

### Feature Notifier (Presenter)
Manage logic and side effects here.
```dart
class FeatureNotifier extends Notifier<FeatureState> {
  @override
  FeatureState build() {
    // Initialization logic (e.g., fetch data)
    return const FeatureState();
  }

  void updateData() {
    // Logic here
    state = state.copyWith(items: [...]);
  }
}

// Global Provider
final featureProvider = NotifierProvider<FeatureNotifier, FeatureState>(() => FeatureNotifier());
```

## 2. Core Rules
1. **Async Data**: Use `StreamProvider` for real-time data from Isar or APIs.
2. **Side Effects**: Use `ref.listen` or `ref.watch` carefully. For mutations within lifecycle hooks, use `Future.microtask`.
3. **Thin UI**: UI widgets MUST be `ConsumerWidget` and only call methods from the Presenter.

---
> [!IMPORTANT]
> Never use `SetState` in `StatefulWidget` for global logic. Use Riverpod for all state transitions.
