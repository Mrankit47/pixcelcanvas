import 'package:pixelcanvas/features/settings/models/shortcut_binding.dart';

/// Conflict report item descriptor.
class ShortcutConflict {
  const ShortcutConflict({
    required this.keyCombo,
    required this.bindingA,
    required this.bindingB,
  });

  final String keyCombo;
  final ShortcutBinding bindingA;
  final ShortcutBinding bindingB;
}

/// Service detecting shortcut key combination conflicts per Blueprint §8.3.
class ShortcutConflictResolver {
  /// Detects all active conflicts within [bindings] list.
  static List<ShortcutConflict> detectConflicts(List<ShortcutBinding> bindings) {
    final conflicts = <ShortcutConflict>[];
    final map = <String, ShortcutBinding>{};

    for (final binding in bindings) {
      final combo = binding.activeCombo.toUpperCase();
      if (map.containsKey(combo)) {
        conflicts.add(
          ShortcutConflict(
            keyCombo: combo,
            bindingA: map[combo]!,
            bindingB: binding,
          ),
        );
      } else {
        map[combo] = binding;
      }
    }

    return conflicts;
  }
}
