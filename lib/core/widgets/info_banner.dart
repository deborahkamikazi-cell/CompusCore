import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_colors.dart';
import 'package:campus_care/core/theme/app_spacing.dart';

class InfoBanner extends StatelessWidget {
  const InfoBanner({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Semantics(
      label: message,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.inProgressBackground,
          borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info_outline,
              color: AppColors.inProgressText,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.inProgressText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
