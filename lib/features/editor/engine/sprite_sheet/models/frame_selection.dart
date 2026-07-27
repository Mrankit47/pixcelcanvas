import 'package:equatable/equatable.dart';

/// Active frame selection state container.
///
/// **Purpose**: Maintains active frame index and multi-frame selection sets.
/// **Architecture**: Pure Dart value object with `copyWith` and `Equatable`.
class FrameSelection extends Equatable {
  /// Creates a [FrameSelection].
  const FrameSelection({
    this.selectedIndex = 0,
    this.selectedIndices = const [0],
  });

  /// Primary selected frame index.
  final int selectedIndex;

  /// Multi-select frame indices list.
  final List<int> selectedIndices;

  /// Creates a copy of [FrameSelection] with updated fields.
  FrameSelection copyWith({
    int? selectedIndex,
    List<int>? selectedIndices,
  }) =>
      FrameSelection(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        selectedIndices: selectedIndices ?? this.selectedIndices,
      );

  @override
  List<Object?> get props => [selectedIndex, selectedIndices];
}
