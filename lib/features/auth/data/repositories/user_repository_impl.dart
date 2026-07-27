import 'package:pixelcanvas/core/domain/failure.dart';
import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/value_objects/domain_values.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/auth/data/datasources/user_local_data_source.dart';
import 'package:pixelcanvas/features/auth/data/mappers/user_mapper.dart';
import 'package:pixelcanvas/features/auth/data/models/user_model.dart';
import 'package:pixelcanvas/features/auth/domain/entities/user.dart';
import 'package:pixelcanvas/features/auth/domain/repositories/user_repository.dart';

/// Implementation of [UserRepository] domain contract per Blueprint §6.2 & §14.1.
///
/// **Purpose**: Manages authentication and user session persistence.
/// **Dependencies**: [UserLocalDataSource]
/// **Future Extensions**: Will incorporate Supabase Auth remote data source in Phase 3 Step 4.
class UserRepositoryImpl implements UserRepository {
  /// Creates a [UserRepositoryImpl].
  UserRepositoryImpl(this._localDataSource);

  final UserLocalDataSource _localDataSource;

  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      final model = await _localDataSource.getCurrentUser();
      if (model == null) return const Success(null);
      return Success(UserMapper.toDomain(model));
    } catch (e, stackTrace) {
      return FailureResult(StorageFailure('Failed to load user from database', e));
    }
  }

  @override
  Future<Result<User>> signInWithEmail(String email, String password) async {
    try {
      final user = User(
        id: const UserId('user_email_1'),
        email: Email(email),
        displayName: const DisplayName('Pixel Artist'),
        username: const Username('@pixelartist'),
        isGuest: false,
        createdAt: DateTime.now(),
      );
      await _localDataSource.saveUser(UserMapper.fromDomain(user));
      return Success(user);
    } catch (e) {
      return FailureResult(StorageFailure('Email sign in local save failed', e));
    }
  }

  @override
  Future<Result<User>> signInWithOAuth(String provider) async {
    try {
      final user = User(
        id: UserId('user_oauth_${provider.toLowerCase()}'),
        email: Email('oauth_$provider@pixelcanvas.app'),
        displayName: DisplayName('$provider Creator'),
        username: Username('@${provider.toLowerCase()}_creator'),
        isGuest: false,
        createdAt: DateTime.now(),
      );
      await _localDataSource.saveUser(UserMapper.fromDomain(user));
      return Success(user);
    } catch (e) {
      return FailureResult(StorageFailure('OAuth sign in local save failed', e));
    }
  }

  @override
  Future<Result<User>> signInAsGuest() async {
    try {
      final guestUser = User(
        id: const UserId('guest_user_local'),
        email: const Email('guest@pixelcanvas.app'),
        displayName: const DisplayName('Guest Creator'),
        username: const Username('@guest'),
        isGuest: true,
        createdAt: DateTime.now(),
      );
      await _localDataSource.saveUser(UserMapper.fromDomain(guestUser));
      return Success(guestUser);
    } catch (e) {
      return FailureResult(StorageFailure('Guest mode save failed', e));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      final current = await _localDataSource.getCurrentUser();
      if (current != null) {
        await _localDataSource.deleteUser(current.uuid);
      }
      return const Success(null);
    } catch (e) {
      return FailureResult(StorageFailure('Sign out delete failed', e));
    }
  }
}
