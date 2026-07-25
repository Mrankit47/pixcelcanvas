import 'package:equatable/equatable.dart';

/// Immutable configuration settings for a layer per Blueprint §8.1.
///
/// **Purpose**: Stores metadata for a single canvas layer.
/// **Future Extensions**: Layer groups, masks, blend modes, clipping masks.
class LayerSettings extends Equatable {
  /// Creates a [LayerSettings].
  const LayerSettings({
    required this.id,
    required this.name,
    this.isVisible = true,
    this.isLocked = false,
    this.opacity = 1.0,
    this.index = 0,
  });

  /// Unique layer identifier.
  final String id;

  /// Display name.
  final String name;

  /// Visibility toggle.
  final bool isVisible;

  /// Lock toggle.
  final bool isLocked;

  /// Layer opacity multiplier (0.0 to 1.0).
  final double opacity;

  /// Stack order index (0 = bottom).
  final int index;

  /// Creates a copy with updated fields.
  LayerSettings copyWith({
    String? id,
    String? name,
    bool? isVisible,
    bool? isLocked,
    double? opacity,
    int? index,
  }) =>
      LayerSettings(
        id: id ?? this.id,
        name: name ?? this.name,
        isVisible: isVisible ?? this.isVisible,
        isLocked: isLocked ?? this.isLocked,
        opacity: (opacity ?? this.opacity).clamp(0.0, 1.0),
        index: index ?? this.index,
      );

  @override
  List<Object?> get props => [id, name, isVisible, isLocked, opacity, index];
}
