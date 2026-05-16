---
description: Standard Development & Maintenance Workflow (Clean Architecture & UI Design) for QuanLyBanHang Project (/cleancode)
---

When developing new features or performing refactoring in the QuanLyBanHang project, strictly adhere to the following professional workflow:

### // turbo-all

## Step 0: Preparation & Design (Database First)
- Before coding, read or update the `docs/database.md` documentation.
- Ensure a clear understanding of the Entity Schema (field names, data types, parent-child relationships).

## Step 1: Domain Layer (Requirements & Business Logic)
Always start from the "Heart" of the application (innermost layer).
1. **Entity**: Create the file at `lib/domain/entities/[name]_entity.dart`.
    - Must be a plain class with `final` properties.
    - **FORBIDDEN**: Do NOT import any files from the Data or Presentation layers.
2. **Repository Interface**: Define the interface (contract) at `lib/domain/repositories/`.
3. **UseCase**: Create single-responsibility classes at `lib/domain/usecases/`.
4. **Failure**: Define business-specific errors at `lib/core/error/failures.dart`.

## Step 2: Data Layer (Structure & Data Access)
Bridge the application to the local database.
1. **Model**: Create the file at `lib/data/models/[name]_model.dart`.
    - **GOLDEN RULE**: Absolutely DO NOT `extends` from the Entity.
    - Must include all mappers: `fromJson`, `toJson`, `toEntity`, and `fromEntity`.
2. **DataSource**: Implement direct local database calls using Drift at `lib/data/datasources/local/`. 
3. **Repository Implementation**: Implement the Domain interface at `lib/data/repositories/`. 
    - **Responsibility**: Call the DataSource, catch errors and map them to `Failure`, and transform Data <=> Entity using mappers before returning data.

## Step 3: Presentation Layer (UI & UI Logic)
1. **Routing**: 
    - Mandatory use of `go_router` for navigation. 
    - Central Route configuration located at `lib/core/routes/app_router.dart`.
    - Navigate between screens using `context.go()` or `context.push()`. For Dialogs/BottomSheets, still use `Navigator.pop(context)` as usual.
    - Protect screens that require login using the `redirect` property combined with `AuthBloc` (Auth Guard).
2. **BLoC**: Manage state logic at `lib/presentation/bloc/`. 
    - Clearly separate `Event`, `State`, and `Bloc`.
    - **CRITICAL**: Mandatory use of the `freezed` library for `State` to automatically generate `==`, `copyWith` functions, and Pattern Matching (`when`, `maybeWhen`). Do not use `equatable`.
    - **CRITICAL**: Mandatory to have standard States: `initial`, `loading`, `success/loaded`, `failure/error`.
    - **CRITICAL**: For Streams (e.g., Drift watch queries), ALWAYS use `emit.forEach` instead of `Stream.listen`. 
    - **CRITICAL**: Never call `emit` inside an unawaited callback or after the handler completes.
3. **Widgets & Composition**: Build the UI at `lib/presentation/screens/`.
    - **Priority**: Decompose screens into smaller components (Widgets) for maintainability and reuse.
    - **CRITICAL**: BEFORE creating a new widget, check `lib/presentation/widgets/` to REUSE existing ones (e.g., `EmptyDataWidget`, `AppTextField`, `AppDropdownField`, `AppDialogActions`, `AppSectionHeader`, `AppSnackBar`).
    - **Directory Structure**: 
        - Screen-specific widgets: `lib/presentation/screens/[screen_name]/widgets/`.
        - Shared widgets: `lib/presentation/widgets/`.
    - **COLOR RULE**: Mandatory use of the `AppColors` class from `lib/core/constants/app_colors.dart`.
    - **FORBIDDEN**: Do NOT hardcode hex color codes or use default Flutter `Colors.[name]` constants in UI code.

## Step 4: Dependency Injection (Wiring)
- Register components sequentially in `lib/core/di/dependency_injection.dart`:
  `DataSource -> Repository -> UseCase -> Bloc`.

## Step 5: Verification & Completion
1. **Unit Test**: Prioritize writing tests for UseCases and Repositories in the `test/` directory.
2. **Analysis**: Run `flutter analyze` to ensure clean code and no unused imports.
3. **Refactor**: Remove dead code and temporary files after completion.

