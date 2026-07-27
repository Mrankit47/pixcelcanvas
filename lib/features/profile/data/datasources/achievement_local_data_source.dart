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
  final List<AchievementModel> _inMemoryAchievements = [];

  @override
  Future<List<AchievementModel>> getAchievements() async {
    final isar = _dbService.isar;
    if (isar != null) {
      return isar.collection<AchievementModel>().where().findAll();
    }
    return _inMemoryAchievements;
  }

  @override
  Future<void> saveAchievement(AchievementModel achievement) async {
    final isar = _dbService.isar;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.collection<AchievementModel>().put(achievement);
      });
    } else {
      _inMemoryAchievements.add(achievement);
    }
  }
}
