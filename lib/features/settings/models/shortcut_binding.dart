import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/settings/models/shortcut_category.dart';

/// Descriptor for a single key combination binding.
class ShortcutBinding extends Equatable {
  /// Creates a [ShortcutBinding].
  const ShortcutBinding({
    required this.actionId,
    required this.actionName,
    required this.category,
    required this.defaultKeyCombo,
    this.customKeyCombo,
  });

  final String actionId;
  final String actionName;
  final ShortcutCategory category;
  final String defaultKeyCombo;
  final String? customKeyCombo;

  /// Effective active key combination (`customKeyCombo` or fallback `defaultKeyCombo`).
  String get activeCombo => customKeyCombo ?? defaultKeyCombo;

  /// True if modified from default combo.
  bool get isRebound => customKeyCombo != null && customKeyCombo != defaultKeyCombo;

  ShortcutBinding copyWith({
    String? actionId,
    String? actionName,
    ShortcutCategory? category,
    String? defaultKeyCombo,
    String? customKeyCombo,
  }) =>
      ShortcutBinding(
        actionId: actionId ?? this.actionId,
        actionName: actionName ?? this.actionName,
        category: category ?? this.category,
        defaultKeyCombo: defaultKeyCombo ?? this.defaultKeyCombo,
        customKeyCombo: customKeyCombo ?? this.customKeyCombo,
      );

  Map<String, dynamic> toJson() => {
        'actionId': actionId,
        'actionName': actionName,
        'category': category.name,
        'defaultKeyCombo': defaultKeyCombo,
        'customKeyCombo': customKeyCombo,
      };

  factory ShortcutBinding.fromJson(Map<String, dynamic> json) => ShortcutBinding(
        actionId: json['actionId'] ?? '',
        actionName: json['actionName'] ?? '',
        category: ShortcutCategory.values.firstWhere(
          (c) => c.name == json['category'],
          orElse: () => ShortcutCategory.application,
        ),
        defaultKeyCombo: json['defaultKeyCombo'] ?? '',
        customKeyCombo: json['customKeyCombo'],
      );

  /// Default application shortcut bindings.
  static final List<ShortcutBinding> defaultBindings = [
    const ShortcutBinding(actionId: 'undo', actionName: 'Undo Edit', category: ShortcutCategory.drawing, defaultKeyCombo: 'Ctrl+Z'),
    const ShortcutBinding(actionId: 'redo', actionName: 'Redo Edit', category: ShortcutCategory.drawing, defaultKeyCombo: 'Ctrl+Y'),
    const ShortcutBinding(actionId: 'tool_brush', actionName: 'Select Brush Tool', category: ShortcutCategory.drawing, defaultKeyCombo: 'B'),
    const ShortcutBinding(actionId: 'tool_eraser', actionName: 'Select Eraser Tool', category: ShortcutCategory.drawing, defaultKeyCombo: 'E'),
    const ShortcutBinding(actionId: 'tool_fill', actionName: 'Select Bucket Fill', category: ShortcutCategory.drawing, defaultKeyCombo: 'G'),
    const ShortcutBinding(actionId: 'cmd_palette', actionName: 'Command Palette', category: ShortcutCategory.navigation, defaultKeyCombo: 'Ctrl+K'),
    const ShortcutBinding(actionId: 'save_proj', actionName: 'Save Project', category: ShortcutCategory.project, defaultKeyCombo: 'Ctrl+S'),
    const ShortcutBinding(actionId: 'new_proj', actionName: 'New Project', category: ShortcutCategory.project, defaultKeyCombo: 'Ctrl+N'),
    const ShortcutBinding(actionId: 'export_img', actionName: 'Export Image', category: ShortcutCategory.export, defaultKeyCombo: 'Ctrl+E'),
  ];

  @override
  List<Object?> get props => [
        actionId,
        actionName,
        category,
        defaultKeyCombo,
        customKeyCombo,
      ];
}
