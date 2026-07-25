import 'package:pixelcanvas/features/profile/data/models/achievement_model.dart';
import 'package:pixelcanvas/features/profile/domain/entities/achievement.dart';

/// Bidirectional Mapper between [Achievement] domain entity and [AchievementModel] Isar collection.
abstract final class AchievementMapper {
  /// Converts [AchievementModel] to [Achievement] domain entity.
  static Achievement toDomain(AchievementModel model) => Achievement(
        id: model.uuid,
        name: model.name,
        description: model.description,
        isUnlocked: model.isUnlocked,
        unlockedAt: model.unlockedAt,
      );

  /// Converts [Achievement] domain entity to [AchievementModel].
  static AchievementModel fromDomain(Achievement entity) => AchievementModel(
        uuid: entity.id,
        name: entity.name,
        description: entity.description,
        isUnlocked: entity.isUnlocked,
        unlockedAt: entity.unlockedAt,
      );
}
