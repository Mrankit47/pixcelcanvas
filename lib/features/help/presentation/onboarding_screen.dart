import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/help/controllers/onboarding_manager.dart';

/// First Launch Onboarding Welcome Screen per Blueprint §7.5.
class OnboardingScreen extends StatefulWidget {
  /// Creates an [OnboardingScreen].
  const OnboardingScreen({
    super.key,
    required this.onboardingManager,
    required this.onFinish,
  });

  final OnboardingManager onboardingManager;
  final VoidCallback onFinish;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF11111B),
      child: Center(
        child: Container(
          width: 650,
          height: 480,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF313244)),
            boxShadow: [
              const BoxShadow(color: Colors.black45, blurRadius: 24, offset: Offset(0, 8)),
            ],
          ),
          child: Column(
            children: [
              // Header Indicator
              Container(
                padding: const EdgeInsets.all(16),
                color: const Color(0xFF181825),
                child: Row(
                  children: [
                    const Icon(Icons.brush_rounded, color: Color(0xFF6C5CE7)),
                    const SizedBox(width: 8),
                    const Text('Welcome to PixelCanvas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        widget.onboardingManager.completeOnboarding();
                        widget.onFinish();
                      },
                      child: const Text('Skip Setup', style: TextStyle(color: Colors.white38)),
                    ),
                  ],
                ),
              ),

              // Page Content
              Expanded(child: _buildPageContent()),

              // Footer Progress Bar
              Container(
                padding: const EdgeInsets.all(16),
                color: const Color(0xFF181825),
                child: Row(
                  children: [
                    Row(
                      children: List.generate(3, (idx) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == idx ? const Color(0xFF6C5CE7) : Colors.white24,
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    if (_currentPage < 2)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
                        onPressed: () => setState(() => _currentPage++),
                        child: const Text('Next', style: TextStyle(color: Colors.white)),
                      ),
                    if (_currentPage == 2)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
                        onPressed: () {
                          widget.onboardingManager.completeOnboarding();
                          widget.onFinish();
                        },
                        child: const Text('Get Started!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    switch (_currentPage) {
      case 0:
        return _buildIntroPage();
      case 1:
        return _buildLayoutPage();
      case 2:
        return _buildFinishPage();
      default:
        return const SizedBox();
    }
  }

  Widget _buildIntroPage() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.palette_rounded, size: 64, color: Color(0xFF6C5CE7)),
          SizedBox(height: 16),
          Text('Production Pixel Art Studio', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'PixelCanvas is built for game developers, artists, and animators with non-destructive layers, rubber-band selections, and interactive animation timelines.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutPage() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.dashboard_customize_rounded, size: 64, color: Color(0xFF89B4FA)),
          SizedBox(height: 16),
          Text('Flexible Responsive Layouts', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(
            'Adapts seamlessly across Desktop, Tablet, and Mobile screens with customizable sidebars and collapsible status bars.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildFinishPage() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.check_circle_rounded, size: 64, color: Color(0xFF2ECC71)),
          SizedBox(height: 16),
          Text('Setup Complete!', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('You are ready to create your first pixel art masterpiece.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white60, fontSize: 12)),
        ],
      ),
    );
  }
}
