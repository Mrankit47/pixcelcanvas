/// Abstract contract for Last-Write-Wins (LWW) conflict resolution.
///
/// Compares local and remote modification timestamps per Blueprint §11.6.
abstract class ConflictResolver {
  /// Resolves conflict between local entity and remote entity.
  ///
  /// Returns the winning version (latest `updatedAt`).
  Map<String, dynamic> resolveLww({
    required Map<String, dynamic> localEntity,
    required Map<String, dynamic> remoteEntity,
  });
}
