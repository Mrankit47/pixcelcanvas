import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/app.dart';

void main() {
  testWidgets('PixelCanvasApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PixelCanvasApp());
    expect(find.byType(PixelCanvasApp), findsOneWidget);
  });
}
