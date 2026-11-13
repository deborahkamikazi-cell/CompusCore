import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/utils/date_formatter.dart';
import 'package:campus_care/core/widgets/category_chip.dart';
import 'package:campus_care/core/widgets/loading_indicator.dart';
import 'package:campus_care/core/widgets/priority_chip.dart';
import 'package:campus_care/core/widgets/status_badge.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';

/// Compact incident summary. Layout stays minimal until the reports UI phase.
class IncidentCard extends StatelessWidget {
  const IncidentCard({required this.incident, this.onTap, super.key});

  final Incident incident;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (incident.imageUrls.isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
                  child: CachedNetworkImage(
                    imageUrl: incident.imageUrls.first,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => const LoadingIndicator(),
                    errorWidget: (_, _, _) =>
                        const Icon(Icons.broken_image_outlined),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              Text(incident.referenceNumber, style: textTheme.bodySmall),
              const SizedBox(height: AppSpacing.xxs),
              Text(incident.title, style: textTheme.titleMedium),
              const SizedBox(height: AppSpacing.xxs),
              Text(incident.location.displayLabel, style: textTheme.bodySmall),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  StatusBadge(status: incident.status),
                  PriorityChip(priority: incident.priority),
                  CategoryChip(category: incident.category),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                DateFormatter.formatDateTime(incident.createdAt),
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
