import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixelcanvas/features/settings/models/shortcut_binding.dart';

/// Modal dialog capturing key combinations for custom shortcut rebinds.
class ShortcutRebindDialog extends StatefulWidget {
  /// Creates a [ShortcutRebindDialog].
  const ShortcutRebindDialog({
    super.key,
    required this.binding,
  });

  final ShortcutBinding binding;

  @override
  State<ShortcutRebindDialog> createState() => _ShortcutRebindDialogState();
}

class _ShortcutRebindDialogState extends State<ShortcutRebindDialog> {
  final FocusNode _focusNode = FocusNode();
  String _capturedCombo = '';

  @override
  void initState() {
    super.initState();
    _capturedCombo = widget.binding.activeCombo;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text('Rebind Shortcut — ${widget.binding.actionName}', style: const TextStyle(color: Colors.white, fontSize: 15)),
      content: Focus(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            final keyLabel = event.logicalKey.keyLabel.toUpperCase();
            final isCtrl = HardwareKeyboard.instance.isControlPressed;
            final isShift = HardwareKeyboard.instance.isShiftPressed;
            final isAlt = HardwareKeyboard.instance.isAltPressed;

            final parts = <String>[];
            if (isCtrl) parts.add('Ctrl');
            if (isShift) parts.add('Shift');
            if (isAlt) parts.add('Alt');
            if (keyLabel != 'CONTROL LEFT' && keyLabel != 'CONTROL RIGHT' && keyLabel != 'SHIFT LEFT' && keyLabel != 'SHIFT RIGHT') {
              parts.add(keyLabel);
            }

            if (parts.isNotEmpty) {
              setState(() => _capturedCombo = parts.join('+'));
            }
          }
          return KeyEventResult.handled;
        },
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF181825),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF6C5CE7)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Press desired key combination on your keyboard:', style: TextStyle(color: Colors.white60, fontSize: 12)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF313244),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _capturedCombo.isNotEmpty ? _capturedCombo : 'Press Key...',
                  style: const TextStyle(color: Color(0xFF89B4FA), fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel', style: TextStyle(color: Colors.white60)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
          onPressed: () => Navigator.of(context).pop(_capturedCombo),
          child: const Text('Save Rebind', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
