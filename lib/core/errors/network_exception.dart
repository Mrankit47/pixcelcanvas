import 'package:pixelcanvas/core/errors/app_exception.dart';

/// Network-related exception for connectivity, API timeouts, and HTTP failures.
///
/// Error domain: `PC-NET-xxx` per Blueprint §34.
class NetworkException extends AppException {
  /// Creates a [NetworkException].
  const NetworkException({
    required super.code,
    required super.userMessage,
    required super.devMessage,
    super.details,
    super.stackTrace,
  });

  /// Factory for no connectivity error (`PC-NET-001`).
  factory NetworkException.noConnection() => const NetworkException(
        code: 'PC-NET-001',
        userMessage: "You're offline. Your work is saved locally.",
        devMessage: 'Net: no connectivity available',
      );

  /// Factory for timeout error (`PC-NET-002`).
  factory NetworkException.timeout([String? url]) => NetworkException(
        code: 'PC-NET-002',
        userMessage: 'Connection timed out. Please try again.',
        devMessage: 'Net: timeout requesting $url',
      );
}
