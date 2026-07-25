import 'package:flutter/material.dart';

/// Controller managing canvas zoom and pan viewport transformation per Blueprint §8.1.
class CanvasViewportController extends ChangeNotifier {
  /// Creates a [CanvasViewportController].
  CanvasViewportController({
    double zoomLevel = 1.0,
    Offset panOffset = Offset.zero,
  })  : _zoomLevel = zoomLevel,
        _panOffset = panOffset;

  double _zoomLevel;
  Offset _panOffset;

  /// Current zoom level multiplier.
  double get zoomLevel => _zoomLevel;

  /// Current pan translation offset.
  Offset get panOffset => _panOffset;

  /// Updates zoom level multiplier.
  void setZoom(double newZoom) {
    _zoomLevel = newZoom.clamp(0.5, 8.0);
    notifyListeners();
  }

  /// Updates pan offset translation.
  void setPan(Offset newPan) {
    _panOffset = newPan;
    notifyListeners();
  }

  /// Reset viewport transformations.
  void reset() {
    _zoomLevel = 1.0;
    _panOffset = Offset.zero;
    notifyListeners();
  }
}
