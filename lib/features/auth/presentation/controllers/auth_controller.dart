import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/core/di/use_case_providers.dart';
import 'package:pixelcanvas/core/domain/use_case.dart';
import 'package:pixelcanvas/features/auth/application/use_cases/get_current_user.dart';
import 'package:pixelcanvas/features/auth/application/use_cases/sign_in_as_guest.dart';
import 'package:pixelcanvas/features/auth/application/use_cases/sign_out.dart';
import 'package:pixelcanvas/features/auth/presentation/state/auth_state.dart';

/// Riverpod Controller managing Auth presentation state per Blueprint §6.3.
class AuthController extends StateNotifier<AuthState> {
  /// Creates an [AuthController].
  AuthController({
    required GetCurrentUser getCurrentUser,
    required SignInAsGuest signInAsGuest,
    required SignOut signOut,
  })  : _getCurrentUser = getCurrentUser,
        _signInAsGuest = signInAsGuest,
        _signOut = signOut,
        super(const AuthState());

  final GetCurrentUser _getCurrentUser;
  final SignInAsGuest _signInAsGuest;
  final SignOut _signOut;

  /// Loads current user session on startup.
  Future<void> loadCurrentUser() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _getCurrentUser(const NoParams());
    result.fold(
      (user) => state = state.copyWith(user: () => user, isLoading: false),
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: () => failure.message,
      ),
    );
  }

  /// Signs in as guest user.
  Future<void> signInAsGuest() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _signInAsGuest(const NoParams());
    result.fold(
      (user) => state = state.copyWith(user: () => user, isLoading: false),
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: () => failure.message,
      ),
    );
  }

  /// Signs out active user.
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, errorMessage: () => null);
    final result = await _signOut(const NoParams());
    result.fold(
      (_) => state = state.copyWith(user: () => null, isLoading: false),
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: () => failure.message,
      ),
    );
  }
}

/// Riverpod provider for [AuthController].
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    getCurrentUser: ref.watch(getCurrentUserProvider),
    signInAsGuest: ref.watch(signInAsGuestProvider),
    signOut: ref.watch(signOutProvider),
  );
});
