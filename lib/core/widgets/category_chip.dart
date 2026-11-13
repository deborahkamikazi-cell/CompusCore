import 'package:material_ui/material_ui.dart';

import 'package:campus_care/features/incidents/domain/incident_category.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({required this.category, super.key});

  final IncidentCategory category;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(category.label),
      visualDensity: VisualDensity.compact,
    );
  }
}
