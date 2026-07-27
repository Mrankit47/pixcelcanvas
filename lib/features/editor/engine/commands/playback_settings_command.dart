import 'package:pixelcanvas/features/editor/engine/animation/models/animation_settings.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Reversible history command for updating animation playback and onion skin settings.
class PlaybackSettingsCommand extends HistoryCommand {
  /// Creates a [PlaybackSettingsCommand].
  PlaybackSettingsCommand({
    required this.previousSettings,
    required this.newSettings,
  });

  /// Original settings configuration.
  final AnimationSettings previousSettings;

  /// Target new settings configuration.
  final AnimationSettings newSettings;

  @override
  String get name => 'Update Playback Settings';

  @override
  void execute(CanvasEngine engine) {
    // Applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    engine.animationEngine.settings = previousSettings;
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    engine.animationEngine.settings = newSettings;
    engine.compositeVisibleLayers();
  }
}
