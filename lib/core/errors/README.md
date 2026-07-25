# Core Errors

Structured error handling hierarchy and exceptions for PixelCanvas per Blueprint §34.

## Files

- **`app_exception.dart`**: Base exception class with error code, user message, dev message, and severity.
- **`network_exception.dart`**: Network, API, and HTTP-related exceptions (`PC-NET-xxx`, `PC-AUT-xxx`).
- **`storage_exception.dart`**: Local database and disk I/O exceptions (`PC-DAT-xxx`, `PC-PRJ-xxx`).
