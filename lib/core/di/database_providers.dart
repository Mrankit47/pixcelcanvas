import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/database/database_service.dart';

/// Database service provider throwing uninitialized error if not overridden in ProviderScope.
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  throw UnimplementedError('databaseServiceProvider must be overridden in ProviderScope root');
});
