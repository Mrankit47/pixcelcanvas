import 'package:flutter/widgets.dart';

/// Navigation redirect guard evaluating Splash screen completion per Blueprint §7.1.
abstract final class SplashGuard {
  /// Evaluates splash redirect decision.
  static String? evaluate(BuildContext context) => null;
}

/// Navigation redirect guard evaluating authentication state per Blueprint §7.1.
abstract final class AuthGuard {
  /// Evaluates auth redirect decision.
  static String? evaluate(BuildContext context) => null;
}

/// Navigation redirect guard evaluating onboarding completion per Blueprint §7.1.
abstract final class OnboardingGuard {
  /// Evaluates onboarding redirect decision.
  static String? evaluate(BuildContext context) => null;
}
