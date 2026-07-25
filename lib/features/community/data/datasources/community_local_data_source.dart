import 'package:isar/isar.dart';
import 'package:pixelcanvas/core/database/database_service.dart';
import 'package:pixelcanvas/features/community/data/models/artwork_model.dart';

/// Contract for local community artwork database operations per Blueprint §6.2.
abstract interface class CommunityLocalDataSource {
  /// Gets all cached community artworks.
  Future<List<ArtworkModel>> getArtworks();

  /// Gets artwork by UUID.
  Future<ArtworkModel?> getArtworkByUuid(String uuid);

  /// Saves artwork model.
  Future<void> saveArtwork(ArtworkModel artwork);
}

/// Isar Implementation of [CommunityLocalDataSource].
class CommunityLocalDataSourceImpl implements CommunityLocalDataSource {
  /// Creates a [CommunityLocalDataSourceImpl].
  CommunityLocalDataSourceImpl(this._dbService);

  final DatabaseService _dbService;

  @override
  Future<List<ArtworkModel>> getArtworks() async {
    return _dbService.isar.artworkModels.where().findAll();
  }

  @override
  Future<ArtworkModel?> getArtworkByUuid(String uuid) async {
    return _dbService.isar.artworkModels.where().uuidEqualTo(uuid).findFirst();
  }

  @override
  Future<void> saveArtwork(ArtworkModel artwork) async {
    await _dbService.isar.writeTxn(() async {
      await _dbService.isar.artworkModels.put(artwork);
    });
  }
}
