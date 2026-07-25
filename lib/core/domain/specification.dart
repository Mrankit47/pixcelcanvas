/// Base specification interface for domain entity filtering per Blueprint §6.1.
///
/// **Purpose**: Defines business criteria specification pattern for queries.
abstract interface class Specification<T> {
  /// Evaluates whether entity [candidate] satisfies specification.
  bool isSatisfiedBy(T candidate);
}
