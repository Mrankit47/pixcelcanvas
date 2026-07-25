import 'package:pixelcanvas/core/domain/value_object.dart';

/// Strongly-typed unique identifier for Project entity.
final class ProjectId extends ValueObject<String> {
  /// Creates a [ProjectId].
  const ProjectId(super.value);
}

/// Strongly-typed unique identifier for User entity.
final class UserId extends ValueObject<String> {
  /// Creates a [UserId].
  const UserId(super.value);
}

/// Strongly-typed unique identifier for Layer entity.
final class LayerId extends ValueObject<String> {
  /// Creates a [LayerId].
  const LayerId(super.value);
}

/// Strongly-typed unique identifier for Canvas entity.
final class CanvasId extends ValueObject<String> {
  /// Creates a [CanvasId].
  const CanvasId(super.value);
}

/// Strongly-typed unique identifier for Template entity.
final class TemplateId extends ValueObject<String> {
  /// Creates a [TemplateId].
  const TemplateId(super.value);
}

/// Strongly-typed unique identifier for Artwork entity.
final class ArtworkId extends ValueObject<String> {
  /// Creates a [ArtworkId].
  const ArtworkId(super.value);
}
