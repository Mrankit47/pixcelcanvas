import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/project_creation/models/template_preset.dart';
import 'package:pixelcanvas/features/project_creation/services/template_search_engine.dart';
import 'package:pixelcanvas/features/project_creation/templates/built_in_templates.dart';

/// Central controller managing template CRUD operations per Blueprint §7.3.
class TemplateManager extends ChangeNotifier {
  final List<TemplatePreset> _templates = List.from(BuiltInTemplates.all);
  TemplateFilterOptions filterOptions = const TemplateFilterOptions();

  /// Displayed filtered and sorted templates list.
  List<TemplatePreset> get displayedTemplates =>
      TemplateSearchEngine.filterAndSort(_templates, filterOptions);

  /// All registered templates.
  List<TemplatePreset> get allTemplates => List.unmodifiable(_templates);

  /// Registers a custom user template.
  void registerTemplate(TemplatePreset template) {
    _templates.add(template);
    notifyListeners();
  }

  /// Duplicates template [id].
  TemplatePreset? duplicateTemplate(String id) {
    final idx = _templates.indexWhere((t) => t.metadata.id == id);
    if (idx >= 0) {
      final original = _templates[idx];
      final now = DateTime.now();
      final duplicate = TemplatePreset(
        metadata: original.metadata.copyWith(
          id: 'tmpl_user_${now.millisecondsSinceEpoch}',
          name: '${original.metadata.name} Copy',
          isBuiltIn: false,
          createdDate: now,
          modifiedDate: now,
        ),
        palette: original.palette,
        layerNames: original.layerNames,
        showGrid: original.showGrid,
        gridSize: original.gridSize,
        defaultZoom: original.defaultZoom,
        enableAnimation: original.enableAnimation,
        defaultFps: original.defaultFps,
        initialFrameCount: original.initialFrameCount,
      );
      _templates.add(duplicate);
      notifyListeners();
      return duplicate;
    }
    return null;
  }

  /// Deletes user template [id].
  bool deleteTemplate(String id) {
    final idx = _templates.indexWhere((t) => t.metadata.id == id);
    if (idx >= 0) {
      if (_templates[idx].metadata.isBuiltIn) return false; // Protected
      _templates.removeAt(idx);
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Updates filter options.
  void updateFilter(TemplateFilterOptions options) {
    filterOptions = options;
    notifyListeners();
  }
}
