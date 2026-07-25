import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/isar_id_generator.dart';

part 'user_model.g.dart';

/// Isar Local NoSQL Collection for User Entity per Blueprint §6.2 & §11.2.
///
/// **Purpose**: Persists authenticated or guest user account details locally.
/// **Mapped Entity**: [User]
/// **Migration Considerations**: Schema v1 initial collection.
@collection
class UserModel {
  /// Creates a [UserModel].
  UserModel({
    this.uuid = '',
    this.email = '',
    this.displayName = '',
    this.username = '',
    this.avatarUrl,
    this.isGuest = false,
    this.createdAt,
  });

  /// Isar primary key derived deterministically from UUID string.
  Id get id => fastHash(uuid);

  /// Unique UUID string index.
  @Index(unique: true, replace: true)
  String uuid;

  /// User email address.
  String email;

  /// Display name.
  String displayName;

  /// User handle.
  String username;

  /// Optional avatar URL.
  String? avatarUrl;

  /// Guest mode flag.
  bool isGuest;

  /// Account creation date.
  DateTime? createdAt;
}
