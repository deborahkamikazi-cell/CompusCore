import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_spacing.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    required this.title,
    required this.value,
    this.subtitle,
    super.key,
  });

  final String title;
  final String value;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: textTheme.bodySmall),
            const SizedBox(height: AppSpacing.xxs),
            Text(value, style: textTheme.headlineSmall),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.xxs),
              Text(subtitle!, style: textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
