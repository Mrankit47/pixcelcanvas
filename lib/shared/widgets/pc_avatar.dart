import 'package:flutter/material.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// Size variant for [PcAvatar].
enum PcAvatarSize {
  /// Small avatar (32dp).
  small,

  /// Medium avatar (44dp).
  medium,

  /// Large avatar (64dp).
  large,
}

/// PixelCanvas branded user avatar component per Blueprint §9.6.
///
/// **Purpose**: User profile avatar displaying network image or fallback initials.
/// **Parameters**:
/// - [imageUrl]: Remote avatar image URL.
/// - [name]: User name (used to generate fallback initials).
/// - [size]: Avatar size variant (default: [PcAvatarSize.medium]).
/// - [isOnline]: Displays green online status dot if true.
///
/// **Usage Example**:
/// ```dart
/// PcAvatar(
///   imageUrl: 'https://example.com/avatar.png',
///   name: 'John Doe',
///   size: PcAvatarSize.medium,
///   isOnline: true,
/// )
/// ```
class PcAvatar extends StatelessWidget {
  /// Creates a [PcAvatar].
  const PcAvatar({
    this.imageUrl,
    this.name,
    this.size = PcAvatarSize.medium,
    this.isOnline = false,
    super.key,
  });

  /// Remote avatar image URL.
  final String? imageUrl;

  /// User name for fallback initials.
  final String? name;

  /// Avatar size variant.
  final PcAvatarSize size;

  /// True if online indicator dot is displayed.
  final bool isOnline;

  String get _initials {
    if (name == null || name!.trim().isEmpty) return '?';
    final parts = name!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final diameter = switch (size) {
      PcAvatarSize.small => 32.0,
      PcAvatarSize.medium => 44.0,
      PcAvatarSize.large => 64.0,
    };

    final textStyle = switch (size) {
      PcAvatarSize.small => AppTypography.labelSmall,
      PcAvatarSize.medium => AppTypography.labelLarge,
      PcAvatarSize.large => AppTypography.headlineSmall,
    };

    final dotSize = switch (size) {
      PcAvatarSize.small => 8.0,
      PcAvatarSize.medium => 12.0,
      PcAvatarSize.large => 16.0,
    };

    return Stack(
      children: [
        Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary100,
            border: Border.all(color: AppColors.neutral200, width: 1),
          ),
          child: ClipOval(
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Text(_initials, style: textStyle.copyWith(color: AppColors.primary500)),
                    ),
                  )
                : Center(
                    child: Text(_initials, style: textStyle.copyWith(color: AppColors.primary500)),
                  ),
          ),
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.successMain,
                border: Border.all(color: AppColors.surface, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
