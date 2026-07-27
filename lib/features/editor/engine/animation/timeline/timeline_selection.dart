import 'package:equatable/equatable.dart';

/// Selection state for frames and clips on the animation timeline.
class TimelineSelection extends Equatable {
  /// Creates a [TimelineSelection].
  const TimelineSelection({
    this.selectedFrameIndex = 0,
    this.selectedFrameIndices = const [0],
    this.selectedClipId,
  });

  /// Primary selected timeline frame index.
  final int selectedFrameIndex;

  /// Multi-select timeline frame indices.
  final List<int> selectedFrameIndices;

  /// Selected animation clip ID, or null.
  final String? selectedClipId;

  /// Creates a copy of [TimelineSelection] with updated parameters.
  TimelineSelection copyWith({
    int? selectedFrameIndex,
    List<int>? selectedFrameIndices,
    String? selectedClipId,
  }) =>
      TimelineSelection(
        selectedFrameIndex: selectedFrameIndex ?? this.selectedFrameIndex,
        selectedFrameIndices: selectedFrameIndices ?? this.selectedFrameIndices,
        selectedClipId: selectedClipId ?? this.selectedClipId,
      );

  @override
  List<Object?> get props => [
        selectedFrameIndex,
        selectedFrameIndices,
        selectedClipId,
      ];
}
