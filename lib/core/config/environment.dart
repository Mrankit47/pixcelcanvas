/// Environment enum for PixelCanvas runtime configurations.
///
/// Supports multi-stage deployment (development, staging, production).
enum Environment {
  /// Local development environment.
  dev,

  /// Staging and internal testing environment.
  staging,

  /// Live production environment.
  prod,
}
