import 'package:pixelcanvas/core/errors/app_exception.dart';

/// Storage-related exception for local database, disk I/O, and secure storage failures.
///
/// Error domain: `PC-DAT-xxx` per Blueprint §34.
class StorageException extends AppException {
  /// Creates a [StorageException].
  const StorageException({
    required super.code,
    required super.userMessage,
    required super.devMessage,
    super.details,
    super.stackTrace,
  });

  /// Factory for database open failure (`PC-DAT-001`).
  factory StorageException.dbOpenFailed([Object? details]) => StorageException(
        code: 'PC-DAT-001',
        userMessage: 'Unable to open local database. Trying to recover…',
        devMessage: 'DB: Isar open failed',
        details: details,
      );

  /// Factory for read failure (`PC-DAT-002`).
  factory StorageException.readFailed([String? collection]) =>
      StorageException(
        code: 'PC-DAT-002',
        userMessage: 'Unable to load data from storage.',
        devMessage: 'DB: read failed on collection $collection',
      );

  /// Factory for write failure (`PC-DAT-003`).
  factory StorageException.writeFailed([String? collection]) =>
      StorageException(
        code: 'PC-DAT-003',
        userMessage: 'Unable to save changes to storage.',
        devMessage: 'DB: write failed on collection $collection',
      );
}
