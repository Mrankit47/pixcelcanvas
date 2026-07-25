import 'package:flutter/material.dart';

/// Fade-in animation wrapper template per Blueprint §8.1.
class FadeIn extends StatelessWidget {
  /// Creates a [FadeIn] template.
  const FadeIn({
    required this.child,
    super.key,
  });

  /// Child widget to animate.
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
