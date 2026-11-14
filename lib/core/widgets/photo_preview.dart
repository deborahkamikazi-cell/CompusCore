import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';

import 'package:campus_care/core/constants/app_strings.dart';
import 'package:campus_care/core/theme/app_spacing.dart';

class PhotoPreview extends StatelessWidget {
  const PhotoPreview({
    required this.path,
    this.size = AppSpacing.logoMark + AppSpacing.md,
    this.onRemove,
    super.key,
  });

  final String path;
  final double size;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
              child: _image(context),
            ),
          ),
          if (onRemove != null)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                tooltip: AppStrings.removePhoto,
                onPressed: onRemove,
                icon: const Icon(Icons.close),
              ),
            ),
        ],
      ),
    );
  }

  Widget _image(BuildContext context) {
    if (path.startsWith('http')) {
      return CachedNetworkImage(imageUrl: path, fit: BoxFit.cover);
    }
    final file = File(path);
    if (!file.existsSync()) {
      return const ColoredBox(
        color: Colors.transparent,
        child: Icon(Icons.image_not_supported_outlined),
      );
    }
    return Image.file(file, fit: BoxFit.cover);
  }
}
