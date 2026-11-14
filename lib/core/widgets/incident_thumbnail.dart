import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/theme/app_colors.dart';
import 'package:campus_care/core/theme/app_spacing.dart';
import 'package:campus_care/core/widgets/category_icon.dart';
import 'package:campus_care/features/incidents/domain/incident.dart';

class IncidentThumbnail extends StatelessWidget {
  const IncidentThumbnail({
    required this.incident,
    this.size = AppSpacing.thumbnail,
    super.key,
  });

  final Incident incident;
  final double size;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSpacing.inputRadius);
    return ClipRRect(
      borderRadius: radius,
      child: SizedBox(
        width: size,
        height: size,
        child: _image(context),
      ),
    );
  }

  Widget _image(BuildContext context) {
    final url = incident.imageUrls.isEmpty ? null : incident.imageUrls.first;
    if (url == null || url.isEmpty) {
      return _fallback(context);
    }
    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (_, _) => _fallback(context),
        errorWidget: (_, _, _) => _fallback(context),
      );
    }
    final file = File(url);
    if (!file.existsSync()) {
      return _fallback(context);
    }
    return Image.file(file, fit: BoxFit.cover);
  }

  Widget _fallback(BuildContext context) {
    return ColoredBox(
      color: AppColors.inProgressBackground,
      child: Center(child: CategoryIcon(category: incident.category)),
    );
  }
}
