import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_region.dart';

/// Immutable configuration settings for the selection tool.
///
/// **Purpose**: Defines selection tool appearance and behavior settings.
/// **Pattern**: Mirrors [BrushSettings] immutable value object with `copyWith`.
class SelectionSettings extends Equatable {
  /// Creates a [SelectionSettings].
  const SelectionSettings({
    this.selectionType = SelectionType.rectangle,
    this.borderColor = const Color(0xFF2196F3),
    this.borderWidth = 1.0,
    this.showOverlay = true,
    this.overlayOpacity = 0.15,
    this.handleSize = 6.0,
  });

  /// Active selection type.
  final SelectionType selectionType;

  /// Selection border color (default: Material Blue 500).
  final Color borderColor;

  /// Selection border stroke width in logical pixels.
  final double borderWidth;

  /// Whether to show the dimming overlay outside the selection.
  final bool showOverlay;

  /// Opacity of the dimming overlay (0.0 to 1.0).
  final double overlayOpacity;

  /// Size of resize handles in logical pixels.
  final double handleSize;

  /// Creates a copy of [SelectionSettings] with updated parameters.
  SelectionSettings copyWith({
    SelectionType? selectionType,
    Color? borderColor,
    double? borderWidth,
    bool? showOverlay,
    double? overlayOpacity,
    double? handleSize,
  }) =>
      SelectionSettings(
        selectionType: selectionType ?? this.selectionType,
        borderColor: borderColor ?? this.borderColor,
        borderWidth: borderWidth ?? this.borderWidth,
        showOverlay: showOverlay ?? this.showOverlay,
        overlayOpacity: overlayOpacity ?? this.overlayOpacity,
        handleSize: handleSize ?? this.handleSize,
      );

  @override
  List<Object?> get props => [
        selectionType,
        borderColor,
        borderWidth,
        showOverlay,
        overlayOpacity,
        handleSize,
      ];
}
