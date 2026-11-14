import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_colors.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/utils/date_formatter.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';

class StatusTimeline extends StatelessWidget {
  const StatusTimeline({
    required this.currentStatus,
    this.timestamps = const <IncidentStatus, DateTime>{},
    super.key,
  });

  final IncidentStatus currentStatus;
  final Map<IncidentStatus, DateTime> timestamps;

  @override
  Widget build(BuildContext context) {
    final currentIndex = IncidentStatus.values.indexOf(currentStatus);
    return Column(
      children: [
        for (var index = 0; index < IncidentStatus.values.length; index++)
          _StatusStep(
            status: IncidentStatus.values[index],
            timestamp: timestamps[IncidentStatus.values[index]],
            isReached: index <= currentIndex,
            isCurrent: index == currentIndex,
            showConnector: index < IncidentStatus.values.length - 1,
          ),
      ],
    );
  }
}

class _StatusStep extends StatelessWidget {
  const _StatusStep({
    required this.status,
    required this.timestamp,
    required this.isReached,
    required this.isCurrent,
    required this.showConnector,
  });

  final IncidentStatus status;
  final DateTime? timestamp;
  final bool isReached;
  final bool isCurrent;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final color = isCurrent
        ? scheme.primary
        : isReached
        ? scheme.onSurface
        : scheme.outline;
    final date = timestamp == null
        ? null
        : DateFormatter.formatDayMonth(timestamp!);
    final label = date == null ? status.label : '${status.label} · $date';
    return Semantics(
      label: label,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                isReached ? Icons.check_circle : Icons.circle_outlined,
                color: isReached ? scheme.primary : AppColors.border,
                size: 20,
              ),
              if (showConnector)
                Container(
                  width: 2,
                  height: AppSpacing.xl,
                  color: isReached ? scheme.primary : AppColors.border,
                ),
            ],
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                label,
                style: (isCurrent ? textTheme.titleMedium : textTheme.bodyLarge)
                    ?.copyWith(color: color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
