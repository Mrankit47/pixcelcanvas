# Core Services

Core application infrastructure services per Blueprint §8.1.

## Services

- **`startup_service.dart`**: High-level startup orchestration and health verification service contract.
- **`lifecycle_service.dart`**: Application lifecycle state observer (`WidgetsBindingObserver`) tracking foreground, background, inactive, and detached app transitions with structured logging.
