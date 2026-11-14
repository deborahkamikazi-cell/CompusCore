import 'package:material_ui/material_ui.dart';

import 'package:campus_care/features/incidents/domain/incident_category.dart';

IconData iconForCategory(IncidentCategory category) {
  return switch (category) {
    IncidentCategory.water => Icons.water_drop_outlined,
    IncidentCategory.electricity => Icons.bolt_outlined,
    IncidentCategory.wifi => Icons.wifi_off_outlined,
    IncidentCategory.furniture => Icons.chair_outlined,
    IncidentCategory.sanitation => Icons.delete_outline,
    IncidentCategory.safety => Icons.health_and_safety_outlined,
    IncidentCategory.other => Icons.more_horiz,
  };
}

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    required this.category,
    this.size = 24,
    super.key,
  });

  final IncidentCategory category;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconForCategory(category),
      size: size,
      color: Theme.of(context).colorScheme.primary,
      semanticLabel: category.label,
    );
  }
}
