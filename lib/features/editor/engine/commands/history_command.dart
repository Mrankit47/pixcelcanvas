import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';

/// Abstract Command interface for reversible canvas operations per Blueprint §8.1.
///
/// **Design Pattern**: Command Pattern.
/// **Responsibilities**: Every command implements [execute], [undo], and [redo].
/// **Memory Strategy**: Stores minimal pixel delta list required to reverse the operation.
abstract class HistoryCommand {
  /// Command description name label.
  String get name;

  /// Executes command forward mutation.
  void execute(CanvasEngine engine);

  /// Reverses command mutation.
  void undo(CanvasEngine engine);

  /// Re-applies command mutation.
  void redo(CanvasEngine engine);
}
