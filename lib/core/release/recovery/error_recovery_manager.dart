import 'package:flutter/material.dart';

/// Global error boundary manager catching unhandled exceptions gracefully per Blueprint §9.4.
class ErrorRecoveryManager extends ChangeNotifier {
  Object? _lastError;
  StackTrace? _lastStackTrace;

  /// Last caught error.
  Object? get lastError => _lastError;

  /// True if an error has occurred.
  bool get hasError => _lastError != null;

  /// Catches unhandled error [error].
  void catchError(Object error, StackTrace stackTrace) {
    _lastError = error;
    _lastStackTrace = stackTrace;
    notifyListeners();
  }

  /// Clears error state.
  void clearError() {
    _lastError = null;
    _lastStackTrace = null;
    notifyListeners();
  }
}
