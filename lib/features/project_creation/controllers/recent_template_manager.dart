import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/project_creation/models/template_preset.dart';

/// Manager maintaining recently used template history.
class RecentTemplateManager extends ChangeNotifier {
  final List<TemplatePreset> _recents = [];

  /// Unmodifiable list of recently used templates.
  List<TemplatePreset> get recents => List<TemplatePreset>.from(_recents);

  /// Registers template as recently used.
  void useTemplate(TemplatePreset template) {
    _recents.removeWhere((t) => t.metadata.id == template.metadata.id);
    _recents.insert(0, template);
    if (_recents.length > 10) {
      _recents.removeLast();
    }
    notifyListeners();
  }
}
