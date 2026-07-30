import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/settings/models/shortcut_binding.dart';
import 'package:pixelcanvas/features/settings/services/shortcut_conflict_resolver.dart';

/// Keyboard shortcut manager coordinating custom key rebinds & conflict detection.
class KeyboardShortcutManager extends ChangeNotifier {
  final List<ShortcutBinding> _bindings = List.from(ShortcutBinding.defaultBindings);

  /// Unmodifiable list of active shortcut bindings.
  List<ShortcutBinding> get bindings => List<ShortcutBinding>.from(_bindings);

  /// Active shortcut conflicts list.
  List<ShortcutConflict> get conflicts => ShortcutConflictResolver.detectConflicts(_bindings);

  /// True if key binding conflicts exist.
  bool get hasConflicts => conflicts.isNotEmpty;

  /// Rebinds action [actionId] to [newKeyCombo].
  void rebindShortcut(String actionId, String newKeyCombo) {
    final idx = _bindings.indexWhere((b) => b.actionId == actionId);
    if (idx >= 0) {
      _bindings[idx] = _bindings[idx].copyWith(customKeyCombo: newKeyCombo);
      notifyListeners();
    }
  }

  /// Resets shortcut [actionId] back to default key combo.
  void resetToDefault(String actionId) {
    final idx = _bindings.indexWhere((b) => b.actionId == actionId);
    if (idx >= 0) {
      _bindings[idx] = _bindings[idx].copyWith(customKeyCombo: null);
      notifyListeners();
    }
  }

  /// Resets all shortcuts to factory defaults.
  void resetAllToDefaults() {
    _bindings.clear();
    _bindings.addAll(ShortcutBinding.defaultBindings);
    notifyListeners();
  }
}
