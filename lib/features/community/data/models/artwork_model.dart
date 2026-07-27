import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/isar_id_generator.dart';


/// Isar Local NoSQL Collection for Artwork Entity per Blueprint §6.2.
@collection
class ArtworkModel {
  /// Creates an [ArtworkModel].
  ArtworkModel({
    this.uuid = '',
    this.authorId = '',
    this.authorName = '',
    this.title = '',  
    this.likesCount = 0,
    this.viewsCount = 0,
    this.isLiked = false,
    this.tags = const [],
  });

  /// Isar primary key.
  Id get id => fastHash(uuid);

  /// Unique UUID index.
  @Index(unique: true, replace: true)
  String uuid;

  /// Author user ID index.
  @Index()
  String authorId;

  /// Author name.
  String authorName;

  /// Artwork title.
  String title;

  /// Likes count.
  int likesCount;

  /// Views count.
  int viewsCount;

  /// Is liked flag.
  bool isLiked;

  /// Hashtags list.
  List<String> tags;
}
