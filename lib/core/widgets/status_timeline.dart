import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_colors.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';

/// Ordered status flow. Visual treatment stays plain until the details screen.
class StatusTimeline extends StatelessWidget {
  const StatusTimeline({required this.currentStatus, super.key});

  final IncidentStatus currentStatus;

  @override
  Widget build(BuildContext context) {
    final currentIndex = IncidentStatus.values.indexOf(currentStatus);
    return Column(
      children: [
        for (var index = 0; index < IncidentStatus.values.length; index++)
          _StatusStep(
            label: IncidentStatus.values[index].label,
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
    required this.label,
    required this.isReached,
    required this.isCurrent,
    required this.showConnector,
  });

  final String label;
  final bool isReached;
  final bool isCurrent;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    final color = isReached ? AppColors.royalBlue : AppColors.border;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isReached ? Icons.check_circle : Icons.circle_outlined,
              color: color,
              size: 20,
            ),
            if (showConnector)
              Container(width: 2, height: AppSpacing.xl, color: color),
          ],
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              label,
              style: isCurrent ? textTheme.titleMedium : textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
