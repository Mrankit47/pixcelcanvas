import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// History command recording that a copy operation occurred.
///
/// **Design**: Copy does not modify the canvas — it only populates the
/// clipboard. This command exists to maintain a complete, consistent history
/// log. All methods are no-ops on canvas state.
///
/// **Architecture**: Extends [HistoryCommand] — no framework dependencies.
class CopySelectionCommand extends HistoryCommand {
  /// Creates a [CopySelectionCommand].
  CopySelectionCommand();

  @override
  String get name => 'Copy Selection';

  @override
  void execute(CanvasEngine engine) {
    // No-op: copy does not modify canvas pixels.
    // Clipboard population is handled by ClipboardManager.
  }

  @override
  void undo(CanvasEngine engine) {
    // No-op: copy has no canvas side effects to reverse.
  }

  @override
  void redo(CanvasEngine engine) {
    // No-op: copy has no canvas side effects to re-apply.
  }
}
