import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/shared/widgets/pc_text_field.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Sign-in form card component with email/password and social OAuth options per Blueprint §5.1 & §6.2.
///
/// **Purpose**: Presentational form card for email authentication and social sign-in.
/// **Parameters**:
/// - [onSignIn]: Callback emitting email and password when Sign In button is tapped.
/// - [onForgotPassword]: Callback when Forgot Password button is tapped.
/// - [onGoogleSignIn]: Callback when Google button is tapped.
/// - [onGitHubSignIn]: Callback when GitHub button is tapped.
/// - [isLoading]: True if auth request is in progress.
///
/// **Future Extension Notes**: Form validation will be handled by Riverpod AuthNotifier in Phase 3.
class SignInCard extends StatefulWidget {
  /// Creates a [SignInCard].
  const SignInCard({
    required this.onSignIn,
    required this.onForgotPassword,
    required this.onGoogleSignIn,
    required this.onGitHubSignIn,
    this.isLoading = false,
    super.key,
  });

  /// Sign In callback receiving email & password.
  final void Function(String email, String password) onSignIn;

  /// Forgot password callback.
  final VoidCallback onForgotPassword;

  /// Google sign in callback.
  final VoidCallback onGoogleSignIn;

  /// GitHub sign in callback.
  final VoidCallback onGitHubSignIn;

  /// True if loading.
  final bool isLoading;

  @override
  State<SignInCard> createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    widget.onSignIn(
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) => PcCard(
        variant: PcCardVariant.elevated,
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email Input
            PcTextField(
              controller: _emailController,
              labelText: 'Email Address',
              hintText: 'artist@pixelcanvas.app',
              leadingIcon: Icons.email_outlined,
              enabled: !widget.isLoading,
            ),
            const SizedBox(height: AppSpacing.md),

            // Password Input
            PcTextField(
              controller: _passwordController,
              variant: PcTextFieldVariant.password,
              labelText: 'Password',
              hintText: '••••••••',
              leadingIcon: Icons.lock_outlined,
              enabled: !widget.isLoading,
            ),
            const SizedBox(height: AppSpacing.xs),

            // Forgot Password Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: widget.isLoading ? null : widget.onForgotPassword,
                child: Text(
                  'Forgot Password?',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Sign In CTA Button
            PcButton(
              label: 'Sign In',
              variant: PcButtonVariant.primary,
              size: PcButtonSize.large,
              fullWidth: true,
              isLoading: widget.isLoading,
              onPressed: _handleSignIn,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Divider
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                  child: Text(
                    'OR',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.neutral300,
                    ),
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Social Sign In Buttons
            PcButton(
              label: 'Continue with Google',
              variant: PcButtonVariant.outlined,
              leadingIcon: Icons.g_mobiledata_rounded,
              fullWidth: true,
              onPressed: widget.isLoading ? null : widget.onGoogleSignIn,
            ),
            const SizedBox(height: AppSpacing.sm),
            PcButton(
              label: 'Continue with GitHub',
              variant: PcButtonVariant.outlined,
              leadingIcon: Icons.code_rounded,
              fullWidth: true,
              onPressed: widget.isLoading ? null : widget.onGitHubSignIn,
            ),
          ],
        ),
      );
}
