import 'package:flutter/material.dart';

/// Responsive layout builder evaluating screen breakpoints per Blueprint §8.1.
class ResponsiveBuilder extends StatelessWidget {
  /// Creates a [ResponsiveBuilder] template.
  const ResponsiveBuilder({
    required this.mobile,
    super.key,
    this.tablet,
    this.desktop,
  });

  /// Mobile layout widget.
  final Widget mobile;

  /// Optional tablet layout widget.
  final Widget? tablet;

  /// Optional desktop layout widget.
  final Widget? desktop;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1100 && desktop != null) {
            return desktop!;
          } else if (constraints.maxWidth >= 650 && tablet != null) {
            return tablet!;
          }
          return mobile;
        },
      );
}
