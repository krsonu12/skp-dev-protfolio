# Flutter Project Architecture & Dependency Rules

## Architecture: Clean Architecture with Feature-First Structure

This project follows **Clean Architecture** organized by **feature**, not by layer.
Every feature is self-contained with its own `data/`, `domain/`, and `presentation/` folders.

```
lib/
├── main.dart                        # Entry point only — init, DI root, runApp
├── feature/
│   ├── app.dart                     # Root MaterialApp.router widget
│   └── <feature_name>/
│       ├── data/
│       │   ├── datasources/         # Remote (Dio) + Local (Hive) implementations
│       │   ├── dtos/                # Freezed DTOs with JSON serialization
│       │   └── repositories_impl/  # Implements domain repository contracts
│       ├── domain/
│       │   ├── entities/            # Pure Dart classes — no Flutter, no packages
│       │   ├── repositories/        # Abstract contracts (interfaces only)
│       │   └── usecases/            # One class per use case, calls one repo method
│       └── presentation/
│           ├── <feature>_notifier/  # Riverpod Notifier — business logic
│           ├── <feature>_states/    # Freezed state classes
│           ├── shared_providers/    # Feature-level provider re-exports
│           ├── screens/             # One folder per screen
│           └── widgets/             # Reusable UI components
└── core/
    ├── constants/                   # App-wide constants (API keys, config)
    ├── di/                          # All Riverpod providers (DI wiring)
    ├── error/                       # AppFailure + error mappers
    ├── network/                     # Dio setup, base URLs
    ├── routes/                      # AutoRoute config + generated files
    ├── storage/                     # Hive box names, cache managers
    └── theme/                       # ThemeData, colors, extensions, notifiers
```

---

## Dependency Rule (Strict)

Dependencies only point **inward**. Outer layers know about inner layers, never the reverse.

```
presentation  →  domain  ←  data
      ↓              ↑
    core/di  ────────┘
```

- **Domain** imports nothing outside of `dart:core`. No Flutter, no Riverpod, no Hive.
- **Data** imports domain (to implement contracts) and core (for error types, storage).
- **Presentation** imports domain entities and use cases only — never data layer directly.
- **core/di** is the only place that wires data implementations to domain contracts.

---

## Layer Responsibilities

### Domain Layer

- `entities/` — plain Dart classes with business logic (computed properties, equality, `copyWith`)
- `repositories/` — abstract classes defining the contract. No implementation details.
- `usecases/` — single-responsibility classes. One public `call()` method. Delegates to repository.

````

### Data Layer
- `dtos/` — use `@freezed` + `@JsonSerializable`. Always provide `@Default` values to avoid null issues.
- Conversion between DTO and domain entity lives in **extensions on the DTO file**, not on the entity.
- `repositories_impl/` — thin orchestrators. Map DTOs to entities, handle fallback logic (e.g. cache on network failure).



### Presentation Layer
- Use `Notifier<State>` (not `StateNotifier`) for all state management.
- State classes use `@freezed` with `@Default` for every field.
- Notifiers read use cases via `ref.read(useCaseProvider)` — never instantiate data classes directly.
- Optimistic UI updates: update state first, call use case second, revert on failure.
- Screens are `ConsumerStatefulWidget` when they need `ScrollController`, `TextEditingController`, or lifecycle hooks. Otherwise use `ConsumerWidget`.

---

## Dependency Injection Pattern

All providers live in `core/di/providers.dart`. Follow this order:

```dart
// 1. Infrastructure
final dioProvider = Provider<Dio>(...);

// 2. Data Sources
final remoteDataSourceProvider = Provider<RemoteDataSource>(...);
final cacheDataSourceProvider  = Provider<CacheDataSource>(...);

// 3. Repository
final repositoryProvider = Provider<Repository>((ref) {
  return RepositoryImpl(
    remote: ref.watch(remoteDataSourceProvider),
    cache:  ref.watch(cacheDataSourceProvider),
  );
});

// 4. Use Cases
final fetchUseCaseProvider = Provider<FetchUseCase>((ref) {
  return FetchUseCase(ref.watch(repositoryProvider));
});

// 5. Notifiers (in shared_providers/ inside the feature)
final featureNotifierProvider = NotifierProvider<FeatureNotifier, FeatureState>(
  FeatureNotifier.new,
);
````

---

## Error Handling

- Define a single `AppFailure` class in `core/error/failures.dart`.
- Map infrastructure exceptions (e.g. `DioException`) to `AppFailure` in `core/error/error_mapper.dart`.
- Use cases and repositories throw `AppFailure` — never raw `DioException` or `HiveError`.
- Notifiers catch `AppFailure` and `Exception` separately and set `hasError + errorMessage` on state.

```dart
try {
  final result = await ref.read(useCaseProvider).call(...);
  state = state.copyWith(data: result, isLoading: false);
} on AppFailure catch (e) {
  state = state.copyWith(isLoading: false, hasError: true, errorMessage: e.message);
} catch (_) {
  state = state.copyWith(isLoading: false, hasError: true, errorMessage: 'Something went wrong.');
}
```

---

## State Design Rules

Every feature state must include these standard fields:

```dart
@freezed
abstract class FeatureState with _$FeatureState {
  const factory FeatureState({
    @Default([])    List<Item>  items,
    @Default(false) bool        isLoading,
    @Default(false) bool        isLoadingMore,
    @Default(false) bool        isRefreshing,
    @Default(false) bool        hasError,
    @Default('')    String      errorMessage,
  }) = _FeatureState;
}
```

For paginated features, add:

```dart
    @Default(1)     int         page,
    @Default(false) bool        hasMore,
    @Default(0)     int         totalResults,
    @Default(false) bool        isOffline,
