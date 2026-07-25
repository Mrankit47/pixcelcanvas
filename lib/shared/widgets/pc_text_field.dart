import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Variant type for [PcTextField].
enum PcTextFieldVariant {
  /// Standard single-line text input.
  standard,

  /// Obscured password input with toggle eye icon.
  password,

  /// Search input with search icon and clear button.
  search,

  /// Multi-line text input (notes, descriptions).
  multiline,
}

/// PixelCanvas branded text input field component per Blueprint §9.6 and §31.8.
///
/// **Purpose**: Form and search text input field.
/// **Parameters**:
/// - [controller]: Text editing controller.
/// - [variant]: Input variant type (default: [PcTextFieldVariant.standard]).
/// - [hintText]: Placeholder text when field is empty.
/// - [labelText]: Floating label text.
/// - [errorText]: Validation error message text.
/// - [helperText]: Guidance helper text below input.
/// - [leadingIcon]: Prefix icon.
/// - [trailingIcon]: Suffix icon.
/// - [onChanged]: Value change listener callback.
/// - [enabled]: True if input is interactive.
///
/// **Usage Example**:
/// ```dart
/// PcTextField(
///   hintText: 'Enter project title',
///   leadingIcon: Icons.edit,
///   onChanged: (val) => print(val),
/// )
/// ```
/// **Accessibility**: Accessible input field with error text semantics.
class PcTextField extends StatefulWidget {
  /// Creates a [PcTextField].
  const PcTextField({
    this.controller,
    this.variant = PcTextFieldVariant.standard,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.leadingIcon,
    this.trailingIcon,
    this.onChanged,
    this.enabled = true,
    super.key,
  });

  /// Text editing controller.
  final TextEditingController? controller;

  /// Input variant type.
  final PcTextFieldVariant variant;

  /// Placeholder hint text.
  final String? hintText;

  /// Floating label text.
  final String? labelText;

  /// Validation error message text.
  final String? errorText;

  /// Guidance helper text below input.
  final String? helperText;

  /// Prefix icon.
  final IconData? leadingIcon;

  /// Suffix icon.
  final IconData? trailingIcon;

  /// Value change callback.
  final ValueChanged<String>? onChanged;

  /// True if field is enabled.
  final bool enabled;

  @override
  State<PcTextField> createState() => _PcTextFieldState();
}

class _PcTextFieldState extends State<PcTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.variant == PcTextFieldVariant.password;
    final isSearch = widget.variant == PcTextFieldVariant.search;
    final isMultiline = widget.variant == PcTextFieldVariant.multiline;

    final effectiveLeadingIcon =
        isSearch ? Icons.search : widget.leadingIcon;

    Widget? suffixIcon;
    if (isPassword) {
      suffixIcon = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.neutral400,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else if (widget.trailingIcon != null) {
      suffixIcon = Icon(widget.trailingIcon, color: AppColors.neutral400, size: 20);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: AppTypography.labelMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        TextField(
          controller: widget.controller,
          enabled: widget.enabled,
          obscureText: isPassword && _obscureText,
          maxLines: isMultiline ? 4 : 1,
          onChanged: widget.onChanged,
          style: AppTypography.bodyMedium.copyWith(
            color: widget.enabled ? AppColors.neutral500 : AppColors.neutral300,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.neutral300,
            ),
            errorText: widget.errorText,
            helperText: widget.helperText,
            prefixIcon: effectiveLeadingIcon != null
                ? Icon(effectiveLeadingIcon, color: AppColors.neutral400, size: 20)
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: widget.enabled ? AppColors.surface : AppColors.neutral100,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.md,
            ),
            border: const OutlineInputBorder(
              borderRadius: AppRadius.borderSm,
              borderSide: BorderSide(color: AppColors.outline),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: AppRadius.borderSm,
              borderSide: BorderSide(color: AppColors.outline),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: AppRadius.borderSm,
              borderSide: BorderSide(color: AppColors.outlineFocused, width: 2),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: AppRadius.borderSm,
              borderSide: BorderSide(color: AppColors.dangerMain),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: AppRadius.borderSm,
              borderSide: BorderSide(color: AppColors.dangerMain, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
