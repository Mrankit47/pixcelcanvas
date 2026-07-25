/// Interface for API request/response logging and exception handling.
abstract class ApiInterceptor {
  /// Processes API error response into typed [AppException].
  void onError(Object error, StackTrace stackTrace);
}
