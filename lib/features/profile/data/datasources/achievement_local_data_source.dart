import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/database_service.dart';
import 'package:pixelcanvas/features/profile/data/models/achievement_model.dart';

/// Contract for local achievement database operations per Blueprint §6.2.
abstract interface class AchievementLocalDataSource {
  /// Gets all user achievements.
  Future<List<AchievementModel>> getAchievements();

  /// Saves achievement model.
  Future<void> saveAchievement(AchievementModel achievement);
}

/// Isar Implementation of [AchievementLocalDataSource].
class AchievementLocalDataSourceImpl implements AchievementLocalDataSource {
  /// Creates an [AchievementLocalDataSourceImpl].
  AchievementLocalDataSourceImpl(this._dbService);

  final DatabaseService _dbService;

  @override
  Future<List<AchievementModel>> getAchievements() async {
    return _dbService.isar.achievementModels.where().findAll();
  }

  @override
  Future<void> saveAchievement(AchievementModel achievement) async {
    await _dbService.isar.writeTxn(() async {
      await _dbService.isar.achievementModels.put(achievement);
    });
  }
}
