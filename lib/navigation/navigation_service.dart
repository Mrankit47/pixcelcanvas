import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/navigation/app_router.dart';

/// Global navigation wrapper exposing declarative navigation methods per Blueprint §7.1.
///
/// Wraps [GoRouter] actions (`go`, `push`, `replace`, `pop`) without business logic.
abstract final class NavigationService {
  /// Navigates to a target location (replaces location stack).
  static void go(BuildContext context, String location, {Object? extra}) {
    context.go(location, extra: extra);
  }

  /// Pushes a new target route onto the navigator stack.
  static void push(BuildContext context, String location, {Object? extra}) {
    context.push(location, extra: extra);
  }

  /// Replaces current route with target location.
  static void replace(BuildContext context, String location, {Object? extra}) {
    context.replace(location, extra: extra);
  }

  /// Pops the top route from the navigator stack.
  static void pop(BuildContext context, [Object? result]) {
    if (context.canPop()) {
      context.pop(result);
    }
  }
}
