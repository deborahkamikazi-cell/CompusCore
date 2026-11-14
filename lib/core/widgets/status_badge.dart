import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_colors.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.status,
    this.useListLabel = true,
    super.key,
  });

  final IncidentStatus status;
  final bool useListLabel;

  @override
  Widget build(BuildContext context) {
    final colors = _colorsFor(status);
    final label = useListLabel ? status.badgeLabel : status.label;
    return Semantics(
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: colors.foreground),
        ),
      ),
    );
  }

  static ({Color background, Color foreground}) _colorsFor(
    IncidentStatus status,
  ) {
    return switch (status) {
      IncidentStatus.submitted || IncidentStatus.underReview => (
        background: AppColors.pendingBackground,
        foreground: AppColors.pendingText,
      ),
      IncidentStatus.inProgress => (
        background: AppColors.inProgressBackground,
        foreground: AppColors.inProgressText,
      ),
      IncidentStatus.resolved => (
        background: AppColors.resolvedBackground,
        foreground: AppColors.resolvedText,
      ),
    };
  }
}
