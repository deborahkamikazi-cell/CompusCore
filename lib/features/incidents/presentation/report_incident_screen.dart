import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/router/route_names.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/utils/snackbar_helper.dart';
import 'package:campus_care/core/widgets/app_text_field.dart';
import 'package:campus_care/core/widgets/category_icon.dart';
import 'package:campus_care/core/widgets/photo_preview.dart';
import 'package:campus_care/core/widgets/primary_button.dart';
import 'package:campus_care/features/auth/presentation/auth_controller.dart';
import 'package:campus_care/features/incidents/data/mock_incident_repository.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';
import 'package:campus_care/features/incidents/domain/incident_category.dart';
import 'package:campus_care/features/incidents/domain/incident_priority.dart';
import 'package:campus_care/features/incidents/domain/incident_status.dart';
import 'package:campus_care/features/incidents/presentation/incident_providers.dart';

class ReportIncidentScreen extends ConsumerStatefulWidget {
  const ReportIncidentScreen({super.key});

  @override
  ConsumerState<ReportIncidentScreen> createState() =>
      _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends ConsumerState<ReportIncidentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _buildingController = TextEditingController();
  final _floorController = TextEditingController();
  final _roomController = TextEditingController();
  final _picker = ImagePicker();

  IncidentCategory? _category;
  IncidentPriority _priority = IncidentPriority.medium;
  final List<String> _photos = [];
  String? _categoryError;
  var _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  Future<void> _pick(ImageSource source) async {
    try {
      final file = await _picker.pickImage(source: source, imageQuality: 70);
      if (file == null || !mounted) {
        return;
      }
      setState(() => _photos.add(file.path));
    } catch (_) {
      if (mounted) {
        SnackbarHelper.show(context, AppStrings.photoPickFailed);
      }
    }
  }

  Future<void> _submit() async {
    final categoryMissing = _category == null;
    setState(() => _categoryError = categoryMissing ? AppStrings.categoryRequired : null);
    final formValid = _formKey.currentState?.validate() ?? false;
    if (!formValid || categoryMissing || _category == null) {
      return;
    }
    final user = ref.read(authControllerProvider).user;
    if (user == null) {
      return;
    }
    setState(() => _isSubmitting = true);
    try {
      final now = DateTime.now().toUtc();
      final created = await ref.read(incidentRepositoryProvider).create(
        Incident(
          id: '',
          referenceNumber: '',
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          category: _category!,
          location: IncidentLocation(
            building: _buildingController.text.trim(),
            floor: _blankToNull(_floorController.text),
            room: _blankToNull(_roomController.text),
          ),
          priority: _priority,
          status: IncidentStatus.submitted,
          imageUrls: List<String>.of(_photos),
          reportedBy: user.uid,
          reporterName: user.reporterShortName,
          createdAt: now,
          updatedAt: now,
        ),
      );
      ref.read(lastSubmittedIncidentProvider.notifier).remember(created);
      if (mounted) {
        context.go(RouteNames.studentReportSuccess);
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  String? _blankToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  String? _required(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reportIncidentHeading)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              AppTextField(
                label: '${AppStrings.titleLabel} ${AppStrings.requiredMarker}',
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                validator: (value) => _required(value, AppStrings.titleRequired),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '${AppStrings.categoryLabel} ${AppStrings.requiredMarker}',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final category in IncidentCategory.values)
                    FilterChip(
                      avatar: CategoryIcon(category: category, size: 18),
                      label: Text(category.label),
                      selected: _category == category,
                      onSelected: (_) {
                        setState(() {
                          _category = category;
                          _categoryError = null;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                ],
              ),
              if (_categoryError != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _categoryError!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              AppTextField(
                label:
                    '${AppStrings.descriptionLabel} ${AppStrings.requiredMarker}',
                controller: _descriptionController,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 4,
                minLines: 3,
                validator: (value) =>
                    _required(value, AppStrings.descriptionRequired),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(AppStrings.locationLabel, style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: '${AppStrings.buildingLabel} ${AppStrings.requiredMarker}',
                controller: _buildingController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: (value) =>
                    _required(value, AppStrings.locationRequired),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: AppStrings.floorLabel,
                controller: _floorController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppTextField(
                label: AppStrings.roomLabel,
                controller: _roomController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(AppStrings.photosLabel, style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pick(ImageSource.camera),
                      icon: const Icon(Icons.photo_camera_outlined),
                      label: const Text(AppStrings.camera),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pick(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library_outlined),
                      label: const Text(AppStrings.gallery),
                    ),
                  ),
                ],
              ),
              if (_photos.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  height: AppSpacing.logoMark + AppSpacing.xl,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _photos.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(width: AppSpacing.sm),
                    itemBuilder: (context, index) {
                      return PhotoPreview(
                        path: _photos[index],
                        onRemove: () => setState(() => _photos.removeAt(index)),
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              Text(AppStrings.priorityLabel, style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final priority in IncidentPriority.values)
                    ChoiceChip(
                      label: Text(priority.label),
                      selected: _priority == priority,
                      onSelected: (_) => setState(() => _priority = priority),
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: AppStrings.submitReport,
                isLoading: _isSubmitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
