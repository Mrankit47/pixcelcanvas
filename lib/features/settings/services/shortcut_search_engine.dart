import 'package:pixelcanvas/features/settings/models/shortcut_binding.dart';
import 'package:pixelcanvas/features/settings/models/shortcut_category.dart';

/// Search engine filtering keyboard shortcut bindings.
class ShortcutSearchEngine {
  /// Filters [bindings] list according to [query] and [category].
  static List<ShortcutBinding> filter(
    List<ShortcutBinding> bindings, {
    String query = '',
    ShortcutCategory? category,
  }) {
    return bindings.where((b) {
      if (category != null && b.category != category) return false;

      if (query.isNotEmpty) {
        final q = query.toLowerCase();
        final matchName = b.actionName.toLowerCase().contains(q);
        final matchCombo = b.activeCombo.toLowerCase().contains(q);
        if (!matchName && !matchCombo) return false;
      }

      return true;
    }).toList();
  }
}
