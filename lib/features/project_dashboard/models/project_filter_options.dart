/// Sorting options for project listings.
enum ProjectSortMode {
  name,
  modifiedDate,
  createdDate,
  canvasSize,
  lastOpened,
}

/// Filter categories for project listings.
enum ProjectFilterCategory {
  all,
  favorites,
  archived,
  templates,
}

/// Filter and sort configuration settings.
class ProjectFilterOptions {
  /// Creates a [ProjectFilterOptions].
  const ProjectFilterOptions({
    this.sortMode = ProjectSortMode.lastOpened,
    this.category = ProjectFilterCategory.all,
    this.ascending = false,
    this.searchQuery = '',
    this.selectedTag,
  });

  final ProjectSortMode sortMode;
  final ProjectFilterCategory category;
  final bool ascending;
  final String searchQuery;
  final String? selectedTag;

  /// Creates a copy of [ProjectFilterOptions] with updated fields.
  ProjectFilterOptions copyWith({
    ProjectSortMode? sortMode,
    ProjectFilterCategory? category,
    bool? ascending,
    String? searchQuery,
    String? selectedTag,
  }) =>
      ProjectFilterOptions(
        sortMode: sortMode ?? this.sortMode,
        category: category ?? this.category,
        ascending: ascending ?? this.ascending,
        searchQuery: searchQuery ?? this.searchQuery,
        selectedTag: selectedTag ?? this.selectedTag,
      );
}
