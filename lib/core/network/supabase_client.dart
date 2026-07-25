/// Abstract wrapper for backend initialization.
///
/// Will wrap Supabase client instance in future phases per Blueprint §14.
abstract class SupabaseClientWrapper {
  /// Initializes backend connection.
  Future<void> initialize();
}
