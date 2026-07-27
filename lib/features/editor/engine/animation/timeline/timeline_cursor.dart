import 'package:equatable/equatable.dart';

/// Playhead position container tracking frame index and sub-frame elapsed time.
class TimelineCursor extends Equatable {
  /// Creates a [TimelineCursor].
  const TimelineCursor({
    this.frameIndex = 0,
    this.subFrameTimeMs = 0,
  });

  /// Current playhead frame index.
  final int frameIndex;

  /// Elapsed sub-frame time in milliseconds.
  final int subFrameTimeMs;

  /// Creates a copy of [TimelineCursor] with updated values.
  TimelineCursor copyWith({
    int? frameIndex,
    int? subFrameTimeMs,
  }) =>
      TimelineCursor(
        frameIndex: (frameIndex ?? this.frameIndex).clamp(0, 4096),
        subFrameTimeMs: (subFrameTimeMs ?? this.subFrameTimeMs).clamp(0, 60000),
      );

  @override
  List<Object?> get props => [frameIndex, subFrameTimeMs];
}
