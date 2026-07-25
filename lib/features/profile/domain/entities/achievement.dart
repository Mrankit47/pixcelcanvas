import 'package:pixelcanvas/core/domain/entity.dart';

/// Achievement Domain Entity per Blueprint §6.1.
class Achievement extends Entity<String> {
  /// Creates an [Achievement].
  const Achievement({
    required String id,
    required this.name,
    required this.description,
    this.isUnlocked = false,
    this.unlockedAt,
  }) : super(id);

  /// Achievement title.
  final String name;

  /// Description text.
  final String description;

  /// Unlocked status.
  final bool isUnlocked;

  /// Unlocked timestamp.
  final DateTime? unlockedAt;

  @override
  List<Object?> get props => [id, name, description, isUnlocked, unlockedAt];
}
