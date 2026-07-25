import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/settings/domain/entities/settings.dart';

/// Immutable State object for App Settings per Blueprint §6.3.
class SettingsState extends Equatable {
  /// Creates a [SettingsState].
  const SettingsState({
    this.settings = const Settings(),
    this.isLoading = false,
    this.errorMessage,
  });

  /// App settings entity.
  final Settings settings;

  /// Loading status flag.
  final bool isLoading;

  /// Error message string or null.
  final String? errorMessage;

  /// Copy with support.
  SettingsState copyWith({
    Settings? settings,
    bool? isLoading,
    String? Function()? errorMessage,
  }) =>
      SettingsState(
        settings: settings ?? this.settings,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      );

  @override
  List<Object?> get props => [settings, isLoading, errorMessage];
}
