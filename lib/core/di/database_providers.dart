import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/database/database_service.dart';

/// Database service provider supplying a fallback DatabaseService instance when not overridden.
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService(null);
});
