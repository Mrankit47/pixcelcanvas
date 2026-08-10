import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/app.dart';
import 'package:pixelcanvas/core/di/provider_scope.dart';

void main() {
  testWidgets('App launches without crash', (tester) async {
    // Simulate actual bootstrap path
    await tester.pumpWidget(
      AppProviderScope(
        child: const PixelCanvasApp(),
      ),
    );
    
    // First frame renders without error
    await tester.pump();
    
    // Verify splash screen renders
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    
    // Verify no crash for 2 seconds of animation
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));
    
    debugPrint('APP LAUNCHED SUCCESSFULLY - No crash detected');
  });
}
