import 'package:flutter/material.dart';
import 'package:pixelcanvas/shared/widgets/pc_avatar.dart';
import 'package:pixelcanvas/shared/widgets/pc_bottom_sheet.dart';
import 'package:pixelcanvas/shared/widgets/pc_button.dart';
import 'package:pixelcanvas/shared/widgets/pc_card.dart';
import 'package:pixelcanvas/shared/widgets/pc_dialog.dart';
import 'package:pixelcanvas/shared/widgets/pc_empty_state.dart';
import 'package:pixelcanvas/shared/widgets/pc_error_state.dart';
import 'package:pixelcanvas/shared/widgets/pc_loading.dart';
import 'package:pixelcanvas/shared/widgets/pc_snackbar.dart';
import 'package:pixelcanvas/shared/widgets/pc_text_field.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Interactive Component Showcase Gallery Screen per prompt requirements.
///
/// **Purpose**: Visual test bench showcasing every branded widget variant.
class ComponentGalleryScreen extends StatelessWidget {
  /// Creates a [ComponentGalleryScreen].
  const ComponentGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Component Gallery'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.base),
          children: [
            _buildSectionHeader(context, '1. Buttons (PcButton)'),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                PcButton(
                  label: 'Primary',
                  onPressed: () {},
                  variant: PcButtonVariant.primary,
                ),
                PcButton(
                  label: 'Secondary',
                  onPressed: () {},
                  variant: PcButtonVariant.secondary,
                ),
                PcButton(
                  label: 'Outlined',
                  onPressed: () {},
                  variant: PcButtonVariant.outlined,
                ),
                PcButton(
                  label: 'Ghost',
                  onPressed: () {},
                  variant: PcButtonVariant.ghost,
                ),
                PcButton(
                  label: 'Danger',
                  onPressed: () {},
                  variant: PcButtonVariant.danger,
                ),
                PcButton(
                  label: 'Loading',
                  onPressed: () {},
                  isLoading: true,
                ),
                const PcButton(
                  label: 'Disabled',
                  onPressed: null,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            _buildSectionHeader(context, '2. Cards (PcCard)'),
            PcCard(
              variant: PcCardVariant.elevated,
              child: const Text('Elevated Card Container'),
            ),
            const SizedBox(height: AppSpacing.sm),
            PcCard(
              variant: PcCardVariant.outlined,
              child: const Text('Outlined Card Container'),
            ),
            const SizedBox(height: AppSpacing.sm),
            PcCard(
              variant: PcCardVariant.filled,
              child: const Text('Filled Card Container'),
            ),
            const SizedBox(height: AppSpacing.xl),

            _buildSectionHeader(context, '3. Text Inputs (PcTextField)'),
            const PcTextField(
              labelText: 'Standard Input',
              hintText: 'Type something...',
            ),
            const SizedBox(height: AppSpacing.md),
            const PcTextField(
              variant: PcTextFieldVariant.password,
              labelText: 'Password Input',
              hintText: 'Enter password',
            ),
            const SizedBox(height: AppSpacing.md),
            const PcTextField(
              variant: PcTextFieldVariant.search,
              hintText: 'Search artworks...',
            ),
            const SizedBox(height: AppSpacing.md),
            const PcTextField(
              labelText: 'Error State Input',
              hintText: 'Invalid value',
              errorText: 'This field is required',
            ),
            const SizedBox(height: AppSpacing.xl),

            _buildSectionHeader(context, '4. Avatars (PcAvatar)'),
            Row(
              children: [
                const PcAvatar(name: 'Alice Smith', size: PcAvatarSize.small),
                const SizedBox(width: AppSpacing.md),
                const PcAvatar(name: 'Bob Jones', size: PcAvatarSize.medium, isOnline: true),
                const SizedBox(width: AppSpacing.md),
                const PcAvatar(name: 'Charlie Brown', size: PcAvatarSize.large, isOnline: true),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            _buildSectionHeader(context, '5. Loaders (PcLoading)'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PcLoading(variant: PcLoadingVariant.circular),
                PcLoading(variant: PcLoadingVariant.skeleton, width: 120, size: 24),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const PcLoading(variant: PcLoadingVariant.linear),
            const SizedBox(height: AppSpacing.xl),

            _buildSectionHeader(context, '6. Toasts & Notifications (PcSnackbar)'),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                PcButton(
                  label: 'Success Toast',
                  onPressed: () => PcSnackbar.showSuccess(context, 'Operation completed!'),
                ),
                PcButton(
                  label: 'Error Toast',
                  variant: PcButtonVariant.danger,
                  onPressed: () => PcSnackbar.showError(context, 'Operation failed!'),
                ),
                PcButton(
                  label: 'Warning Toast',
                  variant: PcButtonVariant.outlined,
                  onPressed: () => PcSnackbar.showWarning(context, 'Warning alert!'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            _buildSectionHeader(context, '7. Dialogs & Bottom Sheets'),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                PcButton(
                  label: 'Show Confirmation',
                  onPressed: () => PcDialog.showConfirmation(
                    context,
                    title: 'Delete Item?',
                    message: 'Are you sure you want to delete this artwork?',
                  ),
                ),
                PcButton(
                  label: 'Show Bottom Sheet',
                  variant: PcButtonVariant.secondary,
                  onPressed: () => PcBottomSheet.show(
                    context,
                    title: 'Options',
                    child: const Padding(
                      padding: EdgeInsets.all(AppSpacing.base),
                      child: Text('Bottom Sheet Content'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            _buildSectionHeader(context, '8. Empty & Error States'),
            const PcEmptyState(
              title: 'No Items Found',
              message: 'Your gallery is empty right now.',
              icon: Icons.palette_outlined,
            ),
            const SizedBox(height: AppSpacing.md),
            PcErrorState(
              message: 'Failed to connect to network.',
              onRetry: () {},
            ),
          ],
        ),
      );

  Widget _buildSectionHeader(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
}
