import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_durations.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Variant style for [PcButton].
enum PcButtonVariant {
  /// Primary filled brand button (#6C5CE7).
  primary,

  /// Secondary filled button.
  secondary,

  /// Outlined border button.
  outlined,

  /// Transparent background ghost button.
  ghost,

  /// Destructive danger action button.
  danger,
}

/// Size variant for [PcButton].
enum PcButtonSize {
  /// Compact height (36dp).
  small,

  /// Standard height (44dp).
  medium,

  /// Large hero height (52dp).
  large,
}

/// PixelCanvas branded button component per Blueprint §9.6 and §31.8.
///
/// **Purpose**: Primary interactive button across all screens.
/// **Parameters**:
/// - [label]: Button text label.
/// - [onPressed]: Callback when tapped (null disables button).
/// - [variant]: Visual style variant (default: [PcButtonVariant.primary]).
/// - [size]: Height size variant (default: [PcButtonSize.medium]).
/// - [isLoading]: Displays spinner loader and disables interaction.
/// - [leadingIcon]: Optional icon prefix.
/// - [trailingIcon]: Optional icon suffix.
/// - [fullWidth]: Expands button to fill parent width.
///
/// **Usage Example**:
/// ```dart
/// PcButton(
///   label: 'Create Project',
///   onPressed: () => print('Tapped'),
///   variant: PcButtonVariant.primary,
///   leadingIcon: Icons.add,
/// )
/// ```
/// **Accessibility**: Wrapped in [Semantics] with button trait and label.
class PcButton extends StatelessWidget {
  /// Creates a [PcButton].
  const PcButton({
    required this.label,
    required this.onPressed,
    this.variant = PcButtonVariant.primary,
    this.size = PcButtonSize.medium,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.fullWidth = false,
    super.key,
  });

  /// Button text label.
  final String label;

  /// Callback when tapped (null disables button).
  final VoidCallback? onPressed;

  /// Style variant.
  final PcButtonVariant variant;

  /// Size variant.
  final PcButtonSize size;

  /// True if loading indicator is active.
  final bool isLoading;

  /// Optional prefix icon.
  final IconData? leadingIcon;

  /// Optional suffix icon.
  final IconData? trailingIcon;

  /// True if button takes full width.
  final bool fullWidth;

  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final height = switch (size) {
      PcButtonSize.small => 36.0,
      PcButtonSize.medium => 44.0,
      PcButtonSize.large => 52.0,
    };

    final horizontalPadding = switch (size) {
      PcButtonSize.small => AppSpacing.md,
      PcButtonSize.medium => AppSpacing.base,
      PcButtonSize.large => AppSpacing.xl,
    };

    final backgroundColor = _getBackgroundColor();
    final foregroundColor = _getForegroundColor();
    final border = _getBorder();

    Widget content = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ] else if (leadingIcon != null) ...[
          Icon(leadingIcon, size: 18, color: foregroundColor),
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(
          label,
          style: AppTypography.labelLarge.copyWith(color: foregroundColor),
        ),
        if (trailingIcon != null && !isLoading) ...[
          const SizedBox(width: AppSpacing.sm),
          Icon(trailingIcon, size: 18, color: foregroundColor),
        ],
      ],
    );

    return Semantics(
      button: true,
      enabled: _isEnabled,
      label: label,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: AppRadius.borderFull,
          border: border,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: AppRadius.borderFull,
            onTap: _isEnabled ? onPressed : null,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Center(child: content),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!_isEnabled) {
      return variant == PcButtonVariant.ghost || variant == PcButtonVariant.outlined
          ? Colors.transparent
          : AppColors.primary200;
    }
    return switch (variant) {
      PcButtonVariant.primary => AppColors.primary500,
      PcButtonVariant.secondary => AppColors.primary100,
      PcButtonVariant.outlined => Colors.transparent,
      PcButtonVariant.ghost => Colors.transparent,
      PcButtonVariant.danger => AppColors.dangerMain,
    };
  }

  Color _getForegroundColor() {
    if (!_isEnabled) {
      return AppColors.neutral300;
    }
    return switch (variant) {
      PcButtonVariant.primary => AppColors.neutral0,
      PcButtonVariant.secondary => AppColors.primary500,
      PcButtonVariant.outlined => AppColors.primary500,
      PcButtonVariant.ghost => AppColors.neutral500,
      PcButtonVariant.danger => AppColors.neutral0,
    };
  }

  Border? _getBorder() {
    if (variant == PcButtonVariant.outlined) {
      return Border.all(
        color: _isEnabled ? AppColors.primary500 : AppColors.neutral200,
      );
    }
    return null;
  }
}
