import 'dart:async';
import 'package:flutter/foundation.dart';

/// Timer-based debouncer for auto-save and search inputs per Blueprint §11.3.
class Debouncer {
  /// Creates a [Debouncer] with specified delay.
  Debouncer({required this.duration});

  /// Delay duration.
  final Duration duration;

  Timer? _timer;

  /// Runs callback after [duration] of inactivity.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// Cancels pending timer.
  void cancel() {
    _timer?.cancel();
  }
}
