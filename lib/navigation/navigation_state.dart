/// Immutable navigation state data model representing current route and shell index per Blueprint §7.1.
class NavigationState {
  /// Creates a [NavigationState].
  const NavigationState({
    required this.currentPath,
    required this.shellIndex,
    this.currentRouteName,
  });

  /// Current active path.
  final String currentPath;

  /// Current active bottom navigation tab index (0 = Home, 1 = Templates, 2 = Community, 3 = Profile).
  final int shellIndex;

  /// Current active named route.
  final String? currentRouteName;

  @override
  String toString() =>
      'NavigationState(path: $currentPath, shellIndex: $shellIndex)';
}
