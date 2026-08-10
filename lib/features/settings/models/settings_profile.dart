import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/settings/models/appearance_settings.dart';
import 'package:pixelcanvas/features/settings/models/autosave_settings.dart';
import 'package:pixelcanvas/features/settings/models/editor_settings.dart';
import 'package:pixelcanvas/features/settings/models/general_settings.dart';
import 'package:pixelcanvas/features/settings/models/performance_settings.dart';
import 'package:pixelcanvas/features/settings/models/shortcut_binding.dart';

/// Container grouping configuration settings and shortcut bindings.
class SettingsProfile extends Equatable {
  /// Creates a [SettingsProfile].
  const SettingsProfile({
    required this.id,
    required this.name,
    this.general = const GeneralSettings(),
    this.appearance = const AppearanceSettings(),
    this.editor = const EditorSettings(),
    this.performance = const PerformanceSettings(),
    this.autosave = const AutosaveSettings(),
    this.shortcuts = const [],
  });

  final String id;
  final String name;
  final GeneralSettings general;
  final AppearanceSettings appearance;
  final EditorSettings editor;
  final PerformanceSettings performance;
  final AutosaveSettings autosave;
  final List<ShortcutBinding> shortcuts;

  SettingsProfile copyWith({
    String? id,
    String? name,
    GeneralSettings? general,
    AppearanceSettings? appearance,
    EditorSettings? editor,
    PerformanceSettings? performance,
    AutosaveSettings? autosave,
    List<ShortcutBinding>? shortcuts,
  }) =>
      SettingsProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        general: general ?? this.general,
        appearance: appearance ?? this.appearance,
        editor: editor ?? this.editor,
        performance: performance ?? this.performance,
        autosave: autosave ?? this.autosave,
        shortcuts: shortcuts ?? this.shortcuts,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'general': general.toJson(),
        'appearance': appearance.toJson(),
        'editor': editor.toJson(),
        'performance': performance.toJson(),
        'autosave': autosave.toJson(),
        'shortcuts': shortcuts.map((s) => s.toJson()).toList(),
      };

  factory SettingsProfile.fromJson(Map<String, dynamic> json) => SettingsProfile(
        id: (json['id'] as String?) ?? 'default',
        name: (json['name'] as String?) ?? 'Default Profile',
        general: json.containsKey('general') && json['general'] is Map<String, dynamic>
            ? GeneralSettings.fromJson(json['general'] as Map<String, dynamic>)
            : const GeneralSettings(),
        appearance: json.containsKey('appearance') && json['appearance'] is Map<String, dynamic>
            ? AppearanceSettings.fromJson(json['appearance'] as Map<String, dynamic>)
            : const AppearanceSettings(),
        editor: json.containsKey('editor') && json['editor'] is Map<String, dynamic>
            ? EditorSettings.fromJson(json['editor'] as Map<String, dynamic>)
            : const EditorSettings(),
        performance: json.containsKey('performance') && json['performance'] is Map<String, dynamic>
            ? PerformanceSettings.fromJson(json['performance'] as Map<String, dynamic>)
            : const PerformanceSettings(),
        autosave: json.containsKey('autosave') && json['autosave'] is Map<String, dynamic>
            ? AutosaveSettings.fromJson(json['autosave'] as Map<String, dynamic>)
            : const AutosaveSettings(),
        shortcuts: json.containsKey('shortcuts') && json['shortcuts'] is List
            ? (json['shortcuts'] as List).map((s) => ShortcutBinding.fromJson(s as Map<String, dynamic>)).toList()
            : ShortcutBinding.defaultBindings,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        general,
        appearance,
        editor,
        performance,
        autosave,
        shortcuts,
      ];
}
