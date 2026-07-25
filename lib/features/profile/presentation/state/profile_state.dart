import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/profile/domain/entities/achievement.dart';

/// Immutable State object for User Profile per Blueprint §6.3.
class ProfileState extends Equatable {
  /// Creates a [ProfileState].
  const ProfileState({
    this.achievements = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  /// Achievements list.
  final List<Achievement> achievements;

  /// Loading status flag.
  final bool isLoading;

  /// Error message string or null.
  final String? errorMessage;

  /// Copy with support.
  ProfileState copyWith({
    List<Achievement>? achievements,
    bool? isLoading,
    String? Function()? errorMessage,
  }) =>
      ProfileState(
        achievements: achievements ?? this.achievements,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      );

  @override
  List<Object?> get props => [achievements, isLoading, errorMessage];
}
