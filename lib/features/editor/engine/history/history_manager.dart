import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';

/// Command History Stack Manager implementing Undo/Redo per Blueprint §8.1.
///
/// **Design Pattern**: Command Pattern with Dual Stack (Undo / Redo).
/// **Memory Strategy**: Limits history stack depth to 50 commands. Oldest commands are evicted when capacity is reached.
class HistoryManager {
  /// Creates a [HistoryManager].
  HistoryManager({
    this.maxLimit = 50,
  });

  /// Maximum stack depth.
  final int maxLimit;

  final List<HistoryCommand> _undoStack = [];
  final List<HistoryCommand> _redoStack = [];

  /// True if undo action is available.
  bool get canUndo => _undoStack.isNotEmpty;

  /// Exposes current undo command stack.
  List<HistoryCommand> get undoStack => List.from(_undoStack);

  /// True if redo action is available.
  bool get canRedo => _redoStack.isNotEmpty;

  /// Number of undo commands in stack.
  int get undoCount => _undoStack.length;

  /// Number of redo commands in stack.
  int get redoCount => _redoStack.length;

  /// Executes and records a new command.
  void executeCommand(HistoryCommand command, CanvasEngine engine) {
    command.execute(engine);
    _undoStack.add(command);
    _redoStack.clear();

    if (_undoStack.length > maxLimit) {
      _undoStack.removeAt(0);
    }
  }

  /// Undoes last command.
  void undo(CanvasEngine engine) {
    if (!canUndo) return;
    final command = _undoStack.removeLast();
    command.undo(engine);
    _redoStack.add(command);
  }

  /// Redoes last undone command.
  void redo(CanvasEngine engine) {
    if (!canRedo) return;
    final command = _redoStack.removeLast();
    command.redo(engine);
    _undoStack.add(command);
  }

  /// Clears undo and redo stacks.
  void clear() {
    _undoStack.clear();
    _redoStack.clear();
  }

  /// Alias for [clear].
  void clearHistory() => clear();
}
