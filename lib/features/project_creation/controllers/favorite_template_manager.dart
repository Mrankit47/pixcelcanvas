import 'package:flutter/material.dart';

/// Manager tracking favorited templates.
class FavoriteTemplateManager extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

  /// Set of favorited template IDs.
  Set<String> get favoriteIds => Set<String>.from(_favoriteIds);

  /// True if [templateId] is favorited.
  bool isFavorite(String templateId) => _favoriteIds.contains(templateId);

  /// Toggles favorite status for [templateId].
  void toggleFavorite(String templateId) {
    if (_favoriteIds.contains(templateId)) {
      _favoriteIds.remove(templateId);
    } else {
      _favoriteIds.add(templateId);
    }
    notifyListeners();
  }
}
