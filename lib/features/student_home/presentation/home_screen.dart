import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/utils/greeting.dart';
import 'package:campus_care/core/widgets/category_icon.dart';
import 'package:campus_care/core/widgets/error_view.dart';
import 'package:campus_care/core/widgets/incident_card.dart';
import 'package:campus_care/core/widgets/loading_indicator.dart';
import 'package:campus_care/core/widgets/primary_button.dart';
import 'package:campus_care/core/widgets/summary_card.dart';
import 'package:campus_care/features/auth/presentation/auth_controller.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';
import 'package:campus_care/features/incidents/domain/incident_category.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';
import 'package:campus_care/features/incidents/presentation/incident_providers.dart';
import 'package:campus_care/features/notifications/data/mock_notification_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).user;
    final incidents = ref.watch(studentIncidentsProvider);
    final unread = ref.watch(unreadNotificationCountProvider);
    final greeting = greetingFor(DateTime.now());
    final name = user?.firstName ?? '';

    return Scaffold(
      body: SafeArea(
        child: incidents.when(
          loading: () => const LoadingIndicator(),
          error: (_, _) => ErrorView(
            message: AppStrings.couldNotLoadReports,
            onRetry: () => ref.invalidate(studentIncidentsProvider),
          ),
          data: (items) => _HomeBody(
            greeting: AppStrings.greetingNamed(greeting, name),
            unread: unread,
            incidents: items,
          ),
        ),
      ),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({
    required this.greeting,
    required this.unread,
    required this.incidents,
  });

  final String greeting;
  final int unread;
  final List<Incident> incidents;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final recent = incidents.take(3).toList();
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(greeting, style: theme.textTheme.titleMedium),
            ),
            Badge(
              isLabelVisible: unread > 0,
              label: Text('$unread'),
              child: IconButton(
                tooltip: unread > 0
                    ? AppStrings.unreadCount(unread)
                    : AppStrings.notifications,
                onPressed: () => context.go(RouteNames.studentNotifications),
                icon: const Icon(Icons.notifications_outlined),
              ),
            ),
          ],
        ),
        Text(AppStrings.homeHeadline, style: theme.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: AppStrings.reportAnIssue,
          onPressed: () => context.push(RouteNames.studentReportNew),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(AppStrings.yourReports, style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        _SummaryRow(incidents: incidents),
        const SizedBox(height: AppSpacing.xl),
        Text(AppStrings.browseByCategory, style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: AppSpacing.minTouchTarget + AppSpacing.xl + AppSpacing.md,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: IncidentCategory.values.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final category = IncidentCategory.values[index];
              return _CategoryShortcut(
                category: category,
                onTap: () {
                  ref
                      .read(selectedReportCategoryProvider.notifier)
                      .select(category);
                  context.go(RouteNames.studentReports);
                },
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Expanded(
              child: Text(
                AppStrings.recentReports,
                style: theme.textTheme.titleMedium,
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(selectedReportCategoryProvider.notifier).select(null);
                context.go(RouteNames.studentReports);
              },
              child: const Text(AppStrings.seeAll),
            ),
          ],
        ),
        if (recent.isEmpty)
          Text(
            AppStrings.noReportsYet,
            style: theme.textTheme.bodyLarge,
          )
        else
          for (final incident in recent) ...[
            IncidentCard(
              incident: incident,
              style: IncidentCardStyle.compact,
              onTap: () => context.push(
                RouteNames.studentReportDetails(incident.id),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.incidents});

  final List<Incident> incidents;

  int _count(bool Function(Incident incident) test) {
    return incidents.where(test).length;
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
      SummaryCard(
        title: AppStrings.submitted,
        value: '${_count((item) => item.status == IncidentStatus.submitted)}',
      ),
      SummaryCard(
        title: AppStrings.pending,
        value:
            '${_count((item) => item.status == IncidentStatus.underReview)}',
        tone: SummaryTone.pending,
      ),
      SummaryCard(
        title: AppStrings.inProgress,
        value: '${_count((item) => item.status == IncidentStatus.inProgress)}',
        tone: SummaryTone.progress,
      ),
      SummaryCard(
        title: AppStrings.resolved,
        value: '${_count((item) => item.status == IncidentStatus.resolved)}',
        tone: SummaryTone.resolved,
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppSpacing.wideLayout) {
          return Row(
            children: [
              for (var index = 0; index < cards.length; index++) ...[
                if (index > 0) const SizedBox(width: AppSpacing.xs),
                Expanded(child: cards[index]),
              ],
            ],
          );
        }
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: cards[0]),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: cards[1]),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(child: cards[2]),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: cards[3]),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _CategoryShortcut extends StatelessWidget {
  const _CategoryShortcut({required this.category, required this.onTap});

  final IncidentCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: AppSpacing.logoMark + AppSpacing.lg,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
        child: Column(
          children: [
            Container(
              width: AppSpacing.minTouchTarget,
              height: AppSpacing.minTouchTarget,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: CategoryIcon(category: category),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              category.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
