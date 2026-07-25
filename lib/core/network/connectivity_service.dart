import 'dart:async';

/// Abstract contract for device connectivity monitoring.
///
/// Implemented by concrete connectivity service in data layer.
abstract class ConnectivityService {
  /// Stream emitting connectivity state updates (true = online, false = offline).
  Stream<bool> get onConnectivityChanged;

  /// Returns current connectivity status synchronously.
  Future<bool> get isConnected;
}
