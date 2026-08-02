/// Local Data Model for Layer Entity.
class LayerModel {
  /// Creates a [LayerModel].
  LayerModel({
    this.uuid = '',
    this.name = 'Layer 1',
    this.isVisible = true,
    this.isLocked = false,
    this.opacity = 1.0,
    this.index = 0,
  });

  /// Layer unique UUID.
  String uuid;

  /// Layer name string.
  String name;

  /// Visibility toggle.
  bool isVisible;

  /// Lock toggle.
  bool isLocked;

  /// Opacity value.
  double opacity;

  /// Layer stack index.
  int index;
}
