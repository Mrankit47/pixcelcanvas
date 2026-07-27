import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/isar_id_generator.dart';


/// Isar Local NoSQL Collection for Achievement Entity per Blueprint §6.2.
@collection
class AchievementModel {
  /// Creates an [AchievementModel].
  AchievementModel({
    this.uuid = '',
    this.name = '',
    this.description = '',
    this.isUnlocked = false,
    this.unlockedAt,
  });

  /// Isar primary key.
  Id get id => fastHash(uuid);

  /// Unique UUID index.
  @Index(unique: true, replace: true)
  String uuid;

  /// Achievement title.
  String name;

  /// Description text.
  String description;

  /// Unlocked status flag.
  bool isUnlocked;

  /// Unlocked date.
  DateTime? unlockedAt;
}
