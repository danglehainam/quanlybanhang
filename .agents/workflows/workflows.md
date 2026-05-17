---
description: Standard Development & Maintenance Workflow (Clean Architecture & UI Design) for QuanLyBanHang Project (/cleancode)
---

> **MANDATORY**: AI MUST strictly follow this entire file when developing any feature. No creativity, no alternatives.

### // turbo-all

---

# PART A: GLOBAL RULES

The following rules apply to **EVERY step**, **EVERY file**, **EVERY layer** in the project.

## A1. Required Tech Stack
- **State**: `flutter_bloc` + `freezed` (❌ No `equatable`, `provider`, `riverpod`)
- **Nav**: `go_router` (Config at `lib/core/routes/app_router.dart`)
- **DI**: `get_it` (Register at `lib/core/di/dependency_injection.dart`)
- **DB**: `drift` (SQLite local storage)
- **l10n**: `intl` (`.arb` files stored at `lib/l10n/`)
- **Settings**: `shared_preferences` (Used by SettingsBloc)
- **Error**: `dartz` or `fpdart` (Return type `Either<Failure, T>`)
- ❌ **FORBIDDEN**: Adding new packages to `pubspec.yaml` without user permission.

## A2. Naming Rules
- Files and folders: `snake_case` (e.g. `product_model.dart`).
- Classes: `PascalCase` (e.g. `PosScreen`, `ProductModel`).
- Variables and functions: `camelCase` (e.g. `finalAmount`, `getProducts()`).
- BLoC files: `[name]_bloc.dart`, `[name]_event.dart`, `[name]_state.dart`.

## A3. Money Rules
- ❌ **ABSOLUTELY FORBIDDEN** to use `double` for currency (floating-point precision errors).
- ✅ **MUST** use `int` (unit: VND). e.g. `15000` not `15000.0`.

## A4. DateTime Rules
- ✅ Store in database as UTC (`DateTime.toUtc()`).
- ✅ Only convert to local time (`toLocal()`) at Presentation layer, right before display.

## A5. Localization Rules
- ❌ **FORBIDDEN** to hardcode display strings in UI (e.g. `Text('Login')`).
- ✅ Always add strings to `.arb` files first, then use `AppLocalizations.of(context)!.keyName`.

## A6. Color Rules
- ❌ **FORBIDDEN** to hardcode hex colors or use Flutter's default `Colors.blue`.
- ✅ Always use `AppColors` from `lib/core/constants/app_colors.dart`.

## A7. Utility Rules
- ✅ All reusable logic (formatting, dates, strings...) MUST go in `lib/core/utils/`.
- ❌ **FORBIDDEN** to put utility functions inside BLoC or UI files.

## A8. Code Generation Rules
- ✅ Whenever modifying `Freezed` (State/Event) or `Drift` table files, **MUST** run: `dart run build_runner build -d`.
- ✅ `.freezed.dart` and `.g.dart` are auto-generated files. **FORBIDDEN** to edit them manually.

## A9. Responsive UI Rules (Hybrid Pattern)
- ✅ Use `SettingsBloc` to store `ViewMode` (auto, mobile, desktop), synced via `shared_preferences`.
- ✅ Use `ResponsiveWrapper` at `lib/core/utils/responsive_wrapper.dart`: macOS/Windows → Desktop, others → Mobile. Respect manual override.
- ✅ Complex screens: **MUST** split into `[screen]_mobile_view.dart` and `[screen]_desktop_view.dart`, wrapped by `ResponsiveWrapper`.
- ✅ Simple screens: Use single file with `Container(maxWidth: 500)`.
- ❌ **FORBIDDEN** to duplicate business logic. Both Mobile and Desktop views MUST share the same BLoC.

## A10. Side Effect Rules
- ❌ **FORBIDDEN** to call `Navigator`, `showDialog`, or `ScaffoldMessenger` inside BLoC.
- ✅ BLoC only emits state. UI handles side effects via `BlocListener`.

## A11. Constants Rules
- ✅ Route names: managed in `lib/core/constants/app_routes.dart`.
- ✅ SharedPreferences keys: managed in `lib/core/constants/pref_keys.dart`.
- ✅ Colors, Spacing, Durations: managed in `lib/core/constants/`.
- ❌ **FORBIDDEN** to hardcode route names, pref keys, or magic numbers in BLoC/UI.

## A12. Async UX Rules
- ✅ Loading state → show `AppLoadingWidget`.
- ✅ Empty data → show `EmptyDataWidget`.
- ✅ Error state → show `AppErrorWidget` with **mandatory** `onRetry` callback.
- ❌ **FORBIDDEN** to show blank screens for any async state.

