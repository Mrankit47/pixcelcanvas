import 'package:pixelcanvas/core/repositories/sync_repository.dart';

/// Profile repository interface contract per Blueprint §6.2.
///
/// Purpose: Manages user profile metadata, statistics, and preferences.
/// Responsibilities: Profile persistence, avatar upload, and stats calculation.
/// Future Implementation Notes: Concrete implementation `ProfileRepositoryImpl` in `features/profile/data/`.
abstract class ProfileRepository implements SyncRepository<Map<String, dynamic>, String> {
  /// Fetches profile for user ID.
  Future<Map<String, dynamic>?> getProfile(String userId);

  /// Updates profile metadata.
  Future<void> updateProfile(Map<String, dynamic> profileData);
}
