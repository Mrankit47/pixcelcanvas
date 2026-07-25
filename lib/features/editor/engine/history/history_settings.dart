import 'package:equatable/equatable.dart';

/// Configuration settings for command history engine per Blueprint §8.1.
class HistorySettings extends Equatable {
  /// Creates a [HistorySettings].
  const HistorySettings({
    this.maxHistoryLimit = 50,
  });

  /// Maximum command stack depth (default: 50 commands).
  final int maxHistoryLimit;

  @override
  List<Object?> get props => [maxHistoryLimit];
}
