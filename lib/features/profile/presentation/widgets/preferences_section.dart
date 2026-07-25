import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/profile/presentation/widgets/settings_tile.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';
import 'package:pixelcanvas/theme/app_typography.dart';

/// User preferences settings section per Blueprint §5.1.
///
/// **Purpose**: Controls for Theme, Language, Canvas Grid, Auto-Save, and Animations.
/// **Parameters**:
/// - [onThemeChanged]: Theme toggle callback.
/// - [onGridToggle]: Grid visibility callback.
/// - [onAutoSaveToggle]: Auto-save callback.
/// - [onAnimationsToggle]: Animations callback.
///
/// **Future Extension Notes**: Interacts with Riverpod `PreferencesServiceNotifier` in Phase 2 Step 10.
class PreferencesSection extends StatefulWidget {
  /// Creates a [PreferencesSection].
  const PreferencesSection({
    this.onThemeChanged,
    this.onGridToggle,
    this.onAutoSaveToggle,
    this.onAnimationsToggle,
    super.key,
  });

  /// Callbacks.
  final ValueChanged<bool>? onThemeChanged;
  final ValueChanged<bool>? onGridToggle;
  final ValueChanged<bool>? onAutoSaveToggle;
  final ValueChanged<bool>? onAnimationsToggle;

  @override
  State<PreferencesSection> createState() => _PreferencesSectionState();
}

class _PreferencesSectionState extends State<PreferencesSection> {
  bool _gridVisible = true;
  bool _autoSave = true;
  bool _animations = true;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preferences',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          PcCard(
            variant: PcCardVariant.elevated,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SettingsTile(
                  icon: Icons.palette_outlined,
                  title: 'Theme',
                  subtitle: 'Light Edition (Default)',
                  trailing: Text(
                    'Light Mode',
                    style: AppTypography.labelSmall.copyWith(color: AppColors.primary500),
                  ),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  subtitle: 'English (United States)',
                  trailing: Text(
                    'English',
                    style: AppTypography.labelSmall.copyWith(color: AppColors.neutral400),
                  ),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.grid_on_rounded,
                  title: 'Canvas Pixel Grid',
                  subtitle: 'Show grid lines on canvas editor',
                  trailing: Switch(
                    value: _gridVisible,
                    activeColor: AppColors.primary500,
                    onChanged: (val) {
                      setState(() {
                        _gridVisible = val;
                      });
                      widget.onGridToggle?.call(val);
                    },
                  ),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.autorenew_rounded,
                  title: 'Auto-Save Projects',
                  subtitle: 'Automatically save changes every 30 seconds',
                  trailing: Switch(
                    value: _autoSave,
                    activeColor: AppColors.primary500,
                    onChanged: (val) {
                      setState(() {
                        _autoSave = val;
                      });
                      widget.onAutoSaveToggle?.call(val);
                    },
                  ),
                ),
                const Divider(height: 1),
                SettingsTile(
                  icon: Icons.animation_rounded,
                  title: 'UI Micro-Animations',
                  subtitle: 'Enable 60 FPS transition animations',
                  trailing: Switch(
                    value: _animations,
                    activeColor: AppColors.primary500,
                    onChanged: (val) {
                      setState(() {
                        _animations = val;
                      });
                      widget.onAnimationsToggle?.call(val);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