## A13. Validation Rules (2-Layer)
- **Layer 1 — UI/Form**: Validate format (empty, length, email format). Done via `TextFormField.validator`.
- **Layer 2 — UseCase**: Validate business rules (duplicate name, insufficient balance). Return `Left(Failure)`.
- ❌ **FORBIDDEN** to put business validation in UI. ❌ **FORBIDDEN** to put format validation in UseCase.

## A15. Memory Management & Lifecycle Rules
- ✅ **ALWAYS** call `dispose()` for any `Controller` (`TextEditingController`, `ScrollController`, `AnimationController`, etc.) inside `StatefulWidget.dispose`.
- ✅ **ALWAYS** call `cancel()` on any `StreamSubscription` or `Timer` when the widget is disposed.
- ✅ **ALWAYS** check `if (!mounted) return;` when using `BuildContext` after an `await` call (async gaps) to prevent memory leaks and crash errors.
- ❌ **FORBIDDEN** to store large objects, Contexts, or unnecessary Lists in global singletons (GetIt) unless they are core Services/Repositories. State must be handled locally in BLoC.

## A14. Permission Rules
- ✅ `AuthBloc` MUST cache user's permission codes (from `role_permissions` table) after login. No DB query per render.
- ✅ Wrap permission-required widgets with `PermissionGuard(permission: 'code', child: widget)` at `lib/presentation/widgets/permission_guard.dart`.
- ✅ Logic: `is_owner == 1` → always show. `permissions.contains(code)` → show. Else → `SizedBox.shrink()`.
- ❌ **FORBIDDEN** to query database for permission checks on every widget render.

---

# PART B: DEVELOPMENT WORKFLOW (Step by Step)

---

## Step 0: Preparation & Design (Database First)
**What**: Read or update `docs/database.md`.
**Purpose**: Understand schema (field names, data types, relationships) before writing any code.

---

## Step 1: Domain Layer (Core Business)
**What**: Always start from the "heart" of the application (innermost layer).

| Component | File Path | Description |
| :--- | :--- | :--- |
| Entity | `lib/domain/entities/[name]_entity.dart` | Pure Dart class |
| Repository Interface | `lib/domain/repositories/[name]_repository.dart` | Abstract contract |
| UseCase | `lib/domain/usecases/[verb]_[name]_usecase.dart` | One class = One action |
| Failure | `lib/core/error/failures.dart` | Business error definitions |

**Rules for this step:**
- ✅ Entity MUST be a pure Dart class with `const` constructor and `final` properties.
- ✅ UseCase name MUST start with an action verb (e.g. `GetCategoriesUseCase`, `CreateCategoryUseCase`).
- ✅ UseCase MUST use `call()` method so it can be invoked like a function.
- ✅ Repository Interface MUST declare return type as `Either<Failure, T>`.
- ❌ **FORBIDDEN** for Entity to import any file from Data or Presentation layer.
- ❌ **FORBIDDEN** to write `try-catch` in UseCase.

---

## Step 2: Data Layer (Data Access)
**What**: Connect the application to local database (Drift/SQLite).

| Component | File Path | Description |
| :--- | :--- | :--- |
| Drift Table | `lib/data/datasources/local/tables/[name]_table.dart` | Drift table definition |
| AppDatabase | `lib/data/datasources/local/app_database.dart` | Central file connecting all tables |
| Model | `lib/data/models/[name]_model.dart` | Data mapping object |
| DataSource | `lib/data/datasources/local/[name]_local_datasource.dart` | Direct Drift API calls |
| Repository Impl | `lib/data/repositories/[name]_repository_impl.dart` | Implements Domain contract |

**Rules for this step:**
- ✅ Drift Table MUST be placed at `lib/data/datasources/local/tables/`.
- ✅ AppDatabase MUST be at `lib/data/datasources/local/app_database.dart`. Add new tables to `@DriftDatabase(tables: [...])`.
- ✅ Model MUST have all 4 mappers using `factory` constructor: `fromJson`, `toJson`, `fromEntity`, `toEntity`.
- ✅ `try-catch` is ONLY allowed in Repository Impl. Catches Exception, converts to `Failure`.
- ❌ **FORBIDDEN** for Model to extend Entity.
- ❌ **FORBIDDEN** to use `extension` methods for data mapping. Use `factory` constructors only.
- ❌ **FORBIDDEN** to write `try-catch` in BLoC or UseCase.

---

## Step 3: Presentation Layer (UI & State)
**What**: Build user interface and manage display state.

### 3.1 Routing
- ✅ Use `go_router`. Central config at `lib/core/routes/app_router.dart`.
- ✅ Navigate with `context.go()` or `context.push()`.
- ✅ Close Dialog/BottomSheet with `Navigator.pop(context)`.
- ✅ Protect screens requiring login via `redirect` + `AuthBloc`.
- ✅ When adding new screens, register routes in `app_router.dart` following existing patterns.