```

---

## Routing

Use `auto_route`. Define all routes in `core/routes/app_router.dart`.

```dart
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/splash', initial: true),
    AutoRoute(page: HomeRoute.page,   path: '/home'),
    // ...
  ];
}
```

- Annotate every screen with `@RoutePage()`.
- Pass the `AppRouter` instance into `MyApp` — never create it inside the widget tree.
- Use `context.router.push()` for navigation, `context.router.replace()` for splash → home transitions.

---

## Local Storage (Hive)

- Define all box names as constants in `core/storage/hive_boxes.dart`.
- Open all boxes in `main()` before `runApp()` via `HiveBoxes.openAll()`.
- Use `Box<String>` and serialize to JSON manually — avoids Hive type adapter generation.
- For reactive data (e.g. bookmarks), use a `StreamController.broadcast()` in the datasource and emit on every write.

```dart
void _emit() {
  if (!_controller.isClosed) _controller.add(getAll());
}
```

---

## Image Caching

Use `flutter_cache_manager` with a singleton `CacheManager`:

```dart
class FeatureImageCacheManager extends CacheManager {
  static const key = 'feature_image_cache';
  static FeatureImageCacheManager? _instance;

  factory FeatureImageCacheManager() => _instance ??= FeatureImageCacheManager._();

  FeatureImageCacheManager._() : super(Config(
    key,
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 200,
    repo: JsonCacheInfoRepository(databaseName: key),
    fileService: HttpFileService(),
  ));
}
```

Pass the instance to every `CachedNetworkImage` via `cacheManager:`.

---

## Theme System

- Define all colors as `static const` in `core/theme/app_colors.dart`.
- Create light and dark `ThemeData` in `core/theme/app_theme.dart` as static methods that accept a `fontSize` parameter.
- Use `ThemeExtension` (`BrandTheme`) for design tokens (card radius, elevation, brand colors) that need to be accessible anywhere via `Theme.of(context).extension<BrandTheme>()`.
- Persist theme mode and font size in `SharedPreferences` via `AsyncNotifier`.

---

## Networking

- Single `Dio` instance provided via `dioProvider` with explicit timeouts (connect/receive/send: 15s).
- Base URLs in `core/network/app_urls.dart` as `static const String`.
- API keys loaded from `.env` via `flutter_dotenv` — never hardcoded.
- Always map `DioException` to `AppFailure` before it leaves the data layer.

---

## Code Generation

Run after any model/route change:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Files that require generation:

- `*.freezed.dart` — from `@freezed` classes
- `*.g.dart` — from `@JsonSerializable` / `@freezed` with JSON
- `app_router.gr.dart` — from `@AutoRouterConfig`

Never edit generated files manually.

---

## Dependencies Reference

```yaml
dependencies:
  # State management & DI
  flutter_riverpod: ^3.0.3 # Notifier + Provider pattern

  # Navigation
  auto_route: ^11.1.0 # Declarative routing with code generation

  # Networking
  dio: ^5.9.2 # HTTP client with interceptors and timeouts

  # Local storage
  hive: ^2.2.3 # Key-value NoSQL (Box<String> + JSON)
  hive_flutter: ^1.1.0 # Flutter init helpers

  # Image caching
  cached_network_image: ^3.4.1 # Network image with cache support
  flutter_cache_manager: ^3.4.1 # Custom cache config (TTL, max objects)

  # Code generation (models)
  freezed_annotation: ^3.0.0 # @freezed annotation
  json_annotation: ^4.9.0 # @JsonSerializable annotation

  # UI
  shimmer: ^3.0.0 # Loading skeleton effect
  google_fonts: ^8.1.0 # Custom fonts

  # Utilities
  flutter_dotenv: ^6.0.1 # .env file loading
  shared_preferences: ^2.2.1 # Lightweight key-value (theme, settings)
  share_plus: ^13.1.0 # Native share sheet

dev_dependencies:
  # Code generation
  build_runner: any
  auto_route_generator: ^10.0.1 # Generates app_router.gr.dart
  json_serializable: ^6.9.4 # Generates *.g.dart
  freezed: ^3.0.6 # Generates *.freezed.dart

  # Testing
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.4 # Mock/stub without code generation
  flutter_lints: ^6.0.0 # Lint rules
```

---
