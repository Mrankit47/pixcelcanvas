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
  UserModel? _inMemoryUser;

  @override
  Future<UserModel?> getCurrentUser() async {
    final isar = _dbService.isar;
    if (isar != null) {
      return isar.collection<UserModel>().where().findFirst();
    }
    return _inMemoryUser;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final isar = _dbService.isar;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.collection<UserModel>().put(user);
      });
    } else {
      _inMemoryUser = user;
    }
  }

  @override
  Future<void> deleteUser(String uuid) async {
    final isar = _dbService.isar;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.collection<UserModel>().delete(fastHash(uuid));
      });
    } else {
      _inMemoryUser = null;
    }
  }
}
