/// Provider lifecycle state enum.
enum ProviderLifecycleState {
  /// Provider created and registered.
  created,

  /// Provider state updated.
  updated,

  /// Provider disposed.
  disposed,

  /// Provider error state.
  failed,
}

/// Data model representing provider lifecycle metadata for telemetry.
class ProviderLifecycleEvent {
  /// Creates a [ProviderLifecycleEvent].
  const ProviderLifecycleEvent({
    required this.providerName,
    required this.state,
    required this.timestamp,
    this.value,
    this.error,
  });

  /// Name of provider.
  final String providerName;

  /// Lifecycle state.
  final ProviderLifecycleState state;

  /// Time event occurred.
  final DateTime timestamp;

  /// Associated value if updated.
  final Object? value;

  /// Associated error if failed.
  final Object? error;
}
