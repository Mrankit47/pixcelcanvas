import 'package:pixelcanvas/core/domain/result.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/auth/domain/entities/user.dart';

/// Contract interface for User authentication and profile data access per Blueprint §6.1 & §14.1.
abstract interface class UserRepository {
  /// Gets currently active user or null if unauthenticated.
  Future<Result<User?>> getCurrentUser();

  /// Authenticates user with email and password.
  Future<Result<User>> signInWithEmail(String email, String password);

  /// Authenticates user with OAuth provider (Google / GitHub).
  Future<Result<User>> signInWithOAuth(String provider);

  /// Initializes guest mode session.
  Future<Result<User>> signInAsGuest();

  /// Signs out active user.
  Future<Result<void>> signOut();
}
