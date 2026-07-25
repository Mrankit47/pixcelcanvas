import 'package:flutter/animation.dart';

/// Centralized animation duration and curve tokens for PixelCanvas.
///
/// Derived directly from Blueprint §31.6.
abstract final class AppDurations {
  /// Micro-feedback (tap highlight, toggle) — 100ms.
  static const Duration instant = Duration(milliseconds: 100);

  /// Tooltips, chips, quick transitions — 150ms.
  static const Duration fast = Duration(milliseconds: 150);

  /// Page transitions, bottom sheets, dialogs — 250ms.
  static const Duration normal = Duration(milliseconds: 250);

  /// Complex transitions, onboarding animations — 350ms.
  static const Duration slow = Duration(milliseconds: 350);

  /// Large-area animations, splash — 500ms.
  static const Duration slower = Duration(milliseconds: 500);

  /// Splash logo, celebration animations — 1000ms.
  static const Duration slowest = Duration(milliseconds: 1000);
}

/// Centralized animation curve tokens for PixelCanvas.
///
/// Derived directly from Blueprint §31.6.
abstract final class AppCurves {
  /// General-purpose transitions.
  static const Curve standard = Curves.easeInOutCubic;

  /// Elements entering the screen.
  static const Curve enter = Curves.easeOutCubic;

  /// Elements leaving the screen.
  static const Curve exit = Curves.easeInCubic;

  /// Attention-drawing animations (FAB, success feedback).
  static const Curve emphasize = Curves.easeOutBack;

  /// Linear progress bars and loaders.
  static const Curve linear = Curves.linear;

  /// Playful feedback (like button, confetti).
  static const Curve spring = Curves.elasticOut;
}
