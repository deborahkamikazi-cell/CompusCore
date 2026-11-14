import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/widgets/primary_button.dart';
import 'package:campus_care/features/incidents/presentation/incident_providers.dart';

class ReportSuccessScreen extends ConsumerWidget {
  const ReportSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final incident = ref.watch(lastSubmittedIncidentProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.check_circle,
                size: AppSpacing.logoMark,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                AppStrings.reportSubmitted,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                AppStrings.reportSubmittedBody,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              if (incident != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  AppStrings.referenceNumber,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  incident.referenceNumber,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
              ],
              const Spacer(),
              PrimaryButton(
                label: AppStrings.viewMyReports,
                onPressed: () => context.go(RouteNames.studentReports),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
