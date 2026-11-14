import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/utils/date_formatter.dart';
import 'package:campus_care/core/widgets/category_chip.dart';
import 'package:campus_care/core/widgets/photo_preview.dart';
import 'package:campus_care/core/widgets/priority_chip.dart';
import 'package:campus_care/core/widgets/status_badge.dart';
import 'package:campus_care/core/widgets/status_timeline.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';

class IncidentDetailBody extends StatelessWidget {
  const IncidentDetailBody({required this.incident, this.footer, super.key});

  final Incident incident;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final meta = [
      incident.category.label,
      incident.location.displayLabel,
      DateFormatter.formatDayMonthYear(incident.createdAt),
    ].join(' · ');
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(incident.title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.xs),
        Text(incident.referenceNumber, style: theme.textTheme.bodySmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            PriorityChip(priority: incident.priority),
            StatusBadge(status: incident.status, useListLabel: false),
            CategoryChip(category: incident.category),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(meta, style: theme.textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          '${AppStrings.reportedBy} ${incident.reporterName}',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(AppStrings.description, style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(incident.description, style: theme.textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.lg),
        Text(AppStrings.photosLabel, style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        if (incident.imageUrls.isEmpty)
          Text(AppStrings.noPhotos, style: theme.textTheme.bodyLarge)
        else
          SizedBox(
            height: AppSpacing.logoMark + AppSpacing.xl,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: incident.imageUrls.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                return PhotoPreview(path: incident.imageUrls[index]);
              },
            ),
          ),
        const SizedBox(height: AppSpacing.lg),
        Text(AppStrings.status, style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: StatusTimeline(
              currentStatus: incident.status,
              timestamps: incident.statusTimestamps,
            ),
          ),
        ),
        if (incident.staffNote != null && incident.staffNote!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(AppStrings.staffNote, style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(incident.staffNote!, style: theme.textTheme.bodyLarge),
        ],
        if (footer != null) ...[
          const SizedBox(height: AppSpacing.xl),
          footer!,
        ],
      ],
    );
  }
}
