import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/auth/domain/entities/user.dart';

/// Immutable State object for Auth feature per Blueprint §6.3.
class AuthState extends Equatable {
  /// Creates an [AuthState].
  const AuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  /// Active user entity or null.
  final User? user;

  /// Loading status flag.
  final bool isLoading;

  /// Error message string or null.
  final String? errorMessage;

  /// True if user is authenticated or in guest mode.
  bool get isAuthenticated => user != null;

  /// Copy with support.
  AuthState copyWith({
    User? Function()? user,
    bool? isLoading,
    String? Function()? errorMessage,
  }) =>
      AuthState(
        user: user != null ? user() : this.user,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      );

  @override
  List<Object?> get props => [user, isLoading, errorMessage];
}
