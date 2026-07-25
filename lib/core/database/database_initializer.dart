import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixelcanvas/core/database/collection_registry.dart';
import 'package:pixelcanvas/core/database/migration_manager.dart';

/// Initializes the local Isar database engine during app startup per Blueprint §5.2 & §11.2.
abstract final class DatabaseInitializer {
  /// Opens the Isar database instance.
  static Future<Isar> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    
    final isar = await Isar.open(
      CollectionRegistry.schemas,
      directory: dir.path,
      name: 'pixelcanvas_local_db',
    );

    await MigrationManager.performMigrations(isar);

    return isar;
  }
}
