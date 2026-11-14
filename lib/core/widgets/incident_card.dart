import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/utils/date_formatter.dart';
import 'package:campus_care/core/widgets/incident_thumbnail.dart';
import 'package:campus_care/core/widgets/status_badge.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';

enum IncidentCardStyle { compact, list }

class IncidentCard extends StatelessWidget {
  const IncidentCard({
    required this.incident,
    this.onTap,
    this.style = IncidentCardStyle.list,
    super.key,
  });

  final Incident incident;
  final VoidCallback? onTap;
  final IncidentCardStyle style;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final subtitle = switch (style) {
      IncidentCardStyle.compact => incident.location.placeLabel,
      IncidentCardStyle.list =>
        '${incident.location.building} · ${DateFormatter.formatDayMonth(incident.createdAt)}',
    };
    return Semantics(
      button: onTap != null,
      label: '${incident.title}, ${incident.status.badgeLabel}',
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              children: [
                IncidentThumbnail(incident: incident),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        incident.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                StatusBadge(status: incident.status),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
