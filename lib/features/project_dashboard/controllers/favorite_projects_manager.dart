import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_metadata.dart';

/// Manager coordinating favorited and pinned project listings.
class FavoriteProjectsManager extends ChangeNotifier {
  final List<ProjectMetadata> _favorites = [];

  /// Favorites list getter.
  List<ProjectMetadata> get favorites => List<ProjectMetadata>.from(_favorites);

  /// Toggles favorite status of [project].
  void toggleFavorite(ProjectMetadata project) {
    final idx = _favorites.indexWhere((p) => p.id == project.id);
    if (idx >= 0) {
      _favorites.removeAt(idx);
    } else {
      _favorites.insert(0, project.copyWith(isFavorite: true));
    }
    notifyListeners();
  }

  /// Toggles pinned status of [project].
  void togglePin(ProjectMetadata project) {
    final idx = _favorites.indexWhere((p) => p.id == project.id);
    if (idx >= 0) {
      _favorites[idx] = _favorites[idx].copyWith(isPinned: !_favorites[idx].isPinned);
      notifyListeners();
    }
  }
}
