import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/community/domain/entities/artwork.dart';

/// Immutable State object for Community Gallery per Blueprint §6.3.
class CommunityState extends Equatable {
  /// Creates a [CommunityState].
  const CommunityState({
    this.artworks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  /// Artworks feed list.
  final List<Artwork> artworks;

  /// Loading status flag.
  final bool isLoading;

  /// Error message string or null.
  final String? errorMessage;

  /// Copy with support.
  CommunityState copyWith({
    List<Artwork>? artworks,
    bool? isLoading,
    String? Function()? errorMessage,
  }) =>
      CommunityState(
        artworks: artworks ?? this.artworks,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      );

  @override
  List<Object?> get props => [artworks, isLoading, errorMessage];
}
