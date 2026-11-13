import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_colors.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/theme/app_text_styles.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.status, super.key});

  final IncidentStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = _colorsFor(status);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: AppTextStyles.label.copyWith(color: colors.foreground),
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
