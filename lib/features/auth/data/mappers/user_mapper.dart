import 'package:pixelcanvas/core/domain/value_objects/domain_values.dart';
import 'package:pixelcanvas/core/domain/value_objects/identifiers.dart';
import 'package:pixelcanvas/features/auth/data/models/user_model.dart';
import 'package:pixelcanvas/features/auth/domain/entities/user.dart';

/// Bidirectional Mapper between [User] Domain Entity and [UserModel] Isar Model per Blueprint §6.2.
abstract final class UserMapper {
  /// Converts [UserModel] to [User] domain entity.
  static User toDomain(UserModel model) => User(
        id: UserId(model.uuid),
        email: Email(model.email),
        displayName: DisplayName(model.displayName),
        username: Username(model.username),
        avatarUrl: model.avatarUrl,
        isGuest: model.isGuest,
        createdAt: model.createdAt,
      );

  /// Converts [User] domain entity to [UserModel].
  static UserModel fromDomain(User entity) => UserModel(
        uuid: entity.id.value,
        email: entity.email.value,
        displayName: entity.displayName.value,
        username: entity.username.value,
        avatarUrl: entity.avatarUrl,
        isGuest: entity.isGuest,
        createdAt: entity.createdAt,
      );
}
