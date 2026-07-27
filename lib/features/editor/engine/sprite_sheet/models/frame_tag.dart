import 'package:equatable/equatable.dart';

/// Tag classifications for sprite frames (e.g. Idle, Walk, Run, Jump, Attack, Custom).
class FrameTag extends Equatable {
  /// Creates a [FrameTag].
  const FrameTag(this.name);

  /// Preset Idle tag.
  static const FrameTag idle = FrameTag('Idle');

  /// Preset Walk tag.
  static const FrameTag walk = FrameTag('Walk');

  /// Preset Run tag.
  static const FrameTag run = FrameTag('Run');

  /// Preset Jump tag.
  static const FrameTag jump = FrameTag('Jump');

  /// Preset Attack tag.
  static const FrameTag attack = FrameTag('Attack');

  /// Tag string identifier label.
  final String name;

  /// Creates a custom tag with [label].
  factory FrameTag.custom(String label) => FrameTag(label);

  @override
  List<Object?> get props => [name];
}