### 3.2 BLoC (State Management)

| Component | File Path |
| :--- | :--- |
| Shared BLoC (e.g. `AuthBloc`, `SettingsBloc`) | `lib/presentation/bloc/[name]/` |
| Screen-specific BLoC | `lib/presentation/screens/[screen_name]/bloc/` |

Each BLoC folder always has exactly 3 files:
- `[name]_bloc.dart` — Event → State processing logic.
- `[name]_event.dart` — Event declarations (using `freezed`).
- `[name]_state.dart` — State declarations (using `freezed`).

**Rules:**
- ✅ MUST use `freezed` for State and Event. Class declaration MUST include `abstract` keyword.
- ✅ MUST have all 4 standard states: `initial`, `loading`, `loaded/success`, `error/failure`.
- ✅ For Streams (e.g. Drift watch query): Always use `emit.forEach`, **FORBIDDEN** to use `Stream.listen`.
- ❌ **FORBIDDEN** to call `emit` inside un-awaited callbacks or after handler completes.
- ❌ **FORBIDDEN** to write `try-catch` in BLoC (errors are handled at Repository layer).

### 3.3 Widgets & Layout

| Component | File Path |
| :--- | :--- |
| Main screen | `lib/presentation/screens/[screen_name]/[name]_screen.dart` |
| Screen-specific widgets | `lib/presentation/screens/[screen_name]/widgets/` |
| Shared app-wide widgets | `lib/presentation/widgets/` |
| Mobile view (if split) | `lib/presentation/screens/[screen_name]/views/[name]_mobile_view.dart` |
| Desktop view (if split) | `lib/presentation/screens/[screen_name]/views/[name]_desktop_view.dart` |

**Rules:**
- ✅ Prefer splitting screens into small single-responsibility child widgets (e.g. `HeaderSection`, `ItemListWidget`).
- ✅ MUST check `lib/presentation/widgets/` before creating new widgets. Reuse if existing (e.g. `AppTextField`, `AppSnackBar`, `EmptyDataWidget`).
- ❌ **FORBIDDEN** to write widget-returning functions (e.g. `Widget _buildList() { ... }`). Must extract into separate `StatelessWidget` or `StatefulWidget`.

---

## Step 4: Dependency Injection (Wiring)
**What**: Register components in `lib/core/di/dependency_injection.dart`.
**Registration order MUST be**: `DataSource → Repository → UseCase → Bloc`.

- ✅ DataSource and Repository use `registerLazySingleton` (created once).
- ✅ Bloc uses `registerFactory` (created fresh each time).

---

## Step 5: Verify & Finalize
**What**: Ensure clean, error-free code.

1. ✅ Run `dart run build_runner build -d` if any Freezed or Drift files were modified.
2. ✅ Run `flutter analyze` to check clean code, no unused imports.
3. ✅ Write Unit Tests for UseCase and Repository in `test/` directory.
4. ✅ Remove junk files and dead code after completion.

---

# PART C: AI BEHAVIOR (MANDATORY)

To prevent AI from generating "lazy" or "wrong" code, AI **MUST** follow:

## C1. When CREATING new features
1. **[MUST] CHECK BEFORE CREATING**: Before writing any new widget, MUST use `list_dir` or `grep_search` to check `lib/presentation/widgets/`. If similar widget exists, REUSE it.
2. **[MUST] GENERATE CODE STEP BY STEP**: When asked to create a complex screen, DO NOT generate everything at once. Must:
   - Propose list of child widgets first.
   - Create each widget file in `widgets/` folder.
   - Finally assemble into the main screen file.

## C2. When MODIFYING existing features
When data structure changes (add/modify/delete fields), **MUST** update in this exact order:
1. `docs/database.md` — Update database design document.
2. `Drift Table` — Modify table definition at `lib/data/datasources/local/tables/`.
3. `Migration` — Write migration in `app_database.dart`.
4. `Model` — Update mappers at `lib/data/models/`.
5. `Entity` — Update properties at `lib/domain/entities/`.
6. `BLoC` — Update State/Event if needed.
7. `UI` — Update display interface.
8. Run `dart run build_runner build -d` to regenerate code.
9. Run `flutter analyze` to ensure no errors.

**Migration Rules:**
- ✅ After modifying Drift Table, **MUST** increment `schemaVersion` by 1 in `app_database.dart`.
- ✅ **MUST** write `onUpgrade` handler in `MigrationStrategy` (e.g. `addColumn`, `createTable`).
- ❌ **FORBIDDEN** to delete old migration steps (users who haven't updated still need them).
- ❌ **FORBIDDEN** to skip any step in the chain above.
- ❌ **FORBIDDEN** to modify UI before modifying Entity/Model (causes type errors).