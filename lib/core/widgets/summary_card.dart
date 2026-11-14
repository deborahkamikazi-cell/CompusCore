import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_colors.dart';
import 'package:campus_care/core/theme/app_spacing.dart';

enum SummaryTone { neutral, pending, progress, resolved }

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    required this.title,
    required this.value,
    this.subtitle,
    this.tone = SummaryTone.neutral,
    super.key,
  });

  final String title;
  final String value;
  final String? subtitle;
  final SummaryTone tone;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final valueColor = switch (tone) {
      SummaryTone.neutral => AppColors.textPrimary,
      SummaryTone.pending => AppColors.pendingText,
      SummaryTone.progress => AppColors.inProgressText,
      SummaryTone.resolved => AppColors.resolvedText,
    };
    return Semantics(
      label: '$title, $value',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                value,
                style: textTheme.titleLarge?.copyWith(color: valueColor),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(subtitle!, style: textTheme.bodySmall),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
