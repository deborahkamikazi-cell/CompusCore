import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_spacing.dart';

/// Shared body for placeholder screens so each route can still own its Scaffold.
class PlaceholderBody extends StatelessWidget {
  const PlaceholderBody({
    required this.title,
    this.subtitle,
    this.children = const [],
    super.key,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(title, style: textTheme.headlineSmall),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(subtitle!, style: textTheme.bodyLarge),
        ],
        if (children.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          ...children,
        ],
      ],
    );
  }
}
