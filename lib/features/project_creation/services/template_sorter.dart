import 'package:pixelcanvas/features/project_creation/models/template_preset.dart';

/// Sort modes for templates.
enum TemplateSortMode {
  name,
  recentlyCreated,
  category,
  canvasSize,
}

/// Service sorting template lists.
class TemplateSorter {
  /// Sorts [templates] list according to [mode] and [ascending] direction.
  static List<TemplatePreset> sort(
    List<TemplatePreset> templates, {
    required TemplateSortMode mode,
    bool ascending = false,
  }) {
    final list = List<TemplatePreset>.from(templates);

    list.sort((a, b) {
      int result;
      switch (mode) {
        case TemplateSortMode.name:
          result = a.metadata.name.toLowerCase().compareTo(b.metadata.name.toLowerCase());
          break;
        case TemplateSortMode.recentlyCreated:
          result = a.metadata.createdDate.compareTo(b.metadata.createdDate);
          break;
        case TemplateSortMode.category:
          result = a.metadata.category.name.compareTo(b.metadata.category.name);
          break;
        case TemplateSortMode.canvasSize:
          result = (a.metadata.width * a.metadata.height)
              .compareTo(b.metadata.width * b.metadata.height);
          break;
      }
      return ascending ? result : -result;
    });

    return list;
  }
}
