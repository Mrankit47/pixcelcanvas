/// Base application exception hierarchy for PixelCanvas.
///
/// Follows the structured error format `PC-{DOMAIN}-{NUMBER}` defined in Blueprint §34.
abstract class AppException implements Exception {
  /// Creates an [AppException] with code, user message, developer message, and optional details.
  const AppException({
    required this.code,
    required this.userMessage,
    required this.devMessage,
    this.details,
    this.stackTrace,
  });

  /// Unique error code in `PC-XXX-NNN` format.
  final String code;

  /// Human-readable message suitable for displaying in UI.
  final String userMessage;

  /// Technical message for developer logs and telemetry.
  final String devMessage;

  /// Optional contextual details object.
  final Object? details;

  /// Optional stack trace associated with the exception.
  final StackTrace? stackTrace;

  @override
  String toString() => '[$code] $userMessage ($devMessage)';
}
