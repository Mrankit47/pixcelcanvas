/// Generic CRUD repository interface contract per Blueprint §8.1.
///
/// Purpose: Defines standard Data Access Object (DAO) operations for domain entities.
/// Responsibilities: Contract for fetching, saving, deleting, and querying entities.
/// Future Implementation Notes: Extended by domain-specific feature repository interfaces.
abstract class Repository<T, ID> {
  /// Fetches single entity by identifier.
  Future<T?> getById(ID id);

  /// Fetches all entities matching query or pagination bounds.
  Future<List<T>> getAll();

  /// Saves or updates entity.
  Future<T> save(T entity);

  /// Deletes entity by identifier.
  Future<void> delete(ID id);
}
