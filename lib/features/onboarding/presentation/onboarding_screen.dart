import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/onboarding/presentation/widgets/navigation_controls.dart';
import 'package:pixelcanvas/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_durations.dart';

/// Production-ready 4-page Onboarding Screen for PixelCanvas per Blueprint §5.1.
///
/// **Purpose**: Introduces PixelCanvas feature set through 4 interactive pages.
/// **Pages**:
/// 1. Welcome to PixelCanvas — Simple pixel art creation.
/// 2. Professional Drawing Tools — Layers, custom palette, templates.
/// 3. Offline First Freedom — Create artwork anywhere without connection.
/// 4. Community & Sharing — Share creations & explore gallery.
///
/// **Future Extension Notes**: Callbacks [onOnboardingComplete] and [onSkipComplete] will be wired to router redirect in Phase 2 Step 3.
class OnboardingScreen extends StatefulWidget {
  /// Creates an [OnboardingScreen].
  const OnboardingScreen({
    this.onOnboardingComplete,
    this.onSkipComplete,
    super.key,
  });

  /// Callback when final "Get Started" CTA is tapped.
  final VoidCallback? onOnboardingComplete;

  /// Callback when "Skip" button is tapped.
  final VoidCallback? onSkipComplete;

  static const List<OnboardingPageData> pages = [
    OnboardingPageData(
      title: 'Welcome to PixelCanvas',
      description: 'The simplest way to create pixel art for everyone, anywhere, anytime.',
      icon: Icons.palette_outlined,
    ),
    OnboardingPageData(
      title: 'Professional Tools',
      description: 'Powerful multi-layer stack, custom color palettes, and starter templates.',
      icon: Icons.layers_outlined,
    ),
    OnboardingPageData(
      title: 'Offline First Freedom',
      description: 'Create artwork anytime without an internet connection. Auto-syncs when online.',
      icon: Icons.cloud_off_outlined,
    ),
    OnboardingPageData(
      title: 'Community & Sharing',
      description: 'Publish your pixel art, inspire creators worldwide, and explore community gallery.',
      icon: Icons.groups_outlined,
    ),
  ];

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < OnboardingScreen.pages.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: AppDurations.normal,
        curve: AppCurves.enter,
      );
    }
  }

  void _skipToEnd() {
    if (widget.onSkipComplete != null) {
      widget.onSkipComplete!();
    } else {
      _pageController.animateToPage(
        OnboardingScreen.pages.length - 1,
        duration: AppDurations.normal,
        curve: AppCurves.enter,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: Column(
            children: [
              // PageView Section (Lazy Building)
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: OnboardingScreen.pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardingPage(
                    data: OnboardingScreen.pages[index],
                    pageIndex: index,
                  ),
                ),
              ),

              // Bottom Navigation Controls Bar
              NavigationControls(
                pageCount: OnboardingScreen.pages.length,
                currentIndex: _currentIndex,
                onSkip: _skipToEnd,
                onNext: _nextPage,
                onGetStarted: widget.onOnboardingComplete ?? () {},
              ),
            ],
          ),
        ),
      );
}
