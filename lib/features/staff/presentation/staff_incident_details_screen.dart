import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/utils/snackbar_helper.dart';
import 'package:campus_care/core/widgets/app_text_field.dart';
import 'package:campus_care/core/widgets/confirm_dialog.dart';
import 'package:campus_care/core/widgets/error_view.dart';
import 'package:campus_care/core/widgets/loading_indicator.dart';
import 'package:campus_care/core/widgets/primary_button.dart';
import 'package:campus_care/features/incidents/data/mock_incident_repository.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';
import 'package:campus_care/features/incidents/presentation/incident_detail_body.dart';
import 'package:campus_care/features/incidents/presentation/incident_providers.dart';

class StaffIncidentDetailsScreen extends ConsumerStatefulWidget {
  const StaffIncidentDetailsScreen({required this.incidentId, super.key});

  final String incidentId;

  @override
  ConsumerState<StaffIncidentDetailsScreen> createState() =>
      _StaffIncidentDetailsScreenState();
}

class _StaffIncidentDetailsScreenState
    extends ConsumerState<StaffIncidentDetailsScreen> {
  final _noteController = TextEditingController();
  IncidentStatus? _status;
  var _seeded = false;
  var _isSaving = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _seed(Incident incident) {
    if (_seeded) {
      return;
    }
    _seeded = true;
    _status = incident.status;
    _noteController.text = incident.staffNote ?? '';
  }

  Future<void> _update() async {
    final status = _status;
    if (status == null) {
      return;
    }
    final confirmed = await ConfirmDialog.show(
      context,
      title: AppStrings.confirmStatusTitle,
      message: AppStrings.confirmStatusMessage(status.label),
      confirmLabel: AppStrings.updateStatus,
    );
    if (!confirmed || !mounted) {
      return;
    }
    setState(() => _isSaving = true);
    try {
      await ref.read(incidentRepositoryProvider).updateStatus(
        id: widget.incidentId,
        status: status,
        staffNote: _noteController.text,
      );
      if (mounted) {
        SnackbarHelper.show(
          context,
          AppStrings.statusUpdatedMessage(status.label),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final incident = ref.watch(incidentByIdProvider(widget.incidentId));
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.staffIncidentDetailsTitle)),
      body: incident.when(
        loading: () => const LoadingIndicator(),
        error: (_, _) => ErrorView(
          message: AppStrings.couldNotLoadIncident,
          onRetry: () =>
              ref.invalidate(incidentByIdProvider(widget.incidentId)),
        ),
        data: (value) {
          if (value == null) {
            return const ErrorView(message: AppStrings.incidentNotFound);
          }
          _seed(value);
          return IncidentDetailBody(
            incident: value,
            footer: _StatusEditor(
              status: _status ?? value.status,
              noteController: _noteController,
              isSaving: _isSaving,
              onStatus: (status) => setState(() => _status = status),
              onSubmit: _update,
            ),
          );
        },
      ),
    );
  }
}

class _StatusEditor extends StatelessWidget {
  const _StatusEditor({
    required this.status,
    required this.noteController,
    required this.isSaving,
    required this.onStatus,
    required this.onSubmit,
  });

  final IncidentStatus status;
  final TextEditingController noteController;
  final bool isSaving;
  final ValueChanged<IncidentStatus> onStatus;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(AppStrings.updateStatus, style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final value in IncidentStatus.values)
              ChoiceChip(
                label: Text(value.label),
                selected: status == value,
                onSelected: (_) => onStatus(value),
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          label: AppStrings.staffNote,
          hint: AppStrings.statusNoteHint,
          controller: noteController,
          maxLines: 3,
          minLines: 2,
          textCapitalization: TextCapitalization.sentences,
        ),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: AppStrings.updateStatus,
          isLoading: isSaving,
          onPressed: onSubmit,
        ),
      ],
    );
  }
}
