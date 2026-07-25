# PixelCanvas

> **The simplest way to create pixel art — anywhere, anytime, even offline.**

PixelCanvas is a modern, offline-first pixel art creation platform built with Flutter. Designed for beginners, students, artists, and game developers.

---

## Project Overview

| Attribute | Value |
|---|---|
| **Platform** | Android First → iOS → Web → Desktop |
| **Framework** | Flutter (latest stable) |
| **Language** | Dart 3 (sound null safety) |
| **State Management** | Riverpod 2.x |
| **Local Database** | Isar |
| **Backend** | Supabase (Free Tier) |
| **Architecture** | Feature-First, Offline-First |
| **Theme** | Light Only — Material 3 |
| **Min Android SDK** | 26 (Android 8.0) |

---

## Architecture

PixelCanvas follows a **Feature-First** architecture with clean separation into three layers per feature:

```
feature/
├── data/            # Implementation (Isar schemas, Supabase calls)
│   ├── models/
│   ├── datasources/
│   └── *_repository_impl.dart
├── domain/          # Business logic (pure Dart, no dependencies)
│   ├── entities/
│   ├── *_repository.dart
│   └── *_service.dart
└── presentation/    # UI
    ├── *_screen.dart
    ├── providers/
    └── widgets/
```

Data flows upward: `DataSource → Repository → Notifier → Widget`

Dependencies point inward: Presentation → Domain ← Data

---

## Folder Structure

```
lib/
├── main.dart                  # App entry point
├── app.dart                   # MaterialApp configuration
├── bootstrap.dart             # Dependency initialization (future)
├── core/                      # Shared core — NOT feature-specific
│   ├── constants/
│   ├── errors/
│   ├── extensions/
│   ├── network/
│   ├── storage/
│   ├── sync/
│   └── utils/
├── shared/                    # Shared UI components
│   ├── widgets/
│   ├── layout/
│   └── animations/
├── theme/                     # Design system — LIGHT ONLY
├── navigation/                # go_router config
└── features/                  # Feature modules
    ├── splash/
    ├── onboarding/
    ├── auth/
    ├── home/
    ├── projects/
    ├── editor/
    ├── layers/
    ├── palette/
    ├── templates/
    ├── community/
    ├── notifications/
    ├── profile/
    ├── settings/
    └── export/

assets/
├── images/
├── illustrations/
├── templates/
├── palettes/
├── lottie/
├── fonts/
├── icons/
├── sounds/
└── l10n/
```

---

## Getting Started

### Prerequisites

- Flutter SDK (latest stable channel)
- Dart SDK ≥ 3.8.0
- Android Studio / VS Code
- Android SDK (API 26+)
- Git

### Setup

```bash
# Clone the repository
git clone <repository-url>
cd PixelCanvas

# Install dependencies
flutter pub get

# Run code generation (when dependencies are added)
dart run build_runner build --delete-conflicting-outputs

# Verify setup
flutter doctor
flutter analyze
```

---

## How to Run

```bash
# Run on connected Android device / emulator
flutter run

# Run on Chrome (web)
flutter run -d chrome

# Run on Windows desktop
flutter run -d windows

# Run on iOS simulator (macOS only)
flutter run -d ios
```

---

## Build Commands

```bash
# Android APK (debug)
flutter build apk --debug

# Android APK (release)
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# Analyze APK size
flutter build apk --release --analyze-size

# iOS (macOS only)
flutter build ios --release

# Web
flutter build web --release

# Windows desktop
flutter build windows --release
```

---

## Coding Standards

### Naming Conventions

| Element | Convention | Example |
|---|---|---|
| Files | `snake_case` | `canvas_notifier.dart` |
| Classes | `PascalCase` | `CanvasNotifier` |
| Variables | `camelCase` | `gridSize` |
| Constants | `camelCase` | `const maxUndoSteps = 50;` |
| Enums | `PascalCase` / `camelCase` | `enum ToolType { pencil, eraser }` |
| Providers | `camelCase` + `Provider` | `canvasNotifierProvider` |
| Booleans | `is` / `has` / `should` | `isVisible`, `hasChanges` |
| Callbacks | `on` prefix | `onColorSelected` |

### Rules

- **No** abbreviations in identifiers
- **No** widget `build()` methods > 80 lines
- **No** function bodies > 30 lines
- **Every** public API has a `///` doc comment
- **Prefer** `const` constructors everywhere possible
- **Prefer** `final` local variables
- **Never** use `print()` — use a structured logger
- **Always** dispose controllers

### Git Conventions

- **Branches:** `main`, `develop`, `feature/*`, `bugfix/*`, `release/*`
- **Commits:** Conventional Commits — `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`
- **PRs:** Small, atomic. One logical change per PR.

---

## License

MIT License — see [LICENSE](LICENSE) for details.
