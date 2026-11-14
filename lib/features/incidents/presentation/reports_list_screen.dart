import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/widgets/app_text_field.dart';
import 'package:campus_care/core/widgets/empty_state.dart';
import 'package:campus_care/core/widgets/error_view.dart';
import 'package:campus_care/core/widgets/incident_card.dart';
import 'package:campus_care/core/widgets/loading_indicator.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';
import 'package:campus_care/features/incidents/domain/incident_category.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';
import 'package:campus_care/features/incidents/presentation/incident_providers.dart';

enum _StatusFilter { all, pending, inProgress, resolved }

class ReportsListScreen extends ConsumerStatefulWidget {
  const ReportsListScreen({this.initialCategory, super.key});

  final String? initialCategory;

  @override
  ConsumerState<ReportsListScreen> createState() => _ReportsListScreenState();
}

class _ReportsListScreenState extends ConsumerState<ReportsListScreen> {
  final _searchController = TextEditingController();
  var _query = '';
  var _status = _StatusFilter.all;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialCategory;
    if (initial != null && initial.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        ref
            .read(selectedReportCategoryProvider.notifier)
            .select(IncidentCategory.fromWire(initial));
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Incident> _filter(List<Incident> incidents, IncidentCategory? category) {
    return incidents.where((incident) {
      if (!incident.matchesQuery(_query)) {
        return false;
      }
      if (category != null && incident.category != category) {
        return false;
      }
      return switch (_status) {
        _StatusFilter.all => true,
        _StatusFilter.pending => incident.status.isPending,
        _StatusFilter.inProgress =>
          incident.status == IncidentStatus.inProgress,
        _StatusFilter.resolved => incident.status == IncidentStatus.resolved,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final incidents = ref.watch(studentIncidentsProvider);
    final category = ref.watch(selectedReportCategoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reportsTitle)),
      body: incidents.when(
        loading: () => const LoadingIndicator(),
        error: (_, _) => ErrorView(
          message: AppStrings.couldNotLoadReports,
          onRetry: () => ref.invalidate(studentIncidentsProvider),
        ),
        data: (items) {
          final visible = _filter(items, category);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.sm,
                ),
                child: AppTextField(
                  label: AppStrings.searchReports,
                  hint: AppStrings.searchReports,
                  controller: _searchController,
                  prefixIcon: const Icon(Icons.search),
                  textInputAction: TextInputAction.search,
                  onChanged: (value) => setState(() => _query = value),
                ),
              ),
              _FilterStrip(
                status: _status,
                category: category,
                onStatus: (value) => setState(() => _status = value),
                onCategory: (value) {
                  ref
                      .read(selectedReportCategoryProvider.notifier)
                      .select(value);
                },
              ),
              Expanded(
                child: visible.isEmpty
                    ? EmptyState(
                        message: items.isEmpty && _query.isEmpty
                            ? AppStrings.noReportsYet
                            : AppStrings.noMatchingReports,
                        icon: Icons.assignment_outlined,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        itemCount: visible.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          final incident = visible[index];
                          return IncidentCard(
                            incident: incident,
                            onTap: () => context.push(
                              RouteNames.studentReportDetails(incident.id),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FilterStrip extends StatelessWidget {
  const _FilterStrip({
    required this.status,
    required this.category,
    required this.onStatus,
    required this.onCategory,
  });

  final _StatusFilter status;
  final IncidentCategory? category;
  final ValueChanged<_StatusFilter> onStatus;
  final ValueChanged<IncidentCategory?> onCategory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSpacing.minTouchTarget + AppSpacing.lg,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          _StatusChip(
            label: AppStrings.all,
            selected: status == _StatusFilter.all,
            onSelected: () => onStatus(_StatusFilter.all),
          ),
          _StatusChip(
            label: AppStrings.pending,
            selected: status == _StatusFilter.pending,
            onSelected: () => onStatus(_StatusFilter.pending),
          ),
          _StatusChip(
            label: AppStrings.inProgress,
            selected: status == _StatusFilter.inProgress,
            onSelected: () => onStatus(_StatusFilter.inProgress),
          ),
          _StatusChip(
            label: AppStrings.resolved,
            selected: status == _StatusFilter.resolved,
            onSelected: () => onStatus(_StatusFilter.resolved),
          ),
          const SizedBox(width: AppSpacing.sm),
          _StatusChip(
            label: AppStrings.allCategories,
            selected: category == null,
            onSelected: () => onCategory(null),
          ),
          for (final value in IncidentCategory.values)
            _StatusChip(
              label: value.label,
              selected: category == value,
              onSelected: () => onCategory(value),
            ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
    );
  }
}
