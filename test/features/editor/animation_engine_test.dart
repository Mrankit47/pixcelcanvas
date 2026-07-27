import 'package:flutter_test/flutter_test.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/loop_mode.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';

void main() {
  group('AnimationEngine Tests', () {
    test('Create, rename, and duplicate animation clip', () {
      final engine = CanvasEngine(width: 32, height: 32);
      engine.createAnimation('Walk');

      expect(engine.animationEngine.timeline.clips.length, equals(2));
      expect(engine.activeAnimationClip?.name, equals('Walk'));

      engine.renameAnimation(engine.activeAnimationClip!.id, 'Run');
      expect(engine.activeAnimationClip?.name, equals('Run'));

      engine.duplicateAnimation(engine.activeAnimationClip!.id);
      expect(engine.animationEngine.timeline.clips.length, equals(3));
    });

    test('Playback play, pause, stop, and seek controls', () {
      final engine = CanvasEngine(width: 32, height: 32);

      engine.playAnimation();
      expect(engine.isAnimationPlaying, isTrue);

      engine.pauseAnimation();
      expect(engine.isAnimationPlaying, isFalse);

      engine.stopAnimation();
      expect(engine.currentAnimationFrameIndex, equals(0));

      engine.seekFrame(5);
      expect(engine.currentAnimationFrameIndex, equals(5));
    });

    test('Onion skin toggle and settings configuration', () {
      final engine = CanvasEngine(width: 32, height: 32);
      expect(engine.animationEngine.settings.onionSkinEnabled, isFalse);

      engine.toggleOnionSkin(true);
      expect(engine.animationEngine.settings.onionSkinEnabled, isTrue);

      engine.setLoopMode(LoopMode.pingPong);
      expect(engine.animationEngine.settings.loopMode, equals(LoopMode.pingPong));
    });
  });
}