---
## 🤖 MANDATORY TECH STACK & ARCHITECTURE PATTERNS
To prevent AI hallucination and ensure 100% codebase consistency, YOU MUST strictly use the following packages and patterns. DO NOT suggest or use alternatives.

### 1. Core Tech Stack
- **State Management**: `flutter_bloc` + `freezed`
- **Routing**: `go_router`
- **Dependency Injection**: `get_it` (Registered sequentially in `lib/core/di/dependency_injection.dart`)
- **Local Database**: `drift` (For all local SQLite storage)

### 2. Coding Patterns
- **Data Mappers**: ALWAYS use `factory` constructors for mapping data (e.g., `factory ProductModel.fromEntity(ProductEntity entity)` or `factory ProductModel.fromJson(Map<String, dynamic> json)`). DO NOT use Dart `extension` methods for mapping.
- **BLoC Placement**: 
  - If a BLoC is shared globally across multiple screens (e.g., `AuthBloc`), place it in `lib/presentation/bloc/`.
  - If a BLoC is feature-specific and belongs to a single screen, it MUST be placed inside the screen's directory: `lib/presentation/screens/[screen_name]/bloc/`.

### 3. Localization (Multi-language)
We use Flutter's native, type-safe localization (`intl` package with `.arb` files).
- **Directory Structure**: Store all translation files in `lib/l10n/` (e.g., `app_en.arb` for English, `app_vi.arb` for Vietnamese).
- **Usage Rule**: Always use the auto-generated `AppLocalizations` class in the UI. Example: `Text(AppLocalizations.of(context)!.loginText)`.
- **FORBIDDEN**: NEVER hardcode readable text strings in UI widgets (e.g., `Text('Login')`). Always add the string to the `.arb` files first.

### 4. Coding Culture & Strict Conventions
- **Utility Functions**: ALWAYS extract reusable logic (e.g., date formatting, currency formatting, string manipulation) into separate helper classes/functions inside `lib/core/utils/` (e.g., `CurrencyUtils`, `DateUtils`). NEVER leave generic helper functions inside UI or BLoC files.
- **Money Rules [CRITICAL]**: NEVER use `double` for currency/money fields (to avoid floating-point math errors). ALWAYS use `int` (representing the absolute value in VND).
- **Result Type Rule**: Repositories MUST ALWAYS return an `Either<Failure, T>` (using functional programming like `dartz` or `fpdart`). NEVER allow Repositories to throw Exceptions directly to the UI.
- **DateTime Rules**: ALWAYS store dates in the local database as UTC (`DateTime.toUtc()`). ONLY convert to local time (`toLocal()`) at the Presentation layer just before displaying to the user.
- **UseCase Convention**: One UseCase class = One Single Action. Names MUST start with an action verb (e.g., `GetProductsUseCase`, `CreateOrderUseCase`).

---
## 🤖 AI BEHAVIOR & MODULARITY RULES
To prevent "lazy" monolithic code generation, YOU (the AI) MUST strictly obey these behavioral constraints:

1. **[MANDATORY] CHECK BEFORE CREATE**: Before writing ANY new UI widget (Button, TextField, Dialog, Card), you MUST use tools (`list_dir` or `grep_search`) to check `lib/presentation/widgets/`. If a shared component exists, REUSE it. Do NOT duplicate functionality.
2. **[CRITICAL] COMPONENT EXTRACTION**: Never dump a massive widget tree into a single Screen file. Break down the UI into logical, single-responsibility components (e.g., `HeaderSection`, `ItemListWidget`, `ActionButtons`). 
3. **[FORBIDDEN] NO HELPER METHODS FOR UI**: Do NOT use helper methods that return Widgets (e.g., `Widget _buildList() { return ... }`). You MUST extract them into separate `StatelessWidget` or `StatefulWidget` classes. This prevents unnecessary rebuilds and keeps files clean.
4. **[WORKFLOW] STEP-BY-STEP GENERATION**: When asked to create a complex Screen or Feature, DO NOT generate everything in one massive response. 
   - First, propose the component breakdown.
   - Then, create the individual component files in the `widgets/` folder.
   - Finally, assemble them in the main Screen file.

---
**Note for AI**: Always maintain Model-Entity consistency through mapper functions. If a database field changes, update in order: `database.md` -> `Model` -> `Entity` -> `UI`.
