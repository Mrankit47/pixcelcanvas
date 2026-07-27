import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/help/controllers/tutorial_manager.dart';

/// Floating step instruction banner for interactive tutorials.
class TutorialOverlayWidget extends StatelessWidget {
  /// Creates a [TutorialOverlayWidget].
  const TutorialOverlayWidget({
    super.key,
    required this.tutorialManager,
  });

  final TutorialManager tutorialManager;

  @override
  Widget build(BuildContext context) {
    final step = tutorialManager.currentStep;
    if (!tutorialManager.isActive || step == null) {
      return const SizedBox();
    }

    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 480,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF6C5CE7), width: 1.5),
            boxShadow: const [
              BoxShadow(color: Colors.black45, blurRadius: 16, offset: Offset(0, 6)),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.school_rounded, color: Color(0xFF6C5CE7), size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step.instruction,
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: const Size(0, 30),
                ),
                onPressed: () => tutorialManager.nextStep(),
                child: const Text('Got it', style: TextStyle(color: Colors.white, fontSize: 11)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
