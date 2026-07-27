import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/settings/controllers/keyboard_shortcut_manager.dart';
import 'package:pixelcanvas/features/settings/models/shortcut_binding.dart';
import 'package:pixelcanvas/features/settings/models/shortcut_category.dart';
import 'package:pixelcanvas/features/settings/presentation/widgets/shortcut_rebind_dialog.dart';
import 'package:pixelcanvas/features/settings/services/shortcut_search_engine.dart';

/// Keyboard shortcuts editor view layout.
class KeyboardShortcutsView extends StatefulWidget {
  /// Creates a [KeyboardShortcutsView].
  const KeyboardShortcutsView({
    super.key,
    required this.shortcutManager,
  });

  final KeyboardShortcutManager shortcutManager;

  @override
  State<KeyboardShortcutsView> createState() => _KeyboardShortcutsViewState();
}

class _KeyboardShortcutsViewState extends State<KeyboardShortcutsView> {
  String _query = '';
  ShortcutCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    widget.shortcutManager.addListener(_onChanged);
  }

  @override
  void dispose() {
    widget.shortcutManager.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filtered = ShortcutSearchEngine.filter(
      widget.shortcutManager.bindings,
      query: _query,
      category: _selectedCategory,
    );

    return Column(
      children: [
        // Search & Filter Header
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            style: const TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search shortcuts by action name or key combo...',
              hintStyle: const TextStyle(color: Colors.white38),
              prefixIcon: const Icon(Icons.search_rounded, color: Colors.white38, size: 18),
              filled: true,
              fillColor: const Color(0xFF181825),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
            ),
            onChanged: (val) => setState(() => _query = val),
          ),
        ),

        // Conflicts Warning Bar
        if (widget.shortcutManager.hasConflicts)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFFE74C3C),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  '${widget.shortcutManager.conflicts.length} shortcut key conflict(s) detected!',
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

        // Shortcuts List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            separatorBuilder: (context, index) => const Divider(color: Color(0xFF2A2A3D)),
            itemBuilder: (context, index) {
              final item = filtered[index];
              return ListTile(
                dense: true,
                title: Text(item.actionName, style: const TextStyle(color: Colors.white, fontSize: 13)),
                subtitle: Text(item.category.name, style: const TextStyle(color: Colors.white38, fontSize: 10)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => _rebind(item),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: item.isRebound ? const Color(0xFF6C5CE7) : const Color(0xFF313244),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.activeCombo,
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    if (item.isRebound)
                      IconButton(
                        icon: const Icon(Icons.refresh_rounded, size: 14, color: Colors.white38),
                        tooltip: 'Reset to Default',
                        onPressed: () => widget.shortcutManager.resetToDefault(item.actionId),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _rebind(ShortcutBinding item) async {
    final newCombo = await showDialog<String>(
      context: context,
      builder: (context) => ShortcutRebindDialog(binding: item),
    );

    if (newCombo != null && newCombo.isNotEmpty) {
      widget.shortcutManager.rebindShortcut(item.actionId, newCombo);
    }
  }
}
