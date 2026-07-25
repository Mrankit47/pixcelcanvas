import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/database_service.dart';
import 'package:pixelcanvas/core/database/isar_id_generator.dart';
import 'package:pixelcanvas/features/auth/data/models/user_model.dart';

/// Contract for local user database operations per Blueprint §6.2.
abstract interface class UserLocalDataSource {
  /// Gets currently active user model or null.
  Future<UserModel?> getCurrentUser();

  /// Saves user model to Isar.
  Future<void> saveUser(UserModel user);

  /// Clears active user record from Isar.
  Future<void> deleteUser(String uuid);
}

/// Isar Implementation of [UserLocalDataSource].
class UserLocalDataSourceImpl implements UserLocalDataSource {
  /// Creates a [UserLocalDataSourceImpl].
  UserLocalDataSourceImpl(this._dbService);

  final DatabaseService _dbService;

  @override
  Future<UserModel?> getCurrentUser() async {
    return _dbService.isar.userModels.where().findFirst();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await _dbService.isar.writeTxn(() async {
      await _dbService.isar.userModels.put(user);
    });
  }

  @override
  Future<void> deleteUser(String uuid) async {
    await _dbService.isar.writeTxn(() async {
      await _dbService.isar.userModels.delete(fastHash(uuid));
    });
  }
}
