import 'package:pixelcanvas/core/domain/entity.dart';
import 'package:pixelcanvas/core/domain/value_objects/domain_values.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';

/// User Domain Entity per Blueprint §6.1 & §14.1.
///
/// **Purpose**: Core entity representing authenticated or guest user.
/// **Responsibilities**: Holds user identity, email, display name, handle, and guest flag.
/// **Future Persistence Notes**: Mapped to Supabase Auth `User` and Isar `UserModel`.
class User extends Entity<UserId> {
  /// Creates a [User] domain entity.
  const User({
    required UserId id,
    required this.email,
    required this.displayName,
    required this.username,
    this.avatarUrl,
    this.isGuest = false,
    this.createdAt,
  }) : super(id);

  /// User email.
  final Email email;

  /// User display name.
  final DisplayName displayName;

  /// User handle.
  final Username username;

  /// Optional avatar URL.
  final String? avatarUrl;

  /// True if user is in guest mode.
  final bool isGuest;

  /// Account creation timestamp.
  final DateTime? createdAt;

  @override
  List<Object?> get props => [id, email, displayName, username, avatarUrl, isGuest, createdAt];
}
