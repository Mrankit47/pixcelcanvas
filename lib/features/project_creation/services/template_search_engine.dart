import 'package:pixelcanvas/features/project_creation/models/template_category.dart';
import 'package:pixelcanvas/features/project_creation/models/template_preset.dart';
import 'package:pixelcanvas/features/project_creation/services/template_sorter.dart';

/// Multi-criteria template filter options.
class TemplateFilterOptions {
  const TemplateFilterOptions({
    this.searchQuery = '',
    this.selectedCategory,
    this.onlyFavorites = false,
    this.onlyAnimated = false,
    this.sortMode = TemplateSortMode.name,
  });

  final String searchQuery;
  final TemplateCategory? selectedCategory;
  final bool onlyFavorites;
  final bool onlyAnimated;
  final TemplateSortMode sortMode;

  TemplateFilterOptions copyWith({
    String? searchQuery,
    TemplateCategory? selectedCategory,
    bool? onlyFavorites,
    bool? onlyAnimated,
    TemplateSortMode? sortMode,
  }) =>
      TemplateFilterOptions(
        searchQuery: searchQuery ?? this.searchQuery,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        onlyFavorites: onlyFavorites ?? this.onlyFavorites,
        onlyAnimated: onlyAnimated ?? this.onlyAnimated,
        sortMode: sortMode ?? this.sortMode,
      );
}

/// Search engine filtering template lists.
class TemplateSearchEngine {
  /// Filters and sorts [templates] based on [options].
  static List<TemplatePreset> filterAndSort(
    List<TemplatePreset> templates,
    TemplateFilterOptions options,
  ) {
    var result = templates.where((t) {
      final meta = t.metadata;

      // 1. Category Filter
      if (options.selectedCategory != null && meta.category != options.selectedCategory) {
        return false;
      }

      // 2. Favorites Filter
      if (options.onlyFavorites && !meta.isFavorite) {
        return false;
      }

      // 3. Animated Filter
      if (options.onlyAnimated && !meta.hasAnimation) {
        return false;
      }

      // 4. Search Query
      if (options.searchQuery.isNotEmpty) {
        final q = options.searchQuery.toLowerCase();
        final matchName = meta.name.toLowerCase().contains(q);
        final matchDesc = meta.description.toLowerCase().contains(q);
        final matchRes = meta.resolutionString.contains(q);
        final matchTags = meta.tags.any((tag) => tag.toLowerCase().contains(q));
        if (!matchName && !matchDesc && !matchRes && !matchTags) return false;
      }

      return true;
    }).toList();

    return TemplateSorter.sort(result, mode: options.sortMode);
  }
}
