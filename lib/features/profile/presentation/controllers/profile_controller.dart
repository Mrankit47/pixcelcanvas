import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/features/profile/presentation/state/profile_state.dart';

/// Riverpod Controller managing User Profile presentation state per Blueprint §6.3.
class ProfileController extends StateNotifier<ProfileState> {
  /// Creates a [ProfileController].
  ProfileController() : super(const ProfileState());

  /// Loads profile achievements.
  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    // Profile metrics loading setup.
    state = state.copyWith(isLoading: false);
  }
}

/// Riverpod provider for [ProfileController].
final profileControllerProvider = StateNotifierProvider<ProfileController, ProfileState>((ref) {
  return ProfileController();
});
