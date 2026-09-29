# Agent Instructions: Flutter App

Architecture rules for this Flutter project. All agents MUST follow them.

> Read large files (>200 lines) with `offset`/`limit`; widen only if the symbol isn't in range.

**This is an offline-only app.** All data lives in a local SQLite database (Drift). There is no server, no API and no network code: no HTTP client, no `INTERNET` permission in the release manifest, and no package that fetches or sends anything at runtime.

## 1. Architecture: feature-first, sliced

Group by feature, never by layer.

```text
lib/
  core/                  app-wide shared code (database, error, router, theme, utils, widgets, constants, l10n)
  features/
    <module>/
      <module>_routes.dart     <module>_domain.dart  <module>_data.dart  <module>_presentation.dart
      <slice>/  {data,domain,presentation}/
      shared/   {data,domain,presentation}/    only what ≥2 slices use
```

A **slice** is one unit of work, usually one entity plus its screens. A module with a single slice puts the layers directly under the module.

**Layers in a slice:**
- `domain/`: `entities/` (pure Dart), `repositories/` (abstract), `usecases/` (one class per business action)
- `data/`: `models/` (DTOs, `fromJson`/`toJson` for the backup file), `datasources/` (local: Drift queries against `AppDatabase`), `repositories/` (implements domain interface, maps Models/Drift rows → Entities), `<slice>_providers.dart` (wiring, §2)
- `presentation/`: `pages/`, `widgets/`, `providers/` (Notifiers)

**Build inside-out:** Entity → Repository interface → UseCase → Model → DataSource → RepositoryImpl → wiring providers → Notifier → Pages/Widgets.

### 1.1 Dependency rules
- `domain/` imports no Flutter, no Riverpod, no Drift, no `data/`, no `presentation/`. It may import `fpdart`, `freezed_annotation`, `meta` and pure-Dart `core/` code (`core/error`, `core/utils`).
- `data/` imports no `presentation/`. Drift row classes never leave `data/`.
- `presentation/` imports `domain/` and only the slice's `data/<slice>_providers.dart` from `data/`. Never models, datasources or repository impls.
- `core/` imports no feature, except the router composing each `<module>_routes.dart`.
- The database is shared infrastructure: all Drift tables, indexes, migrations and seed data live in `core/database/`. Features query it through their own datasources.
- Slices within a module may import each other; the graph stays **acyclic**, and nothing imports back into `shared/`.
- **Crossing modules** goes only through the other module's root public API files (`<m>_domain.dart`, `<m>_data.dart`, `<m>_presentation.dart`), which contain only `export … show …` lines. Import the file matching your own layer. Never reach into `<m>/<slice>/…`.
- All imports are package imports (`package:<app>/…`), never relative (`always_use_package_imports`).

### 1.2 Typed domain contracts
- No `Map<String, dynamic>` crosses the domain boundary.
- Paginated lists return a shared `PagedResult<T>` from `core/`.
- Writes take a `{Name}Input` entity; its JSON lives in a `data/models/` extension. The JSON is the backup-file contract, so null-vs-omitted fields matter: decide in `toJson` and pin in a test.
- Money is an `int` in rupiah (no minor unit). No `double` for amounts, anywhere.

### 1.3 One source of truth
Before adding a widget, helper, constant or mapping, search `core/` and the module's `shared/`. A second copy is a bug.

### 1.4 Moving code
Move with `git mv`, never copy-then-delete. A move changes only paths and imports. Keep moves and behaviour changes in separate commits.

## 2. State management & DI: Riverpod

- Use `flutter_riverpod` + `riverpod_generator` (`@riverpod` annotations). Run `dart run build_runner build -d` after changes.
- **Riverpod is the DI container.** No `get_it`, no service locators, no manual instantiation in widgets.
- **Wiring** lives in `data/<slice>_providers.dart`: datasource → repository (typed as the domain interface) → use case providers. The shared `AppDatabase` is a `keepAlive` provider in `core/database/`; tests override it with an in-memory database.
- **State** lives in `presentation/providers/`:
  - `Notifier` / `AsyncNotifier` only. No `StateNotifier`, `ChangeNotifier` or `StateProvider`.
  - Notifiers call use cases, never repositories or datasources.
  - Async state is `AsyncValue<T>`; handle it with `switch`/`.when` covering loading, error and data.
- **In widgets**: `ref.watch` in `build`, `ref.read` in callbacks, `ref.listen` for side effects (toasts, navigation). Use `select` to limit rebuilds.
- Prefer auto-dispose (the generator default). Use `keepAlive: true` only for deliberately app-lifetime state.
- Pass parameters via family arguments, not mutable fields.

## 3. Coding standards
- **Immutability**: `freezed` (or `equatable`) for entities, models and state classes.
- **Errors**: repositories and use cases return `Either<Failure, T>` (`fpdart`). Never throw into presentation.
- **Error mapping**: repository impls run every DB/file operation through `core/error/guard.dart`, which maps SQLite/Drift, file-system and format exceptions to typed `Failure`s in one place. App-wide failures (database can't open or migrate) get a full-screen error page with retry; contextual failures show inline or as a toast.
- **Writes** run inside a DB transaction. No partial saves.
- **Schema changes** bump the Drift schema version, add a migration and a migration test (`drift_dev` snapshots in `drift_schemas/`).
- **Naming**: `snake_case` files, `PascalCase` classes, layer suffixes (`UserModel`, `AuthRepositoryImpl`, `LoginPage`, `CartNotifier`).
- **Linting**: `flutter_lints` (or stricter), keep `flutter analyze` clean.
- **Localization**: no hardcoded user-facing strings. Use `gen-l10n` (English only, `app_en.arb`), add every key to every `.arb` in the same change, ICU placeholders instead of concatenation.

## 4. Routing
- Each module exposes its routes from `<module>_routes.dart`; the app router lists each module once.
- Navigate by route path, never by positional index.

## 5. Testing
- `test/` mirrors `lib/` down to the slice. Only `architecture_test.dart` sits at the `test/` root.
- **Permanent tests**:
  - `architecture_test.dart`: file scan enforcing §1 (placement, slice graph, public API files, layer rules, package imports, test mirror). If it disagrees with this file, one is outdated. Stop and resolve.
  - Payload tests: every `{Name}Input.toJson` and backup DTO.
  - Parsing tests: backup files (versions, corrupt input), pagination and error mapping.
  - Migration tests: every schema version step.
  - Data tests: repositories and queries against an in-memory Drift database.
- **Temporary tests**: write them to prove tricky logic (use `ProviderContainer` with `overrides` for Notifiers), then delete before finishing.
- Run `flutter test` after every change and keep it green.