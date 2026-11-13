import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_colors.dart';
import 'package:campus_care/features/incidents/domain/incident_priority.dart';

class PriorityChip extends StatelessWidget {
  const PriorityChip({required this.priority, super.key});

  final IncidentPriority priority;

  @override
  Widget build(BuildContext context) {
    final colors = _colorsFor(priority);
    return Chip(
      label: Text(priority.label),
      backgroundColor: colors.background,
      labelStyle: Theme.of(
        context,
      ).textTheme.labelLarge?.copyWith(color: colors.foreground),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }

  static ({Color background, Color foreground}) _colorsFor(
    IncidentPriority priority,
  ) {
    return switch (priority) {
      IncidentPriority.low => (
        background: AppColors.background,
        foreground: AppColors.textSecondary,
      ),
      IncidentPriority.medium => (
        background: AppColors.inProgressBackground,
        foreground: AppColors.inProgressText,
      ),
      IncidentPriority.high => (
        background: AppColors.pendingBackground,
        foreground: AppColors.pendingText,
      ),
      IncidentPriority.critical => (
        background: AppColors.urgentBackground,
        foreground: AppColors.urgentText,
      ),
    };
  }
}
