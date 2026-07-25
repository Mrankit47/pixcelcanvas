import 'package:equatable/equatable.dart';

/// Base abstract entity class for all domain entities per Blueprint §6.1 & §10.1.
///
/// **Purpose**: Provides identity-based equality for domain entities.
/// **Parameters**:
/// - [id]: Unique domain identifier of type [ID].
///
/// **Future Extension Notes**: Mapped to/from local Isar models and remote Supabase DTOs in Data Layer.
abstract class Entity<ID> extends Equatable {
  /// Creates an [Entity] with a unique identifier.
  const Entity(this.id);

  /// Unique domain identifier.
  final ID id;

  @override
  List<Object?> get props => [id];
}
