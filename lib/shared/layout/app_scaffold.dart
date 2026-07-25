import 'package:flutter/material.dart';

/// Base app scaffold wrapper template.
///
/// Will incorporate bottom navigation bar and floating action button per Blueprint §7.1 in future phases.
class AppScaffold extends StatelessWidget {
  /// Creates an [AppScaffold] template.
  const AppScaffold({
    required this.body,
    super.key,
  });

  /// Main screen body.
  final Widget body;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: body,
      );
}
