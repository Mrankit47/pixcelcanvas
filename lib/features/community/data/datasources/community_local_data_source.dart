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
  final List<ArtworkModel> _inMemoryArtworks = [];

  @override
  Future<List<ArtworkModel>> getArtworks() async {
    final isar = _dbService.isar;
    if (isar != null) {
      return isar.collection<ArtworkModel>().where().findAll();
    }
    return _inMemoryArtworks;
  }

  @override
  Future<ArtworkModel?> getArtworkByUuid(String uuid) async {
    final list = await getArtworks();
    try {
      return list.firstWhere((a) => a.uuid == uuid);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveArtwork(ArtworkModel artwork) async {
    final isar = _dbService.isar;
    if (isar != null) {
      await isar.writeTxn(() async {
        await isar.collection<ArtworkModel>().put(artwork);
      });
    } else {
      _inMemoryArtworks.removeWhere((a) => a.uuid == artwork.uuid);
      _inMemoryArtworks.add(artwork);
    }
  }
}
